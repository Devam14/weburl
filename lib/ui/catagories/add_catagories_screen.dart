import 'package:bubble_gpt/controllers/dashboard_controller.dart';
import 'package:bubble_gpt/utils/app_colors.dart';
import 'package:bubble_gpt/utils/app_string.dart';
import 'package:bubble_gpt/utils/utility.dart';
import 'package:bubble_gpt/widgets/custom_button.dart';
import 'package:bubble_gpt/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCatagoriesScreen extends StatefulWidget {
  const AddCatagoriesScreen({super.key});

  @override
  State<AddCatagoriesScreen> createState() => _AddCatagoriesScreenState();
}

class _AddCatagoriesScreenState extends State<AddCatagoriesScreen> {
  final DashboardController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            _buildAppBar(),
            _buildForm(),
          ],
        ),
      ),
    );
  }

  Padding _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          TextFormField(
            controller: controller.nameContoller,
            decoration: InputDecoration(
              hintText: AppStrings.enterName,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: controller.descContoller,
            decoration: InputDecoration(
              hintText: AppStrings.enterDesc,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          CustomButton(
              onPressed: () {
                if (isFormValid()) {}
              },
              buttonColor: AppColors.primaryColor,
              buttonText: AppStrings.submit)
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15))),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.white,
              )),
          const CustomText(
              text: AppStrings.addCatagories,
              fontSize: 18,
              color: AppColors.white,
              fontWeight: FontWeight.w600),
          const SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }

  bool isFormValid() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (controller.nameContoller.text.trim().isEmpty) {
      Utility.showToastMessage(AppStrings.pleaseEnterName);
    } else if (controller.descContoller.text.trim().isEmpty) {
      Utility.showToastMessage(AppStrings.pleaseEnterDesc);
    } else {
      return true;
    }
    return false;
  }
}
