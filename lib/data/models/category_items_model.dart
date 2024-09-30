import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryItemsModel {
  final String? firebaseId;
  final String? name;
  final String? desc;
  final bool? status;
  final int? id;
  final int? categoryId;
  final Timestamp? createdAt;
  final String? itemImage;
  bool isFavorite;

  CategoryItemsModel(
      {required this.name,
      required this.desc,
      required this.status,
      required this.id,
      required this.categoryId,
      required this.createdAt,
      this.isFavorite = false,
      this.itemImage,
      this.firebaseId});

  factory CategoryItemsModel.fromJson(
      Map<String, dynamic> json, String firebaseReferanceId) {
    return CategoryItemsModel(
        firebaseId: firebaseReferanceId,
        name: json['name'],
        status: json['status'],
        id: json['id'],
        createdAt: json['created_at'],
        desc: json['description'],
        categoryId: json['category_id'],
        itemImage: json['item_image']);
  }

  factory CategoryItemsModel.fromJsonForFavorite(
      Map<String, dynamic> json, String firebaseReferanceId) {
    return CategoryItemsModel(
        firebaseId: firebaseReferanceId,
        name: json['name'],
        status: json['status'],
        id: json['id'],
        createdAt: json['created_at'],
        desc: json['description'],
        categoryId: json['category_id'],
        itemImage: json['item_image'],
        isFavorite: true);
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "status": status,
        "id": id,
        "created_at": createdAt,
        "description": desc,
        "category_id": categoryId,
        "item_image": itemImage,
      };
}
