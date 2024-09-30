import 'package:bubble_gpt/controllers/dashboard_controller.dart';
import 'package:bubble_gpt/data/models/category_items_model.dart';
import 'package:bubble_gpt/services/share_service.dart';
import 'package:bubble_gpt/ui/items/item_details_screen.dart';
import 'package:bubble_gpt/utils/app_colors.dart';
import 'package:bubble_gpt/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemCardWidget extends StatefulWidget {
  const ItemCardWidget({super.key, required this.item, required this.isForFav});
  final CategoryItemsModel item;
  final bool isForFav;
  @override
  State<ItemCardWidget> createState() => _ItemCardWidgetState();
}

class _ItemCardWidgetState extends State<ItemCardWidget> {
  final DashboardController _dashboardController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.to(() =>
              ItemDetailsScreen(item: widget.item, isFromFav: widget.isForFav));
        },
        child: _buildItemListTile());
  }

  Widget _buildItemListTile() {
    return Obx(() {
      var isFavorite = _dashboardController.favItemList
          .where((test) => test.id == widget.item.id)
          .toList()
          .isNotEmpty;
      return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      height: double.infinity,
                      width: double.infinity,
                      imageUrl: widget.item.itemImage ?? "",
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const Center(child: SizedBox()),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () async {
                        // if (widget.isForFav) {
                        //   try {
                        //     EasyLoading.show(status: "Loading...");

                        //     var res = await _dashboardController
                        //         .deleteFav(widget.item.firebaseId!);

                        //     if (res != null && res == true) {
                        //       _dashboardController.favItemList.removeWhere(
                        //           (test) =>
                        //               test.firebaseId ==
                        //               widget.item.firebaseId);
                        //     }
                        //   } catch (e) {
                        //     Utility.showToastMessage(e.toString());
                        //   } finally {
                        //     EasyLoading.dismiss();
                        //   }
                        // } else {
                        if (isFavorite) {
                          // do un-favorite

                          _dashboardController.removeToFavorite(
                              widget.item.id!, widget.item.categoryId!);
                        } else {
                          _dashboardController.addToFavorite(widget.item);

                          // do favorite
                        }
                        // _dashboardController.setFavorite(widget.item.id ?? 0);
                        // }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            shape: BoxShape.circle),
                        child: Icon(
                          Icons.favorite,
                          color: widget.isForFav
                              ? Colors.red
                              : isFavorite
                                  ? Colors.red
                                  : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () async {
                        var desc =
                            "${widget.item.name} \n ${widget.item.desc} ";
                        ShareService.shareImage(widget.item.itemImage!, desc);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            shape: BoxShape.circle),
                        child: const Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomText(
                  text: widget.item.name ?? '',
                  fontSize: 16,
                  maxLine: 2,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      );
    });
  }
}
