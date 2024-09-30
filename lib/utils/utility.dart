import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';

import 'app_colors.dart';

class Utility {
  static void showToastMessage(message) {
    showToast(
      message,
      context: Get.context!,
      animation: StyledToastAnimation.slideFromBottom,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.top,
      animDuration: const Duration(milliseconds: 500),
      backgroundColor: Colors.black,
      textStyle: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      duration: const Duration(seconds: 3),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
    );
  }

  static Widget progress(BuildContext context, {required Color color}) {
    return Container(
      alignment: Alignment.center,
      color: color,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            backgroundColor: AppColors.black.withOpacity(0.1),
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.black),
          ),
        ),
      ),
    );
  }

  static Future<bool> checkInternet() async {
    // var connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.none) {
    //   return false;
    // } else {
    //   return true;
    // }
    return true;
  }
}
