import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yumm_yum/models/order.dart';
import 'package:yumm_yum/services/shared_pref.dart';

class OrderListController extends GetxController {
  RxList<Orders> orders = <Orders>[].obs;
  var errorMessage = ''.obs;

  var isLoading = true.obs;

  void fetchOrder() async {
    String? email = await SharedPreferenceHelper().getUserEmail();
    try {
      // Fetch orders filtered by email
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection("Order").get();

      // Create a list of Orders objects from the fetched documents
      List<Orders> ordersList = snapshot.docs.map((doc) {
        return Orders.fromFirestore(doc);
      }).toList();

      // Assign the fetched orders to the RxList
      orders.value = ordersList;
      isLoading.value = false;
      // Optionally, print or log the orders
      orders.forEach((order) {
        print('Email: ${order.email}');
        print('Orders: ${order.orderItems}');
        print('Sum: ${order.sum}');
        print('Notes: ${order.notes}');
        print('Done: ${order.done}');
      });
    } catch (e) {
      print("Error fetching orders: $e");
    }
    print("sehat");
  }
}
