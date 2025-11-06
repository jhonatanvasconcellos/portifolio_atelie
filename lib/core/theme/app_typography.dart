import 'package:atelie_portifolio/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  static final _titleFont = GoogleFonts.playfairDisplay;
  static final _bodyFont = GoogleFonts.roboto;


  static final TextStyle appBarTitle = _titleFont(
    fontWeight: FontWeight.w700,
    fontSize: 22, 
    color: AppColors.white, 
  );

  static final TextStyle headlineSmall = _titleFont(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: AppColors.textPrimary,
  );

  static final TextStyle titleCard = _bodyFont(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: AppColors.textPrimary,
  );

  static final TextStyle bodyLarge = _bodyFont(
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static final TextStyle bodyMedium = _bodyFont(
    fontWeight: FontWeight.normal,
    fontSize: 14,
    color: AppColors.textSecondary,
    height: 1.5,
  );
  
  static final TextStyle bodySmall = _bodyFont(
    fontWeight: FontWeight.normal,
    fontSize: 12,
    color: AppColors.textLight,
    height: 1.4,
  );

  static final TextStyle button = _bodyFont(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
}