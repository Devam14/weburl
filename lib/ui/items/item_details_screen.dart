import 'package:bubble_gpt/controllers/dashboard_controller.dart';
import 'package:bubble_gpt/data/models/category_items_model.dart';
import 'package:bubble_gpt/services/share_service.dart';
import 'package:bubble_gpt/ui/items/image_view.dart';
import 'package:bubble_gpt/utils/app_colors.dart';
import 'package:bubble_gpt/utils/app_string.dart';
import 'package:bubble_gpt/utils/utility.dart';
import 'package:bubble_gpt/widgets/common_app_bar.dart';
import 'package:bubble_gpt/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemDetailsScreen extends StatefulWidget {
  final CategoryItemsModel item;
  final bool isFromFav;
  const ItemDetailsScreen(
      {super.key, required this.item, required this.isFromFav});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  final DashboardController controller = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: CommonAppBar(
            title: widget.item.name ?? "",
            isShowBack: true,
          ),
        ),
        body: Column(
          children: [
            // CommonAppBar(
            //   title: widget.item.name ?? "",
            //   isShowBack: true,
            // ),
            _buildItemListTile(),
          ],
        ),
      ),
    );
  }

  Widget _buildItemListTile() {
    return Obx(() {
      var isFavorite = controller.favItemList
          .where((test) => test.id == widget.item.id)
          .toList()
          .isNotEmpty;
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Get.dialog(ImageZoom(widget.item.itemImage ?? ""));
                    },
                    child: ClipRRect(
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
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () async {
                        if (isFavorite) {
                          // do un-favorite
                          controller.removeToFavorite(
                              widget.item.id!, widget.item.categoryId!);
                        } else {
                          controller.addToFavorite(widget.item);
                          // do favorite
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            shape: BoxShape.circle),
                        child: Icon(
                          Icons.favorite,
                          color: isFavorite ? Colors.red : Colors.white,
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
                  fontWeight: FontWeight.w600),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Html(
                  data: widget.item.desc ?? '',
                  onLinkTap: (url, _, __) async {
                    Uri uri = Uri.parse(url!);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri,
                          mode: LaunchMode.externalApplication);
                    } else {
                      Utility.showToastMessage(
                          "${AppStrings.couldNotLaunch} $uri");
                    }
                  },
                  style: {
                    "*": Style(
                      padding: HtmlPaddings.all(0),
                      margin: Margins.all(0),
                    )
                  },
                )

                // CustomText(
                //     text: widget.item.desc ?? '',
                //     fontSize: 14,
                //     maxLine: 20000,
                //     textAlign: TextAlign.start,
                //     color: AppColors.black,
                //     fontWeight: FontWeight.w400),
                )
          ],
        ),
      );
    });
  }
}
