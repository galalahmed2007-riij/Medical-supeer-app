import 'package:flutter/material.dart';

class AppThemes {
  // الوضع الفاتح الهادئ المريح للعين
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF00796B), // تيفاني طبي
    scaffoldBackgroundColor: const Color(0xFFF4F7F6), // أبيض عاجي هادئ
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF00796B),
      secondary: Color(0xFF0288D1),
      surface: Colors.white,
      error: Color(0xFFD32F2F),
    ),
    cardColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF00796B),
      foregroundColor: Colors.white,
    ),
  );

  // الوضع الداكن المريح للشفتات الليلية
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF80CBC4),
    scaffoldBackgroundColor: const Color(0xFF121E24), // أزرق داكن جداً
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF80CBC4),
      secondary: Color(0xFF29B6F6),
      surface: Color(0xFF1E2D34),
      error: Color(0xFFEF5350),
    ),
    cardColor: const Color(0xFF1E2D34),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E2D34),
      foregroundColor: Colors.white,
    ),
  );
}
