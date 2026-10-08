import 'dart:async';

import 'package:flutter/material.dart';

import 'taxi_fare_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _navigationTimer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const TaxiFareScreen()),
      );
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 460),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7FC),
              border: Border.all(color: const Color(0xFFBDBDBD)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/taxi.png',
                  width: 250,
                  height: 220,
                  fit: BoxFit.contain,
                  semanticLabel: 'ภาพรถแท็กซี่สีเหลือง',
                ),
                const SizedBox(height: 18),
                Text(
                  'Taxi Fare Calculator',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: const Color(0xFF58A9F5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'คำนวณค่าโดยสารแท็กซี่',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xFF58A9F5),
                  ),
                ),
                const SizedBox(height: 28),
                const SizedBox(
                  width: 42,
                  height: 42,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    color: Color(0xFFFFC107),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
