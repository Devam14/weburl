import 'package:bubble_gpt/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonWidgets {
  static Widget getAnnanotaion(
      {required Widget child, Color? color, bool? isDart}) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDart == true
          ? SystemUiOverlayStyle.dark
              .copyWith(statusBarColor: color ?? AppColors.black)
          : SystemUiOverlayStyle.light
              .copyWith(statusBarColor: color ?? AppColors.black),
      child: child,
    );
  }
}
