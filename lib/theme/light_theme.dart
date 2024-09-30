import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

ThemeData basicTheme(BuildContext context) {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: AppColors.primaryColor,
    secondaryHeaderColor: AppColors.secondaryColor,
    disabledColor: AppColors.secondaryColor,
    brightness: Brightness.light,
    hintColor: AppColors.hintColor,
    cardColor: Colors.white,
    textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
    inputDecorationTheme: const InputDecorationTheme(),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.primaryColor)),
    colorScheme: const ColorScheme.light(
            primary: AppColors.primaryColor,
            secondary: AppColors.primaryColor,
            surface: AppColors.white)
        .copyWith(surface: AppColors.white),
  );
}
