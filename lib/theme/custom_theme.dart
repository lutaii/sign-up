import 'package:flutter/material.dart';
import 'package:sign_up/theme/app_colors.dart';
import 'package:sign_up/theme/app_theme.dart';
import 'package:sign_up/theme/app_typography.dart';

class CustomTheme extends StatefulWidget {
  final Widget child;

  const CustomTheme({super.key, required this.child});

  static ThemeInheritedWidget of(BuildContext context) {
    final ThemeInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<ThemeInheritedWidget>();
    assert(result != null, 'No ThemeInheritedWidget found in context');

    return result!;
  }

  @override
  State<CustomTheme> createState() => _CustomThemeState();
}

class _CustomThemeState extends State<CustomTheme> {
  AppTheme theme = AppTheme(colors: AppColors(), typography: AppTypography());

  @override
  Widget build(BuildContext context) {
    return ThemeInheritedWidget(
      theme: theme,
      child: widget.child,
    );
  }
}

class ThemeInheritedWidget extends InheritedWidget {
  final AppTheme theme;

  const ThemeInheritedWidget({
    super.key,
    required this.theme,
    required super.child,
  });

  AppColors get colors => theme.colors;

  AppTypography get typography => theme.typography;

  @override
  bool updateShouldNotify(ThemeInheritedWidget oldWidget) {
    return theme != oldWidget.theme;
  }
}
