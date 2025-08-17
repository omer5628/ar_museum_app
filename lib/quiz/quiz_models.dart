import 'dart:math';

class QuizQuestion {
  final String question;
  final List<String> answers; // 4 תשובות לתצוגה
  final int correctIndex; // אינדקס התשובה הנכונה ב-answers

  const QuizQuestion({
    required this.question,
    required this.answers,
    required this.correctIndex,
  });

  factory QuizQuestion.fromMap(Map<String, dynamic> m) {
    final q = (m['q'] as String).trim();
    final raw = (m['answers'] as List).cast<String>();

    int correct = -1;
    final cleaned = <String>[];
    for (var i = 0; i < raw.length; i++) {
      var t = raw[i];
      if (t.contains('(+)')) {
        correct = i;
        t = t.replaceAll(RegExp(r'\s*\(\+\)\s*'), '').trim();
      }
      cleaned.add(t);
    }
    if (correct == -1) {
      throw StateError('No (+) correct answer in: $q');
    }
    return QuizQuestion(question: q, answers: cleaned, correctIndex: correct);
  }

  /// מערבב את סדר התשובות ושומר על האינדקס הנכון
  QuizQuestion shuffled() {
    final pairs = List.generate(answers.length, (i) => MapEntry(i, answers[i]));
    pairs.shuffle(Random());
    final newAnswers = pairs.map((e) => e.value).toList();
    final newCorrect = pairs.indexWhere((e) => e.key == correctIndex);
    return QuizQuestion(
      question: question,
      answers: newAnswers,
      correctIndex: newCorrect,
    );
  }
}
