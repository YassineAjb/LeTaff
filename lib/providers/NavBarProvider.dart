import 'package:flutter/material.dart';

class NavBarProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void updateIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners(); // This notifies all listeners that the index has changed
  }
}
