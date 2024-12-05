import 'package:flutter/material.dart';

class AppTypography {
  TextStyle get headline => const TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        fontFamily: 'Inter',
      );

  TextStyle get body1 => const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        fontFamily: 'Inter',
      );

  TextStyle get body2 => const TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w400,
        fontFamily: 'Inter',
      );

  TextStyle get buttonText => const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
        fontFamily: 'Inter',
      );
}
