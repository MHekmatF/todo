import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String languageCode = 'en';

  String get backgroundImageName =>
      themeMode == ThemeMode.light ? "default_bg" : "dark_bg";

  void changeTheme(ThemeMode selectedTheme) {
    themeMode = selectedTheme;
    notifyListeners();
  }

  void changeLanguage(String selectedLanguage) {
    if (selectedLanguage == languageCode) return;

    languageCode = selectedLanguage;
    notifyListeners();
  }
}
