import 'package:flutter/material.dart';
import 'package:texttospeechapp/colors/colors.dart';

class FontSizeProvider extends ChangeNotifier {
  double _fontSize = 18.0;

  double get fontSize => _fontSize;

  void setFontSize(double newSize) {
    _fontSize = newSize;
    notifyListeners();
  }
}
