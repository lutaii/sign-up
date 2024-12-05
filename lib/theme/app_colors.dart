import 'package:flutter/material.dart';

class AppColors {
  Color get successText => const Color(0xFF009796);

  Color get successBorder => const Color(0xFF5CD6C0);

  Color get successAccent => const Color(0xFF5CD6C0).withOpacity(0.1);

  Color get warning => const Color(0xFFED5F59);

  Color get warningAccent => const Color(0xFFED5F59).withOpacity(0.1);

  Color get primary => const Color(0xFF151D51);

  Color get hint => const Color(0xFF6F91BC);

  Color get hintFocused => const Color(0xFF4A4E71);

  Color get suffixIconColor => const Color(0xFF6F91BC);

  Color get rulesInitial => const Color(0xFF4A4E71);

  LinearGradient backgroundGradient = const LinearGradient(
    begin: Alignment(-0.97, -0.25),
    end: Alignment(0.97, 0.25),
    colors: [
      Color(0xFFF4F9FF),
      Color(0xFFE0EDFB),
    ],
  );

  LinearGradient buttonGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF70C3FF),
      Color(0xFF4B65FF),
    ],
  );
}
