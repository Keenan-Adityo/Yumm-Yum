import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotpasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();

  resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      Get.snackbar('Success', 'Password Reset Email has been sent !',
          backgroundColor: Colors.white);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        Get.snackbar('Error', 'No user found for that email.',
            backgroundColor: Colors.white);
      }
    }
  }
}
