import 'package:ecommerce/utils/theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  bool isDark = false;
  ThemeData _themeData = lightTheme;

  ThemeData get themeData => _themeData;

  void toggleTheme() {
    isDark = !isDark;
    _themeData = isDark ? darkTheme : lightTheme;
    
    notifyListeners();
  }
}