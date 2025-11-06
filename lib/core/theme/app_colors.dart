import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primarySeed = Colors.teal;

  static const Color dark = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  static final Color success = Colors.green[600]!;
  static final Color error = Colors.red[700]!;
  static final Color accentBrown = Colors.brown[300]!;

  static final Color textPrimary = Colors.grey[900]!;
  static final Color textSecondary = Colors.grey[700]!;
  static final Color textLight = Colors.grey[600]!;

}
extension ColorOpacityExtension on Color {
  Color withOpacityCompat(double opacity) {
    return withAlpha((opacity * 255).toInt());
  }
}
