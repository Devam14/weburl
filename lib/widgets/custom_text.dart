import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final int maxLine;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final double textSpacing;
  final Color background;

  const CustomText({
    super.key,
    required this.text,
    this.fontSize = 18,
    this.maxLine = 1,
    this.textSpacing = 0.5,
    this.color = AppColors.black,
    this.textAlign = TextAlign.start,
    this.background = Colors.transparent,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          backgroundColor: background,
          color: color),
    );
  }
}

class CustomUnderlineText extends StatelessWidget {
  final String text;
  final double fontSize;
  final int maxLine;
  final Color color;
  final FontWeight fontWeight;
  final double textSpacing;
  final TextAlign textAlign;
  final String fontFamily;

  const CustomUnderlineText(
      {super.key,
      required this.text,
      this.fontSize = 18,
      this.textSpacing = 0.5,
      this.maxLine = 1,
      this.color = AppColors.black,
      required this.textAlign,
      required this.fontFamily,
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      style: TextStyle(
          decoration: TextDecoration.underline,
          fontSize: fontSize,
          fontFamily: fontFamily,
          fontWeight: fontWeight,
          color: color),
    );
  }
}
