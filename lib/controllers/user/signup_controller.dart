import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:yumm_yum/services/database.dart';
import 'package:yumm_yum/services/shared_pref.dart';

class SignupController extends GetxController {
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();

  signup() async {
    if (password.text != null) {
      try {
        print("masuk regis");
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text, password: password.text);
        Get.snackbar('Success', 'Registered Successfully');
        String Id = randomAlphaNumeric(10);
        Map<String, dynamic> addUserInfo = {
          "Name": name.text,
          "Email": email.text,
          "Wallet": "0",
          "Id": Id,
        };
        await DatabaseMethods().addUserDetail(addUserInfo, Id);
        await SharedPreferenceHelper().saveUserName(name.text);
        await SharedPreferenceHelper().saveUserEmail(email.text);
        await SharedPreferenceHelper().saveUserWallet('0');
        await SharedPreferenceHelper().saveUserId(Id);

        Get.offAllNamed('/bottomNav');
      } on FirebaseException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar('Error', 'Password Provided is too Weak');
        } else if (e.code == "email-already-in-use") {
          Get.snackbar('Error', 'Account Already exsists');
        }
      }
    }
  }
}
