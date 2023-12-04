import 'package:flutter/material.dart';
import 'package:texttospeechapp/colors/colors.dart';

class FontColorProvider extends ChangeNotifier {
  Color _selectedColor = primaryBackground;

  Color get selectedColor => _selectedColor;
  void setFontColor(Color newColor) {
    _selectedColor = newColor;
    notifyListeners();
  }
}
