import 'dart:async';
import 'dart:io';

import 'package:bubble_gpt/controllers/dashboard_controller.dart';
import 'package:bubble_gpt/utils/app_string.dart';
import 'package:bubble_gpt/utils/utility.dart';
import 'package:bubble_gpt/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';
import '../../widgets/custom_text.dart';
import '../fav/favourite_screen.dart';
import '../home/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _canExit = false;
  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return CommonWidgets.getAnnanotaion(
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, ins) async {
          if (controller.selectedIndex.value != 0) {
            controller.selectedIndex(0);
          } else {
            if (_canExit) {
              if (GetPlatform.isAndroid) {
                SystemNavigator.pop();
              } else if (GetPlatform.isIOS) {
                exit(0);
              }
            } else {
              Utility.showToastMessage('Press back to exit');

              _canExit = true;
              Timer(const Duration(seconds: 3), () {
                _canExit = false;
              });
            }
          }
        },
        child: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: AppColors.white,
            body: Obx(
              () => SafeArea(
                  child: controller.selectedIndex.value == 0
                      ? const HomeScreen()
                      : const FavouriteScreen()),
            ),
            bottomNavigationBar: Obx(
              () => Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black38,
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3)),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                      child: BottomNavigationBar(
                          items: <BottomNavigationBarItem>[
                            _buildBottomNavigationBarItem(
                                index: 0,
                                // icon: Assets.imagesIcHome,

                                icon: Icons.home,
                                tabName: AppStrings.home),
                            _buildBottomNavigationBarItem(
                                index: 1,
                                // icon: Assets.imagesIcFav,
                                icon: Icons.favorite_border,
                                tabName: AppStrings.fav)
                          ],
                          currentIndex: controller.selectedIndex.value,
                          unselectedItemColor: AppColors.hintGrayColor,
                          selectedItemColor: AppColors.primaryColor,
                          showSelectedLabels: false,
                          type: BottomNavigationBarType.fixed,
                          backgroundColor: AppColors.white,
                          showUnselectedLabels: false,
                          onTap: (value) {
                            controller.selectedIndex.value = value;
                          }),
                    ),
                  )),
            )),
      ),
    );
  }

  _buildBottomNavigationBarItem(
      {required int index, required IconData icon, required String tabName}) {
    return BottomNavigationBarItem(
        icon: Column(children: [
          // SvgPicture.asset(icon,
          //     color: controller.selectedIndex.value == index
          //         ? AppColors.primaryColor
          //         : AppColors.hintColor),

          Icon(
            icon,
          ),
          CustomText(
              text: tabName,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: controller.selectedIndex.value == index
                  ? AppColors.primaryColor
                  : AppColors.hintColor)
        ]),
        label: tabName);
  }
}

// class DashboardScreen extends GetView<DashboardController> {
//   const DashboardScreen({super.key});

// }
