import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminLoginController extends GetxController {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  loginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['id'] != username.text.trim()) {
          print(result.data()['id']);
          Get.snackbar('Error', 'Your username is not correct');
        } else if (result.data()['password'] != password.text.trim()) {
          Get.snackbar('Error', 'Your password is not correct');
        } else {
          Get.toNamed('/adminhome');
        }
      });
    });
  }
}
