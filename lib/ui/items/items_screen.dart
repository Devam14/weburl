import 'package:bubble_gpt/controllers/dashboard_controller.dart';
import 'package:bubble_gpt/routes/app_pages.dart';
import 'package:bubble_gpt/utils/app_colors.dart';
import 'package:bubble_gpt/utils/app_string.dart';
import 'package:bubble_gpt/utils/utility.dart';
import 'package:bubble_gpt/widgets/common_app_bar.dart';
import 'package:bubble_gpt/widgets/custom_text.dart';
import 'package:bubble_gpt/widgets/custom_text_form_field.dart';
import 'package:bubble_gpt/widgets/item_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ItemsScreen extends StatefulWidget {
  final int categoryId;

  const ItemsScreen({super.key, required this.categoryId});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  final _searchTextController = TextEditingController();
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
        controller.itemsList.clear();
      } catch (e) {
        debugPrint(e.toString());
      }
      controller.categoryId = widget.categoryId;
      try {
        EasyLoading.show(status: "Loading...");
        // await controller.getFavoriteItems(isShowLoading: false);
        await controller.fetchCategoryItems(
            isShowLoading: false, text: _searchTextController.text);
      } catch (e) {
        Utility.showToastMessage(e.toString());
      } finally {
        EasyLoading.dismiss();
        _isLoading(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: CommonAppBar(
            title: AppStrings.items,
            isShowBack: true,
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
              child: CustomTextFormField(
                textEditingController: _searchTextController,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                labelText: "Search Items",
                fontSize: 14,
                isSufixIcon: IconButton(
                  onPressed: () {
                    _loadData();
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 25,
                  ),
                ),
              ),
            ),
            Obx(() {
              return controller.itemsList.isEmpty
                  ? Expanded(
                      child: Center(
                        child: CustomText(
                            text: _isLoading.value ? "" : "Item not found!",
                            fontSize: 14,
                            maxLine: 2,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  : _buildListView();
            }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(Routes.addItems),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  _buildListView() {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          itemCount: controller.itemsList.length,
          itemBuilder: (BuildContext context, int index) {
            return ItemCardWidget(
              item: controller.itemsList[index],
              isForFav: false,
            );
          },
        ),
      ),
    );
  }
}
