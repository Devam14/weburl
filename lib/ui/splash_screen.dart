import 'package:bubble_gpt/generated/assets.dart';
import 'package:bubble_gpt/routes/app_pages.dart';
import 'package:bubble_gpt/utils/app_colors.dart';
import 'package:bubble_gpt/utils/app_constants.dart';
import 'package:bubble_gpt/utils/extension_classes.dart';
import 'package:bubble_gpt/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigate();
    super.initState();
  }

  _navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      if (GetStorage().read(AppConstants.isLoggedIn) != null &&
          GetStorage().read(AppConstants.isLoggedIn)) {
        Get.offAndToNamed(Routes.dashboard);
      } else {
        // Get.offAndToNamed(Routes.login);
        Get.offAndToNamed("/login");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              (MediaQuery.of(context).size.height * 0.2).sbh,
              Expanded(
                child: Lottie.asset(Assets.splashAnimation),
              ),
              const Expanded(
                child: CustomText(
                    text: "Bubble GPT",
                    fontSize: 30,
                    maxLine: 2,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
