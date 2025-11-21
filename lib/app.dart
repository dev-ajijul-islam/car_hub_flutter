import 'package:car_hub/ui/screens/language_select_screen.dart';
import 'package:car_hub/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class CarHub extends StatelessWidget {
  const CarHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Color(0xFF930405),
          onPrimary: Colors.white,
          surface: Colors.grey.shade100,
          onSurface: Colors.black87,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: Size(MediaQuery.of(context).size.width, 40),
          ),
        ),
      ),

      //routes
      routes: {
        SplashScreen.name: (_) => SplashScreen(),
        LanguageSelectScreen.name: (_) => LanguageSelectScreen(),
      },
      initialRoute: SplashScreen.name,
    );
  }
}
