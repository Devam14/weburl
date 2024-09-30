import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final Color buttonColor;
  final String buttonText;
  final Color textColor;
  final Color borderColor;
  final double? height;
  final double? width;
  final double radius;
  final bool isBackArrow;
  final bool isBoarder;
  final GestureTapCallback onPressed;

  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.buttonColor,
      required this.buttonText,
      this.width,
      this.height,
      this.radius = 10,
      this.isBackArrow = false,
      this.isBoarder = false,
      this.textColor = AppColors.white,
      this.borderColor = AppColors.primaryColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
                side: isBoarder
                    ? BorderSide(
                        color: borderColor, width: 1, style: BorderStyle.solid)
                    : const BorderSide(
                        color: Colors.transparent,
                        width: 1,
                        style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(radius))),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: isBackArrow
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: <Widget>[
            CustomText(
              text: buttonText,
              textAlign: TextAlign.start,
              fontSize: 16,
              color: textColor,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}
