import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SortOptionNotifier extends ChangeNotifier {
  String _selectedOption = 'Ascending'; // Initial value for dropdown

  String get selectedOption => _selectedOption;

  void setSelectedOption(String option) {
    _selectedOption = option;
    notifyListeners();
  }
}
