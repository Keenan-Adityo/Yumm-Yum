import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  var selectedImage = Rx<File?>(null); // Observable for selected image
  var base64SelectedImage = ''.obs; // Observable for Base64 string

  // Get Image from gallery and convert to File and Base64
  Future<void> getImage() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImage.value = File(image.path); // Update observable file
        final bytes = await selectedImage.value!.readAsBytes();
        base64SelectedImage.value =
            base64Encode(bytes); // Update observable Base64
      } else {
        Get.snackbar('Notice', 'No image selected.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image.');
    }
  }

  // Decode Base64 string to an Image widget (optional use)
  Image getImageFromBase64(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  // Upload food item to Firestore
  Future<void> uploadItem() async {
    if (base64SelectedImage.value.isNotEmpty &&
        namecontroller.text.isNotEmpty &&
        pricecontroller.text.isNotEmpty &&
        detailcontroller.text.isNotEmpty &&
        stockcontroller.text.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection("Food").add({
          "name": namecontroller.text,
          "price": double.parse(pricecontroller.text),
          "detail": detailcontroller.text,
          "stock": stockcontroller.text,
          "image": base64SelectedImage.value,
        });
        Get.snackbar('Success', 'Food item added successfully!');
        clearFields(); // Clear form after successful upload
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload item.');
      }
    } else {
      Get.snackbar('Error', 'Please fill in all fields before uploading.');
    }
    Get.back();
    
  }

  // Clear form fields and reset image
  void clearFields() {
    namecontroller.clear();
    pricecontroller.clear();
    stockcontroller.clear();
    detailcontroller.clear();
    selectedImage.value = null;
    base64SelectedImage.value = '';
  }
}
