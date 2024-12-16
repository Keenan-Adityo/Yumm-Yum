import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddFoodController extends GetxController {
  String? value;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController stockcontroller = TextEditingController();
  TextEditingController detailcontroller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  String? base64SelectedImage;

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);

    selectedImage = File(image!.path);
    final bytes = await selectedImage!.readAsBytes();

    base64SelectedImage = base64Encode(bytes);
  }

  Image _getImageFromBase64(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  uploadItem() async {
    if (base64SelectedImage != null &&
        namecontroller.text != "" &&
        pricecontroller.text != "" &&
        detailcontroller.text != "") {
      print("masuk if");
      try {
        await FirebaseFirestore.instance.collection("Food").add({
          "name": namecontroller.text,
          "price": double.parse(pricecontroller.text),
          "detail": detailcontroller.text,
          "stock": 1,
          "image": base64SelectedImage,
        });
        debugPrint("kenapa in");
        Get.snackbar('Success', 'Food item added successfully!');
      } catch (e) {
        Get.snackbar('Error', 'Faield to upload item!');
      }
    }
  }
}
