import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yumm_yum/models/order.dart';
import 'package:yumm_yum/services/shared_pref.dart';

class OrderController extends GetxController {
  RxInt test = 1.obs;
  RxList<OrderItem> order = <OrderItem>[].obs;
  RxList<Orders> orders = <Orders>[].obs;
  RxInt sum = 0.obs;
  TextEditingController notes = TextEditingController();

  addOrder(
    String id,
    String name,
    int count,
    int price,
  ) {
    order.add(OrderItem(id, name, count, price));
    sum += (price * count);
    Get.back();
    Get.snackbar(
        'Pesanan Berhasil Ditambahkan', '$count $name berhasil ditambahkan');
  }

  void createOrder() async {
    print("masuk");
    String? email = await SharedPreferenceHelper().getUserEmail();
    await FirebaseFirestore.instance.collection("Order").add({
      "email": email,
      "orders": order
          .map((item) => {
                "id": item.id,
                "name": item.name,
                "count": item.count.toInt(),
                "price": item.price,
              })
          .toList(),
      "sum": sum.toInt(),
      "notes": notes.text,
      "done": false,
    });

    order.clear();
    sum.value = 0;
    fetchOrder();
    Get.back();

    Get.snackbar('Pesanan Berhasil diajukan', 'Silahkan menemui penjual');
  }

  void fetchOrder() async {
    String? email = await SharedPreferenceHelper().getUserEmail();
    try {
      // Fetch orders filtered by email
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("Order")
          .where("email", isEqualTo: email)
          .get();

      // Create a list of Orders objects from the fetched documents
      List<Orders> ordersList = snapshot.docs.map((doc) {
        return Orders.fromFirestore(doc);
      }).toList();

      // Assign the fetched orders to the RxList
      orders.value = ordersList;

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
  }
}
