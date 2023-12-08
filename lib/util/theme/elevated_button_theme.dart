import 'package:countify/util/theme/text_theme.dart';
import 'package:flutter/material.dart';

class AppButtonTheme {
  static const elevation = 10.0;
  static const borderRadius = 10.0;
  static ElevatedButtonThemeData getTheme() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStatePropertyAll(
          AppTextTheme.bodyMedium().copyWith(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        elevation: const MaterialStatePropertyAll(
          elevation,
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
