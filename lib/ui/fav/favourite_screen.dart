import 'package:bubble_gpt/controllers/dashboard_controller.dart';
import 'package:bubble_gpt/utils/app_colors.dart';
import 'package:bubble_gpt/utils/app_string.dart';
import 'package:bubble_gpt/utils/utility.dart';
import 'package:bubble_gpt/widgets/common_app_bar.dart';
import 'package:bubble_gpt/widgets/custom_text.dart';
import 'package:bubble_gpt/widgets/item_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final DashboardController controller = Get.find();
  final RxBool _isLoading = false.obs;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    if (mounted) {
      try {
        _isLoading(true);
        controller.favItemList.clear();
        await controller.getFavoriteItems(isShowLoading: true);
      } catch (e) {
        Utility.showToastMessage(e.toString());
      } finally {
        _isLoading(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CommonAppBar(
          title: AppStrings.fav,
          isShowBack: false,
        ),
      ),
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => controller.favItemList.isEmpty
                  ? Center(
                      child: CustomText(
                          text: _isLoading.value
                              ? ""
                              : "No items in your favorites. Add some!",
                          fontSize: 14,
                          maxLine: 2,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500),
                    )
                  : ListView.builder(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      itemCount: controller.favItemList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ItemCardWidget(
                          item: controller.favItemList[index],
                          isForFav: true,
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
