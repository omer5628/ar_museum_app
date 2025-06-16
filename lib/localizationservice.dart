import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocalizationService extends ChangeNotifier {
  LocalizationService(this.locale) {
    loadLocaleFile(locale);
  }

  String locale;

  late Map<String, dynamic> _localizedValues;

  Future<void> loadLocaleFile(String locale) async {
    this.locale = locale;
    _localizedValues = {};

    try {
      String raw = await rootBundle.loadString('assets/translations/$locale.json'); 
      _localizedValues = json.decode(raw);
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading locale $locale: $e');
    }
  }

  String translate(String key) {
    return _localizedValues[key] ?? key;
  }

  void changeLocale(String newLocale) {
    loadLocaleFile(newLocale);
  }
}
