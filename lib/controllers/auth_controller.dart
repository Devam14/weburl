import 'package:bubble_gpt/data/models/user_model.dart';
import 'package:bubble_gpt/routes/app_pages.dart';
import 'package:bubble_gpt/utils/app_constants.dart';
import 'package:bubble_gpt/utils/database_service.dart';
import 'package:bubble_gpt/utils/extension_classes.dart';
import 'package:bubble_gpt/utils/utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  String email = '';
  String name = '';
  String phone = '';
  String uid = '';
  String profileImage = '';

  final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: "58042224281-3c3bo3cnehgucq7m917o6fe097a7aeq6.apps.googleusercontent.com");

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle() async {
    // Trigger the Google Authentication flow
    // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // If the user cancels the sign-in, return null
    if (googleUser == null) return null;

    // Obtain the auth details from the Google user
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential using the tokens
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Use the credential to sign in to Firebase
    UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    // Return the Firebase user
    return userCredential.user;
  }

  googleSignout() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  onTapGoogle() async {
    try {
      AppLoader.showLoader();
      User? user = await signInWithGoogle();
      if (user != null) {
        // User successfully signed in
        debugPrint('User: ${user.displayName}, Email: ${user.email}');
        uid = user.uid;
        name = user.displayName ?? '';
        email = user.email ?? '';
        profileImage = user.photoURL ?? '';
        phone = user.phoneNumber ?? '';

        if (user.email!.isNotEmpty) {
          checkIfUserExistsByEmail();
        } else {
          Utility.showToastMessage('email id not found');
          EasyLoading.dismiss();
        }
      } else {
        // User cancelled the sign-in
        debugPrint('Sign in failed');

        Utility.showToastMessage('Sign in failed');
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      Utility.showToastMessage(e.toString());
    } finally {}
  }

  void checkIfUserExistsByEmail() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        EasyLoading.dismiss();
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          var userdata = UserModel.fromJson(data, doc.id);
          userdata.profileImage = profileImage;

          await GetStorage().write(AppConstants.userKey, userdata.toJson());
          // await GetStorage().write(AppConstants.adminId, doc.id);
          // await GetStorage().write(AppConstants.email, data['email']);
          await GetStorage().write(AppConstants.isLoggedIn, true);

          Get.offAllNamed(Routes.dashboard);
        }
      } else {
        debugPrint('User does not exist in the Firestore database.');
        final result = await DatabaseService().addUser(
          firstName: name,
          lastName: '',
          email: email,
          mobileNumber: phone,
          uid: uid,
          profileImage: profileImage,
        );
        if (result!.contains('success')) {
          EasyLoading.dismiss();
          Get.offAllNamed(
            Routes.dashboard,
          );

          // await GetStorage().write(AppConstants.email, email);
          await GetStorage().write(AppConstants.isLoggedIn, true);
        } else {
          EasyLoading.dismiss();
        }
      }
    } catch (e) {
      Utility.showToastMessage(e.toString());
    }
  }
}
