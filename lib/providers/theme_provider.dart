import 'package:flutter/material.dart';
import 'package:design_command/themes/theme_names.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeNames _currentTheme = ThemeNames.pureWhite;

  ThemeNames get currentTheme => _currentTheme;

  void setTheme(ThemeNames t) {
    _currentTheme = t;
    notifyListeners();
  }
}
