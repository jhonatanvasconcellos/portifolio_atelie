import 'package:flutter/material.dart';

abstract final class AppSpacing {
  AppSpacing._(); 

  static const double space4 = 4.0;
  static const double space8 = 8.0;
  static const double space12 = 12.0;
  static const double space16 = 16.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space32 = 32.0;

  // --- Espaçamento Vertical ---
  static const vertical4 = SizedBox(height: space4);
  static const vertical8 = SizedBox(height: space8);
  static const vertical12 = SizedBox(height: space12);
  static const vertical16 = SizedBox(height: space16);
  static const vertical20 = SizedBox(height: space20);
  static const vertical24 = SizedBox(height: space24);
  static const vertical32 = SizedBox(height: space32);

  // --- Espaçamento Horizontal ---
  static const horizontal4 = SizedBox(width: space4);
  static const horizontal8 = SizedBox(width: space8);
  static const horizontal12 = SizedBox(width: space12);
  static const horizontal16 = SizedBox(width: space16);
  static const horizontal20 = SizedBox(width: space20);
  static const horizontal24 = SizedBox(width: space24);
  static const horizontal32 = SizedBox(width: space32);
}