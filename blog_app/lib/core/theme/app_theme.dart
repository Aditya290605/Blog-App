import 'package:blog_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,

      iconTheme: IconThemeData(color: AppPallete.whiteColor),
    ),
    chipTheme: ChipThemeData(
      color: WidgetStatePropertyAll(AppPallete.backgroundColor),
      side: BorderSide.none,
    ),

    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),

        borderSide: BorderSide(color: AppPallete.gradient2, width: 3.0),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),

        borderSide: BorderSide(color: AppPallete.borderColor, width: 3.0),
      ),
    ),
  );
}
