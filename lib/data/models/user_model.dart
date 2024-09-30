// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str, String firebaseUserId) =>
    UserModel.fromJson(json.decode(str), firebaseUserId);

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String? userFirebaseId;
  final String? phone;
  String? profileImage;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? uid;
  final int? role;
  final String? createdAt;

  UserModel({
    this.userFirebaseId,
    this.phone,
    this.profileImage,
    this.firstName,
    this.lastName,
    this.email,
    this.uid,
    this.role,
    this.createdAt,
  });

  factory UserModel.fromJson(
          Map<String, dynamic> json, String firebaseUserId) =>
      UserModel(
        userFirebaseId: firebaseUserId,
        phone: json["phone"],
        profileImage: json["profile_image"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        uid: json["uid"],
        role: json["role"],
        createdAt: json["createdAt"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "user_firebase_id": userFirebaseId,
        "phone": phone,
        "profile_image": profileImage,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "uid": uid,
        "role": role,
        "createdAt": createdAt,
      };
}
