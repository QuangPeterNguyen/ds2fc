
import 'package:flutter/material.dart';
import 'theme.dart';

class AppTextStyles {
  static TextStyle headline(BuildContext context) => TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );

  static TextStyle sectionTitle(BuildContext context) => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Theme.of(context).textTheme.bodyLarge?.color,
  );

  static TextStyle body(BuildContext context) => TextStyle(
    fontSize: 16,
    height: 1.5,
    color: Theme.of(context).textTheme.bodyMedium?.color,
  );

  static TextStyle caption(BuildContext context) => TextStyle(
    fontSize: 14,
    color: Theme.of(context).textTheme.bodySmall?.color,
  );
}