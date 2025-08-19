import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  //UserData userData = UserData();
  bool _isDarkTheme = false;

  // Getter for the current theme
  bool get getIsDarkMode => _isDarkTheme;

  // Getter for the ThemeData

  // Toggle the theme

  set setDarkMode(bool value) {
    _isDarkTheme = value;
   // userData.setDarkMode(value);
    notifyListeners();
  }
}