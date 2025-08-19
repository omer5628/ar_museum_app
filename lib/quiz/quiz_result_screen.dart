import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'quiz_screen.dart';

class QuizResultScreen extends StatelessWidget {
  const QuizResultScreen({super.key, required this.score, required this.total});
  final int score;
  final int total;

  String _remarkText(BuildContext context) {
    final ratio = total == 0 ? 0.0 : score / total;
    if (ratio <= 0.50) return tr('resultTryAgain'); // 0–50%
    if (ratio <= 0.80) return tr('resultNice'); // 51–80%
    return tr('resultWellDone'); // 81–100%
  }

  @override
  Widget build(BuildContext context) {
    final purple = const Color.fromARGB(255, 38, 2, 102);
    return Scaffold(
      appBar: AppBar(title: Text(tr('quiz'))),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tr('yourScore'),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              '$score ${tr('outOf')} $total',
              style: const TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),
            Text(
              _remarkText(context),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => QuizScreen()),
                    ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: purple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(tr('playAgain')),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(tr('backHome')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
