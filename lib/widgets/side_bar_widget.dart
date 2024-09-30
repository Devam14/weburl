import 'package:bubble_gpt/controllers/auth_controller.dart';
import 'package:bubble_gpt/controllers/dashboard_controller.dart';
import 'package:bubble_gpt/routes/app_pages.dart';
import 'package:bubble_gpt/ui/login/login_screen.dart';
import 'package:bubble_gpt/utils/app_colors.dart';
import 'package:bubble_gpt/utils/app_constants.dart';
import 'package:bubble_gpt/utils/extension_classes.dart';
import 'package:bubble_gpt/utils/utility.dart';
import 'package:bubble_gpt/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SideBarWidget extends StatefulWidget {
  const SideBarWidget({super.key});

  @override
  State<SideBarWidget> createState() => _SideBarWidgetState();
}

class _SideBarWidgetState extends State<SideBarWidget> {
  final AuthController controller = Get.put(AuthController());
  final DashboardController _dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          // const DrawerHeader(
          //   decoration: BoxDecoration(
          //     color: AppColors.primaryColor,
          //   ), //BoxDecoration
          //   child: UserAccountsDrawerHeader(
          //     decoration: BoxDecoration(color: AppColors.primaryColor),
          //     accountName: Text(
          //       "Abhishek Mishra",
          //       style: TextStyle(fontSize: 18),
          //     ),
          //     accountEmail: Text("abhishekm977@gmail.com"),
          //     currentAccountPictureSize: Size.square(50),
          //     currentAccountPicture: const CircleAvatar(
          //       backgroundImage: NetworkImage(
          //           "https://icon-library.com/images/avatar-icon-images/avatar-icon-images-4.jpg"),
          //     ), //circleAvatar
          //   ), //UserAccountDrawerHeader
          // ), //DrawerHeader

          Container(
            color: AppColors.primaryColor,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  return Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(_dashboardController
                                .currentUserData.value?.profileImage ??
                            AppConstants.defaultAppImage),
                      ),
                      10.sbw,
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              text: _dashboardController
                                      .currentUserData.value?.firstName ??
                                  "",
                              fontSize: 14,
                              maxLine: 2,
                              color: AppColors.white,
                              fontWeight: FontWeight.w600),
                          3.sbh,
                          CustomText(
                              text: _dashboardController
                                      .currentUserData.value?.email ??
                                  "",
                              fontSize: 14,
                              maxLine: 2,
                              color: AppColors.white,
                              fontWeight: FontWeight.w500),
                        ],
                      ))
                    ],
                  );
                })
              ],
            ),
          ),
          _buildListTile(
              icon: Icons.person_outline_rounded,
              title: "My Profile",
              onTap: () {
                Navigator.pop(context);
              }),
          _buildListTile(
              icon: Icons.settings,
              title: "Setings",
              onTap: () {
                Navigator.pop(context);
              }),
          _buildListTile(
              icon: Icons.privacy_tip_outlined,
              title: "Privacy Policy",
              onTap: () {
                Navigator.pop(context);
              }),
          _buildListTile(
              icon: Icons.terminal_rounded,
              title: "Terms & Conditions",
              onTap: () {
                Navigator.pop(context);
              }),

          _buildListTile(
              icon: Icons.notifications_none,
              title: "Notifications",
              onTap: () {
                Navigator.pop(context);
              }),
          _buildListTile(
              icon: Icons.delete_outline_rounded,
              title: "Delete Account",
              onTap: () {
                Navigator.pop(context);
              }),
          _buildListTile(
              icon: Icons.logout,
              title: "Logout",
              onTap: () {
                _logout();
              }),
        ],
      ),
    );
  }

  _logout() async {
    try {
      EasyLoading.show(status: "Loading...");
      await GetStorage().erase();
      await controller.googleSignout();
      Get.offAllNamed(Routes.login);
    } catch (e) {
      Utility.showToastMessage(e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  _buildListTile({
    required IconData icon,
    required String title,
    required Function onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon),
          title: CustomText(
              text: title,
              fontSize: 16,
              maxLine: 2,
              color: AppColors.black,
              fontWeight: FontWeight.w500),
          onTap: () {
            onTap();
          },
        ),
        Divider(
          height: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
      ],
    );
  }
}
