import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sign_up/sign_up/sign_up.dart';
import 'package:sign_up/theme/custom_theme.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: CustomTheme(
        child: SignUpScreen(),
      ),
    );
  }
}
