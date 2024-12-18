import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yumm_yum/controllers/user/order_controller.dart';
import 'package:yumm_yum/services/database.dart';
import 'package:yumm_yum/services/shared_pref.dart';
import 'package:yumm_yum/services/database.dart';
import 'package:yumm_yum/services/shared_pref.dart';
import 'package:yumm_yum/widgets/order_receipt.dart';
import 'package:yumm_yum/widgets/widget_support.dart';

class BasketPage extends StatelessWidget {
  final OrderController orderController = Get.find<OrderController>();
  BasketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Keranjang", style: AppWidget.boldTextFeildStyle()),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              orderController.order.clear();
              orderController.sum.value = 0;
              Get.back();
              Get.snackbar("Pesanan dihapus", "List pesanan berhasil di reset");
            },
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.blue[800],
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Text(
                  "Reset Pesanan",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontFamily: 'Poppins1',
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              orderController.createOrder();
            },
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                width: 200,
                decoration: BoxDecoration(
                    color: Color(0XffD57F42),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Text(
                  "Pesan",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontFamily: 'Poppins1',
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ),
          OrderReceipt(),
        ],
      ),
    );
  }
}
