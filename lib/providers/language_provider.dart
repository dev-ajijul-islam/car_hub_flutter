import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String _currentLanguage = "en_US";

  String get currentLanguage => _currentLanguage;

  void changeLanguage(BuildContext context, language) {
    _currentLanguage = language;
    notifyListeners();
  }
}
