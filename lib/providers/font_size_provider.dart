import 'package:flutter/material.dart';

class FontSizeNotifier extends ChangeNotifier {
  double _scale = 1.0; // Medium = 1.0
  double get scale => _scale;

  void setMedium() {
    _scale = 1.0;
    notifyListeners();
  }

  void setLarge() {
    _scale = 1.3; // Large ≈ 30 % יותר
    notifyListeners();
  }
}
