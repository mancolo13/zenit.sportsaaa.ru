import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Zenit Signature Brand Colors
  static const Color primary = Color(0xFF0077E6); // Zenit Signature Royal Blue
  static const Color primaryDark = Color(0xFF005BB5);
  static const Color primaryLight = Color(0xFF1E90FF);
  static const Color secondary = Color(0xFF00B4D8); // Zenit Sky Cyan
  static const Color accentPurple = Color(0xFF8B5CF6);
  static const Color accentGold = Color(0xFFFFB703); // Zenit Star Gold
  static const Color accentRose = Color(0xFFEF4444);
  static const Color accentOrange = Color(0xFFFB8500);
  static const Color accentGreen = Color(0xFF10B981);

  // Background Surfaces (Zenit Deep Midnight Navy)
  static const Color background = Color(0xFF080E18); // Deep Midnight Navy
  static const Color surface = Color(0xFF0F1726); // Slate Navy Surface
  static const Color surfaceCard = Color(0xFF162238); // Deep Navy Card
  static const Color surfaceElevated = Color(0xFF1E2D4A);
  static const Color surfaceBorder = Color(0xFF243656); // Stately Navy Border

  // Text Colors
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF62728D);

  // Zenit Signature Brand Gradients
  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF0E274A), Color(0xFF091424)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient streakGradient = LinearGradient(
    colors: [Color(0xFF291B05), Color(0xFF0D1420)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient rewardsGradient = LinearGradient(
    colors: [Color(0xFF0A2B3D), Color(0xFF071524)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient profileGradient = LinearGradient(
    colors: [Color(0xFF18263E), Color(0xFF0B1220)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Box Shadows
  static List<BoxShadow> get neonGlow => [
        BoxShadow(
          color: primary.withAlpha(65),
          blurRadius: 20,
          spreadRadius: 1,
        ),
      ];

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: secondary,
        surface: surface,
        error: accentRose,
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme,
      ).apply(
        bodyColor: textPrimary,
        displayColor: textPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          letterSpacing: 0.5,
        ),
        iconTheme: const IconThemeData(color: textPrimary),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: primary,
        unselectedItemColor: textMuted,
        elevation: 8,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
