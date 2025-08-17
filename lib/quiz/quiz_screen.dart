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

  bool _didInit = false; // דגל כדי להריץ פעם אחת

  @override
  void initState() {
    super.initState();
    // חשוב: לא להשתמש ב-context כאן
  }

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

  void _answer(int tappedIndex) {
    final q = _picked[_idx];
    final correct = tappedIndex == q.correctIndex;
    if (correct) _score++;
    final isLast = _idx == _picked.length - 1;

    if (!isLast) {
      setState(() => _idx++);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (_) => QuizResultScreen(score: _score, total: _picked.length),
        ),
      );
    }
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

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Text(
                  q.question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                ...List.generate(q.answers.length, (i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _answer(i),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: purple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(q.answers[i], textAlign: TextAlign.center),
                      ),
                    ),
                  );
                }),
                const Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }
}
