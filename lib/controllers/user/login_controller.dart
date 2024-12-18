import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);

      Get.offAllNamed('/bottomNav');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Jika email tidak ditemukan
        Get.snackbar('Error', 'No User Found for that Email');
      } else if (e.code == 'wrong-password') {
        // Jika password salah
        Get.snackbar('Error', 'Wrong Password Provided by User');
      }
    }
  }
}
