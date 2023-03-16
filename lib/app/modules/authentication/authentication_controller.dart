import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/app/modules/bottom_nav_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationController extends GetxController {
  //@override
  // void onInit() {
  //   signInWithGoogle(context);
  //   super.onInit();
  // }
   signInWithGoogle(context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      var user = userCredential.user;

      if (user!.uid.isNotEmpty) {
        // print('success');
        // print(user.displayName);
        // print(user.email);
        // print(user.uid);
        // print(user.phoneNumber);
        FirebaseFirestore.instance.collection('user-data').doc(user.email).set(
            {'name': user.displayName, 'email': user.email, 'uid': user.uid});
        var box = GetStorage();
        box.write('uid', user.uid);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const BottomNavController()));
      }
    } catch (e) {
      Get.snackbar('Failed', e.toString());
    }
  }
}