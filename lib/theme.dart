import 'package:flutter/material.dart';

class RamonTheme {
  // Accessible High-Contrast Core Colors (HCI Compliant)
  static const Color background = Colors.white;
  static const Color primaryText = Color(0xFF121212);
  static const Color primaryBlue = Color(0xFF0059B3);

  // Tech Gradient Accent
  static const List<Color> techGradient = [
    Color(0xFF0A1931),
    Color(0xFF00AEEF),
  ];

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      primaryColor: primaryBlue,
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: primaryText, fontWeight: FontWeight.bold, fontSize: 32),
        headlineMedium: TextStyle(color: primaryText, fontWeight: FontWeight.bold, fontSize: 22),
        bodyMedium: TextStyle(color: primaryText, fontSize: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
    );
  }
}