import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color background = Color(0xFFFAFAFA);
  static const Color primaryText = Color(0xFF0F0F0F);
  static const Color secondaryText = Color(0xFF6B6B6B);
  static const Color accent = Color(0xFFB3001B);
  static const Color surface = Colors.white;

  // Text Styles
  static TextStyle get headlineLarge => GoogleFonts.playfairDisplay(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: primaryText,
      );

  static TextStyle get headlineMedium => GoogleFonts.playfairDisplay(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: primaryText,
      );

  static TextStyle get bodyLarge => GoogleFonts.ibmPlexSerif(
        fontSize: 18,
        color: primaryText,
        height: 1.6, // Generous line spacing
      );

  static TextStyle get bodyMedium => GoogleFonts.ibmPlexSerif(
        fontSize: 16,
        color: primaryText,
        height: 1.5,
      );

  static TextStyle get caption => GoogleFonts.ibmPlexSerif(
    fontSize: 14,
    color: secondaryText,
  );

  static TextStyle get buttonText => GoogleFonts.ibmPlexSerif(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      primaryColor: accent,
      colorScheme: ColorScheme.fromSeed(
        seedColor: accent,
        background: background,
        surface: surface,
        primary: accent,
        onPrimary: Colors.white,
        secondary: secondaryText,
        onSurface: primaryText,
      ),
      textTheme: TextTheme(
        displayLarge: headlineLarge,
        displayMedium: headlineMedium,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        labelLarge: buttonText,
        bodySmall: caption,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: primaryText),
        titleTextStyle: headlineMedium.copyWith(color: primaryText),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: accent,
        unselectedItemColor: secondaryText,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.ibmPlexSerif(fontSize: 12),
        unselectedLabelStyle: GoogleFonts.ibmPlexSerif(fontSize: 12),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: Colors.white,
          textStyle: buttonText,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accent,
          textStyle: buttonText.copyWith(color: accent),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.transparent, // Minimalist
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintStyle: bodyMedium.copyWith(color: secondaryText.withOpacity(0.5)),
      ),
    );
  }
}
