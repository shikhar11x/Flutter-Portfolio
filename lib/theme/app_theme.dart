import 'package:flutter/material.dart';

class AppTheme {
  static const Color bg = Color(0xFF080808);
  static const Color surface = Color(0xFF111111);
  static const Color cardBg = Color(0x0AFFFFFF);
  static const Color cardBorder = Color(0x17FFFFFF);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0x73FFFFFF);
  static const Color textMuted = Color(0x40FFFFFF);
  static const Color green = Color(0xFF4ADE80);
  static const Color white12 = Color(0x1FFFFFFF);
  static const Color white06 = Color(0x0FFFFFFF);

  static ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: bg,
        colorScheme: const ColorScheme.dark(surface: bg),
        fontFamily: 'SF Pro Display',
        useMaterial3: true,
      );
}
