import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'quiz_models.dart';

class QuizLoader {
  static String _pathFor(String lang) {
    switch (lang) {
      case 'he':
        return 'assets/quiz/quiz_he.json';
      case 'ru':
        return 'assets/quiz/quiz_ru.json';
      default:
        return 'assets/quiz/quiz_en.json';
    }
  }

  static Future<List<QuizQuestion>> load(BuildContext context) async {
    final code = context.locale.languageCode;

    // ננסה קודם את שפת המשתמש, ואם אין—ניפול ל-en ואז ל-he
    for (final p in <String>[_pathFor(code), _pathFor('en'), _pathFor('he')]) {
      try {
        final raw = await rootBundle.loadString(p);
        final list = (json.decode(raw) as List).cast<Map<String, dynamic>>();
        return list.map((m) => QuizQuestion.fromMap(m)).toList();
      } catch (_) {
        // ננסה קובץ גיבוי הבא
      }
    }
    throw StateError('Quiz JSON not found for $code');
  }
}
