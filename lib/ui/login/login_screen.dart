import 'package:bubble_gpt/controllers/auth_controller.dart';
import 'package:bubble_gpt/generated/assets.dart';
import 'package:bubble_gpt/utils/extension_classes.dart';
import 'package:bubble_gpt/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/responsive.dart';
import '../../utils/app_string.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController controller = Get.find();

  @override
  void initState() {
    debugPrint(GetStorage().read(AppConstants.isLoggedIn).toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primaryColor.withOpacity(0.1),
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTitle(),
            const SizedBox(height: 20),
            _buildGoogleSignInBtn(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  _buildGoogleSignInBtn(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        controller.onTapGoogle();
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              Assets.imagesIcGoogleSignIn,
              height: 25,
            ),
            10.sbw,
            CustomText(
              text: AppStrings.signInWithGoogle,
              textAlign: TextAlign.start,
              fontSize: Responsive.isMobile(context) ? 14 : 16,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Row _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          Assets.imagesIcLogo,
          height: 65,
        ),
        const SizedBox(width: 10),
        const CustomText(
          text: AppConstants.appName,
          textAlign: TextAlign.start,
          fontSize: 40,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryColor,
        ),
      ],
    );
  }
}
