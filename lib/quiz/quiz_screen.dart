import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'quiz_result_screen.dart';
import 'quiz_models.dart';
import 'quiz_loader.dart';

class QuizScreen extends StatefulWidget {
  QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Future<List<QuizQuestion>> _future;
  late List<QuizQuestion> _picked;
  int _idx = 0;
  int _score = 0;

  int? _selected; // אינדקס התשובה שנבחרה
  bool _reveal = false; // האם להראות נכון/שגוי

  bool _didInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didInit) return;
    _didInit = true;

    _future = QuizLoader.load(context).then((all) {
      all.shuffle();
      _picked = all.take(10).map((q) => q.shuffled()).toList();
      return _picked;
    });
  }

  void _onAnswer(int i) {
    if (_reveal) return; // לא מאפשרים לשנות אחרי בחירה
    final q = _picked[_idx];
    final isCorrect = i == q.correctIndex;

    setState(() {
      _selected = i;
      _reveal = true;
      if (isCorrect) _score++;
    });

    // ScaffoldMessenger.of(context)
    //   ..hideCurrentSnackBar()
    //   ..showSnackBar(
    //     SnackBar(
    //       content: Text(isCorrect ? tr('quiz.correct') : tr('quiz.incorrect')),
    //       duration: const Duration(milliseconds: 900),
    //     ),
    //   );
  }

  void _next() {
    if (_selected == null) return;
    final isLast = _idx == _picked.length - 1;
    if (isLast) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (_) => QuizResultScreen(score: _score, total: _picked.length),
        ),
      );
    } else {
      setState(() {
        _idx++;
        _selected = null;
        _reveal = false;
      });
    }
  }

  Widget _answerTile(QuizQuestion q, int i, Color purple) {
    final isSelected = _selected == i;
    final isCorrect = i == q.correctIndex;

    Color fill = Colors.transparent;
    Color border = purple.withOpacity(0.25);
    Color text = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black87;
    IconData? trailing;

    if (_reveal) {
      if (isCorrect) {
        fill = Colors.green.shade600;
        border = Colors.green;
        text = Colors.white;
        trailing = Icons.check;
      } else if (isSelected) {
        fill = Colors.red.shade600;
        border = Colors.red;
        text = Colors.white;
        trailing = Icons.close;
      }
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border, width: 2),
      ),
      child: ListTile(
        onTap: _reveal ? null : () => _onAnswer(i),
        title: Text(q.answers[i], style: TextStyle(fontSize: 16, color: text)),
        trailing: trailing == null ? null : Icon(trailing, color: text),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final purple = const Color.fromARGB(255, 38, 2, 102);

    return Scaffold(
      appBar: AppBar(title: Text(tr('quiz'))),

      body: FutureBuilder<List<QuizQuestion>>(
        future: _future,
        builder: (ctx, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }

          final q = _picked[_idx];

          return SafeArea(
            // גם הגוף בתוך SafeArea ליתר ביטחון
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // מונה שאלה
                  Text(
                    '${_idx + 1}/${_picked.length}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // השאלה
                  Text(
                    q.question,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // תשובות
                  ...List.generate(
                    q.answers.length,
                    (i) => _answerTile(q, i, purple),
                  ),

                  const Spacer(),
                  // (כפתור ה-Next עבר ל-bottomNavigationBar)
                ],
              ),
            ),
          );
        },
      ),

      // ➜ הכפתור עבר לכאן – עטוף ב-SafeArea, כך שהוא תמיד מעל כפתורי המערכת
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (_selected == null) ? null : _next,
            style: ElevatedButton.styleFrom(
              backgroundColor: purple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(tr('next')),
          ),
        ),
      ),
    );
  }
}
