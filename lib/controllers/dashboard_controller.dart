import 'dart:io';

import 'package:bubble_gpt/data/models/user_model.dart';
import 'package:bubble_gpt/utils/app_constants.dart';
import 'package:bubble_gpt/utils/utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../data/models/category_items_model.dart';
import '../data/models/category_model.dart';
import '../utils/extension_classes.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;

  RxList<CategoryModel> categoriesList = <CategoryModel>[].obs;
  RxList<CategoryItemsModel> itemsList = <CategoryItemsModel>[].obs;
  RxList<CategoryItemsModel> favItemList = <CategoryItemsModel>[].obs;

  dynamic argumentData = Get.arguments;

  Rxn<UserModel> currentUserData = Rxn();

  int categoryId = 0;
  String uid = '';

  @override
  void onInit() {
    var data = GetStorage().read(AppConstants.userKey);
    currentUserData.value = UserModel.fromJson(data, data['user_firebase_id']);
    getFavoriteItems(isShowLoading: false);
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
    }

    super.onInit();
  }

  Future<bool?> addToFavorite(CategoryItemsModel item) async {
    try {
      EasyLoading.show(status: "Loading...");
      Map<String, dynamic> favItem = {
        'category_id': item.categoryId,
        'created_at': Timestamp.now(),
        'description': item.desc,
        'id': item.id,
        'name': item.name,
        'status': item.status,
        'item_image': item.itemImage,
        'uid': uid,
      };
      var res = await addFavoriteItem(favItem);
      await getFavoriteItems(isShowLoading: false);
      if (res != null && res == true) {
        return true;
      }
    } catch (e) {
      Utility.showToastMessage(e.toString());
    } finally {
      EasyLoading.dismiss();
    }
    return null;
  }

  Future<bool?> removeToFavorite(int id, int categoryId) async {
    CollectionReference favItems =
        FirebaseFirestore.instance.collection('favourite_item');

    try {
      EasyLoading.show(status: "Loading...");

      QuerySnapshot querySnapshot = await favItems
          .where('uid', isEqualTo: uid)
          .where('id', isEqualTo: id)
          .where('category_id', isEqualTo: categoryId)
          .get();

      for (var doc in querySnapshot.docs) {
        var res =
            await favItems.doc(doc.reference.id).delete().then((onValue) async {
          return true;
        }).catchError((onError) {
          return false;
        });

        if (res == true) {
          await getFavoriteItems(isShowLoading: false);
        }
      }
    } catch (e) {
      Utility.showToastMessage(e.toString());
    } finally {
      EasyLoading.dismiss();
    }
    return null;
  }

  Future<bool?> addFavoriteItem(Map<String, dynamic> itemData) async {
    CollectionReference favItems =
        FirebaseFirestore.instance.collection('favourite_item');
    try {
      // Add a new document with a generated ID
      await favItems.add(itemData);

      return true;
    } catch (e) {
      Utility.showToastMessage(e.toString());
    }
    return null;
  }

  Future<void> fetchCategoryItems(
      {required bool isShowLoading, required String text}) async {
    try {
      if (isShowLoading) {
        AppLoader.showLoader();
      }
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('items')
          .where(
            'category_id',
            isEqualTo: categoryId,
          )
          .where('name', isGreaterThanOrEqualTo: text)
          .where('name', isLessThanOrEqualTo: '$text\uf8ff')
          .get();

      List<CategoryItemsModel> subCategories = querySnapshot.docs.map((doc) {
        return CategoryItemsModel.fromJson(
            doc.data() as Map<String, dynamic>, doc.reference.id);
      }).toList();
      itemsList.value = subCategories;

      final favIds = favItemList.map((favItem) => favItem.id).toSet();

      final updatedItems = itemsList.map((item) {
        return CategoryItemsModel(
          categoryId: item.categoryId,
          createdAt: item.createdAt,
          desc: item.desc,
          name: item.name,
          status: item.status,
          itemImage: item.itemImage,
          isFavorite: favIds.contains(item.id),
          id: item.id,
          firebaseId: item.firebaseId,
        );
      }).toList();

      itemsList
        ..clear()
        ..addAll(updatedItems);
    } catch (e) {
      Utility.showToastMessage(e.toString());
    } finally {
      if (isShowLoading) {
        EasyLoading.dismiss();
      }
    }
  }

  Future<void> fetchCategories({required String text}) async {
    try {
      EasyLoading.show(status: "Loading...");
      print(text);
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('category')
          .where('name', isGreaterThanOrEqualTo: text)
          .where('name', isLessThanOrEqualTo: '$text\uf8ff')
          .get();

      List<CategoryModel> categories = querySnapshot.docs.map((doc) {
        return CategoryModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      categoriesList.value = categories;
    } catch (e) {
      Utility.showToastMessage(e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> getFavoriteItems({required bool isShowLoading}) async {
    try {
      if (isShowLoading) {
        EasyLoading.show(status: "Loading...");
      }
      debugPrint("======> getFavoriteItems() called");
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('favourite_item')
          .where('uid', isEqualTo: uid)
          .get();

      List<CategoryItemsModel> favItems = querySnapshot.docs.map((doc) {
        return CategoryItemsModel.fromJsonForFavorite(
            doc.data() as Map<String, dynamic>, doc.reference.id);
      }).toList();
      favItemList.value = favItems;
    } catch (e) {
      Utility.showToastMessage(e.toString());
    } finally {
      if (isShowLoading) {
        EasyLoading.dismiss();
      }
    }
  }

  final TextEditingController nameContoller = TextEditingController();
  final TextEditingController descContoller = TextEditingController();
  final TextEditingController itemNameContoller = TextEditingController();
  final TextEditingController itemDescContoller = TextEditingController();

  var image = Rx<File?>(null); // Observable image

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: source,
      imageQuality: 50,
    );

    if (pickedImage != null) {
      image.value =
          File(pickedImage.path); // Update .value instead of assigning directly
    }
  }
}
