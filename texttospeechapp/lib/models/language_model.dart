import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  late String _selectedLanguage;

  LanguageProvider() {
    // Initialize _selectedLanguage to a default value
    _selectedLanguage = 'English'; // Replace with your default language
  }

  String get selectedLanguage => _selectedLanguage;

  void setSelectedLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }
}
