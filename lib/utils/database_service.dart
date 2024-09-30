import 'package:bubble_gpt/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

import 'app_constants.dart';

class DatabaseService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<String?> addUser({
    required String firstName,
    required String lastName,
    required String email,
    required String mobileNumber,
    required String uid,
    required String profileImage,
  }) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      // Call the user's CollectionReference to add a new user

      var crateAt = FieldValue.serverTimestamp();
      var roleId = 2; // 1: admin , 2: user
      DocumentReference docRef = await users.add({
        'phone': mobileNumber,
        'profile_image': profileImage,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'uid': uid,
        'role': roleId,
        'createdAt': crateAt,
      });
      // await GetStorage().write(AppConstants.adminId, docRef.id);

      var userData = UserModel(
        userFirebaseId: docRef.id,
        phone: mobileNumber,
        createdAt: crateAt.toString(),
        email: email,
        firstName: firstName,
        lastName: lastName,
        profileImage: profileImage,
        role: roleId,
        uid: uid,
      );

      await GetStorage().write(AppConstants.userKey, userData.toJson());

      return 'success';
    } catch (e) {
      return 'Error adding user';
    }
  }
}
