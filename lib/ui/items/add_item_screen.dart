import 'dart:io';

import 'package:bubble_gpt/controllers/auth_controller.dart';
import 'package:bubble_gpt/controllers/dashboard_controller.dart';
import 'package:bubble_gpt/utils/app_colors.dart';
import 'package:bubble_gpt/utils/app_string.dart';
import 'package:bubble_gpt/utils/extension_classes.dart';
import 'package:bubble_gpt/utils/utility.dart';
import 'package:bubble_gpt/widgets/custom_button.dart';
import 'package:bubble_gpt/widgets/custom_text.dart';
import 'package:bubble_gpt/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final DashboardController controller = Get.find();
  // File? image;

  // Future<void> pickImage(ImageSource source) async {
  //   final picker = ImagePicker();
  //   final pickedImage = await picker.pickImage(
  //     source: source,
  //     imageQuality: 50,
  //   );

  //   if (pickedImage != null) {
  //     setState(() {
  //       image = File(pickedImage.path);
  //     });
  //   }
  // }

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
          // Container(
          //   height: 120,
          //   width: 120,
          //   decoration: BoxDecoration(
          //     border: Border.all(color: AppColors.black),
          //   ),
          //   child: InkWell(
          //     onTap: () => pickImage(ImageSource.gallery),
          //     child: image != null
          //         ? Image.file(
          //             image!,
          //             fit: BoxFit.cover,
          //           )
          //         : const Center(
          //             child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Icon(
          //                 Icons.cloud_upload_outlined,
          //                 size: 30,
          //               ),
          //               CustomText(
          //                 text: AppStrings.pleaseUploadImage,
          //                 maxLine: 2,
          //                 fontSize: 13,
          //                 textAlign: TextAlign.center,
          //               )
          //             ],
          //           )),
          //   ),
          // ),
          10.sbh,
          CustomTextFormField(
            labelText: AppStrings.enterItemName,
            fontSize: 18,
            textEditingController: controller.itemNameContoller,
          ),
          10.sbh,
          CustomTextFormField(
            labelText: AppStrings.enterItemDesc,
            fontSize: 18,
            textEditingController: controller.itemDescContoller,
          ),
          50.sbh,
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
              text: AppStrings.addItem,
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
    // if (image == null) {
    //   Utility.showToastMessage(AppStrings.pleaseUploadImage);
    if (controller.itemNameContoller.text.trim().isEmpty) {
      Utility.showToastMessage(AppStrings.pleaseEnterItemName);
    } else if (controller.itemDescContoller.text.trim().isEmpty) {
      Utility.showToastMessage(AppStrings.pleaseEnterItemDesc);
    } else {
      return true;
    }
    return false;
  }
}
