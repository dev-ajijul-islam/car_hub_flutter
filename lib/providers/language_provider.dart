import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String _currentLanguage = "en_US";

  String get currentLanguage => _currentLanguage;

  void changeLanguage(BuildContext context, language) {
    if(language == "en_US"){
      context.setLocale(Locale("en","US"));
    }else{
      context.setLocale(Locale("bn"));
    }
    _currentLanguage = language;
    notifyListeners();
  }
}
