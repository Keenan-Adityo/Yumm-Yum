import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yumm_yum/controllers/admin/order_list_controller.dart';
import 'package:yumm_yum/controllers/user/order_controller.dart';
import 'package:yumm_yum/services/database.dart';
import 'package:yumm_yum/services/shared_pref.dart';
import 'package:yumm_yum/services/database.dart';
import 'package:yumm_yum/services/shared_pref.dart';
import 'package:yumm_yum/styles/text_styles.dart';
import 'package:yumm_yum/widgets/order_receipt.dart';
import 'package:yumm_yum/widgets/widget_support.dart';

class OrderListPage extends StatefulWidget {
  OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  final OrderListController orderController = Get.put(OrderListController());

  @override
  void initState() {
    orderController.fetchOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("List Pesanan Pelanggan",
              style: AppWidget.boldTextFeildStyle()),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Obx(() {
            if (orderController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }

            if (orderController.errorMessage.isNotEmpty) {
              return Center(
                  child: Text('Error: ${orderController.errorMessage}'));
            }

            if (orderController.orders.isEmpty) {
              return Center(child: Text('No Orders found.'));
            }

            return ListView.builder(
              itemCount: orderController.orders.length,
              itemBuilder: (context, index) {
                print(orderController.orders.length);
                final item = orderController.orders[index];
                return Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 1,
                            offset: Offset(1, 2),
                          ),
                        ],
                        color: ThemeData().scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Text(
                          "Pesanan",
                          style: kSubTitle,
                        ),
                        HorizontalLine(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: orderController
                                    .orders[index].orderItems.length,
                                itemBuilder: (context, idx) => Text(
                                  orderController
                                      .orders[index].orderItems[idx].name,
                                  overflow: TextOverflow.ellipsis,
                                  style: kText,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: orderController
                                    .orders[index].orderItems.length,
                                itemBuilder: (context, idx) => Text(
                                  "${orderController.orders[index].orderItems[idx].count} pcs",
                                  style: kText,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),
                          ],
                        ),
                        HorizontalLine(),
                        Text(
                          item.notes,
                          style: kText,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ));
  }
}
