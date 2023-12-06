import 'package:flutter/material.dart';

class ViewMode with ChangeNotifier {
  bool isGridView = true;

  void toggleView() {
    isGridView = !isGridView;
    notifyListeners(); // Notifies listeners about the change in state
  }
}
