import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String? name;
  final bool? status;
  final int? id;
  final Timestamp? createdAt;
  final String? catImage;

  CategoryModel({
    required this.name,
    required this.status,
    required this.id,
    required this.createdAt,
    required this.catImage,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        name: json['name'],
        status: json['status'],
        id: json['id'],
        createdAt: json['created_at'],
        catImage: json['cat_image']);
  }
}
