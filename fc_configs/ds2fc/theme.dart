import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF50BFE6);
  static const secondary = Color(0xFF003366);
  static const background = Colors.white;
  static const text = Colors.black87;
  static const buttonTextIconColor = Colors.white;
  static const darkBackground = Color(0xFF121212);
  static const darkText = Colors.white;
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: AppColors.background,
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.secondary,
  scaffoldBackgroundColor: AppColors.darkBackground,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.secondary,
    foregroundColor: Colors.white,
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Color(0xFF1E1E1E),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
