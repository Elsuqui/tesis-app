import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Themes {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: const Color(0xFFF6F7EB),
    scaffoldBackgroundColor: const Color(0xFFF6F7EB),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF393E41),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFE94F37),
    ),
    colorScheme: const ColorScheme.light().copyWith(
      primary: const Color(0xFFE94F37),
      secondary: const Color(0xFF393E41),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all<Color>(const Color(0xFFE94F37)),
        foregroundColor:
            WidgetStateProperty.all<Color>(const Color(0xFFF6F7EB)),
      ),
    ),
  );
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: const Color(0xFF03DAC6),
    scaffoldBackgroundColor: const Color(0xFF03DAC6),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF03DAC6),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF6200EE),
    ),
  );
}
