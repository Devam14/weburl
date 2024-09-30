import 'package:bubble_gpt/controllers/dashboard_controller.dart';
import 'package:bubble_gpt/routes/app_pages.dart';
import 'package:bubble_gpt/utils/app_colors.dart';
import 'package:bubble_gpt/utils/app_constants.dart';
import 'package:bubble_gpt/utils/app_string.dart';
import 'package:bubble_gpt/widgets/custom_text.dart';
import 'package:bubble_gpt/widgets/custom_text_form_field.dart';
import 'package:bubble_gpt/widgets/side_bar_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DashboardController controller = Get.find();
  final _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _getData();
  }

  _getData() {
    controller.fetchCategories(text: _searchTextController.text);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey _key = GlobalKey();

  // List of items to display in the grid
  final List<String> gridItems = List.generate(20, (index) => 'Item $index');

  // Function to show the popup menu
  void _showCustomPopupMenu(BuildContext context, GlobalKey key) {
    // Get the position of the tapped item
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox
        .localToGlobal(Offset.zero); // Get the top-left position of the item
    final size = renderBox.size; // Get the size of the item

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx - 90, // left (X coordinate)
        position.dy + 30, // top (Y coordinate + item height)
        position.dx + size.width, // right (X + width of the item)
        position.dy + size.height, // bottom (Y coordinate + item height)
      ),
      items: [
        PopupMenuItem(
          value: 1,
          child: Row(
            children: const [
              Icon(Icons.edit, color: Colors.blue),
              SizedBox(width: 10),
              Text("Edit"),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: const [
              Icon(Icons.delete, color: Colors.red),
              SizedBox(width: 10),
              Text("Delete"),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value != null) {
        print('Selected: $value');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const SideBarWidget(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: _buildAppBar(),
        ),
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
              child: CustomTextFormField(
                textEditingController: _searchTextController,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                labelText: "Search Categories",
                fontSize: 14,
                isSufixIcon: IconButton(
                  onPressed: () {
                    _getData();
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 25,
                  ),
                ),
              ),
            ),
            _buildListView(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(Routes.addCatagories),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  _buildListView() {
    return Expanded(
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: GridView.builder(
            key: _key,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two items per row
              crossAxisSpacing: 10.0, // Horizontal space between grid items
              mainAxisSpacing: 10.0, // Vertical space between grid items
              childAspectRatio: 1.0, // Ensures equal width and height
            ),

            itemCount:
                controller.categoriesList.length, // Number of items in the grid
            itemBuilder: (BuildContext context, int index) {
              GlobalKey itemKey = GlobalKey();
              return InkWell(
                onTap: () {
                  Get.toNamed(Routes.items,
                      arguments: [controller.categoriesList[index].id]);
                },
                child: Container(
                  height: 200, // Set a fixed height for grid items
                  width: double.infinity, // Ensure it takes the full width
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: CachedNetworkImage(
                          height: double.infinity,
                          width: double.infinity,
                          imageUrl: controller.categoriesList[index].catImage ??
                              "https://lh3.googleusercontent.com/a/ACg8ocKikSmCIjxeiiwpKABflJd2hk0YxPmMPvlGTmEhhCdp2J9kJA=s96-c",
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
                        ),
                      ),
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.0),
                              Colors.black.withOpacity(0.2),
                              Colors.black.withOpacity(0.9),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Positioned(
                          right: 0,
                          top: 0,
                          child: GestureDetector(
                              key: itemKey, // Assign the key to the item
                              onTap: () =>
                                  _showCustomPopupMenu(context, itemKey),
                              child: Icon(Icons.more_vert))),
                      Positioned(
                        bottom: 5,
                        left: 7,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: CustomText(
                            text: controller.categoriesList[index].name ?? '',
                            fontSize: 14,
                            maxLine: 2,
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
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
          bottomRight: Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 20),
          const CustomText(
            text: AppStrings.home,
            fontSize: 18,
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
          InkWell(
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: Obx(() {
              return CircleAvatar(
                backgroundImage: NetworkImage(
                    controller.currentUserData.value?.profileImage ??
                        AppConstants.defaultAppImage),
              );
            }),
          ),
        ],
      ),
    );
  }
}
