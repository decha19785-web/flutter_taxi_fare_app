import 'package:flutter/material.dart';

import 'splash_screen.dart';

void main() {
  runApp(const TaxiFareApp());
}

class TaxiFareApp extends StatelessWidget {
  const TaxiFareApp({super.key});

  static const Color taxiYellow = Color(0xFFFFC107);
  static const Color pageBackground = Color(0xFFFFF7FC);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxi Fare Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: pageBackground,
        colorScheme: ColorScheme.fromSeed(seedColor: taxiYellow),
        appBarTheme: const AppBarTheme(
          backgroundColor: taxiYellow,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
