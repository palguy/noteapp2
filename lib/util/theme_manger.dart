import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeManager extends ChangeNotifier {
  final Box _box = Hive.box('settingsBox');
  bool _isDarkMode = false;

  ThemeManager() {
    _isDarkMode = _box.get('isDarkMode', defaultValue: false);
  }

  bool get isDarkMode => _isDarkMode;

  ThemeMode get currentTheme => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _box.put('isDarkMode', _isDarkMode);
    notifyListeners();
  }
}
