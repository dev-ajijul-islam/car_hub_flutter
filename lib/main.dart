import 'package:car_hub/app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
      supportedLocales: [Locale("en","US"),Locale("bn")],
      path: 'assets/translations',
      startLocale: Locale("en","US"),
      fallbackLocale: Locale("en","US"),
      child: CarHub()));
}