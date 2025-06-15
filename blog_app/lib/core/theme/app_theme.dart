import 'package:blog_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,

      iconTheme: IconThemeData(color: AppPallete.whiteColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),

        borderSide: BorderSide(color: AppPallete.borderColor, width: 3.0),
      ),
    ),
  );
}
