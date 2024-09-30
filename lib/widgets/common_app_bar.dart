import 'package:bubble_gpt/utils/app_colors.dart';
import 'package:bubble_gpt/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonAppBar extends StatefulWidget {
  const CommonAppBar(
      {super.key, required this.title, required this.isShowBack});
  final String title;
  final bool isShowBack;
  @override
  State<CommonAppBar> createState() => _CommonAppBarState();
}

class _CommonAppBarState extends State<CommonAppBar> {
  @override
  Widget build(BuildContext context) {
    return _buildAppBar();
  }

  _buildAppBar() {
    return Container(
        height: 70,
        decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 15),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          widget.isShowBack == true
              ? InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.arrow_back_ios_new,
                      color: AppColors.white))
              : Container(width: 30),
          CustomText(
              text: widget.title,
              fontSize: 18,
              color: AppColors.white,
              fontWeight: FontWeight.w600),
          Container(width: 30)
        ]));
  }
}
