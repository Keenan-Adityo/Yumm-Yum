import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminPageController extends GetxController {
  var foodItems = <QueryDocumentSnapshot>[].obs;

  var errorMessage = ''.obs;

  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFoodItems();
  }

  void fetchFoodItems() {
    try {
      FirebaseFirestore.instance.collection('Food').snapshots().listen(
          (QuerySnapshot snapshot) {
        foodItems.value = snapshot.docs;
        isLoading.value = false;
      }, onError: (error) {
        errorMessage.value = error.toString();
        isLoading.value = false;
      });
    } catch (e) {
      errorMessage.value = e.toString();
      isLoading.value = false;
    }
  }

  void updateFoodStock(String documentId, int newStock) async {
    try {
      await FirebaseFirestore.instance
          .collection('Food')
          .doc(documentId)
          .update({'stock': newStock});
      print("Stock updated successfully!");
    } catch (e) {
      print("Error updating stock: $e");
    }
  }
}
