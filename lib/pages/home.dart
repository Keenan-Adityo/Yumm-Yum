import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yumm_yum/controllers/user/home_controller.dart';
import 'package:yumm_yum/controllers/user/order_controller.dart';
import 'package:yumm_yum/pages/details.dart';
import 'package:yumm_yum/styles/text_styles.dart';
import 'package:yumm_yum/widgets/widget_support.dart';

class Home extends StatelessWidget {
  final OrderController orderController = Get.find<OrderController>();
  final HomeController homeController = Get.put(HomeController());

  Home({super.key});

  Image _getImageFromBase64(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.cover,
      height: 120,
      width: 120,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yumm Yum!", style: AppWidget.boldTextFeildStyle()),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed('/basket');
              },
              icon: Icon(Icons.shopping_basket_outlined))
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Blater Super Delicious Food",
                style: AppWidget.HeadlineTextFeildStyle()),
            Text("Klik untuk masukan ke dalam keranjang",
                style: AppWidget.LightTextFeildStyle()),
            SizedBox(
              height: 20.0,
            ),
            Obx(
              () {
                if (homeController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (homeController.errorMessage.isNotEmpty) {
                  return Center(
                      child: Text('Error: ${homeController.errorMessage}'));
                }

                if (homeController.foodItems.isEmpty) {
                  return Center(child: Text('No food items found.'));
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: homeController.foodItems.length,
                    itemBuilder: (context, index) {
                      final docId = homeController.foodItems[index].id;
                      final doc = homeController.foodItems[index].data()
                          as Map<String, dynamic>;
                      final foodName = doc["name"] ?? 'Unknown Food';
                      final int price = doc["price"].toInt() ?? 0;
                      final base64Image = doc["image"];
                      final stock = doc["stock"] ?? '1';
                      final detail = doc["detail"] ?? 'No details available';

                      return GestureDetector(
                        onTap: () {
                          dialogDetail(context, base64Image, docId, foodName,
                              detail, price);
                          // Get.showOverlay(asyncFunction: asyncFunction)
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            right: 20.0,
                          ),
                          padding: EdgeInsets.only(bottom: 30),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  base64Image != null
                                      ? _getImageFromBase64(base64Image)
                                      : Image.asset(
                                          "assets/images/salad2.png",
                                          height: 120,
                                          width: 120,
                                          fit: BoxFit.cover,
                                        ),
                                  SizedBox(width: 20.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          foodName,
                                          style: AppWidget
                                              .semiBoldTextFeildStyle(),
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          detail,
                                          style:
                                              AppWidget.LightTextFeildStyle(),
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          'Tersisa : $stock buah',
                                          style:
                                              AppWidget.LightTextFeildStyle(),
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          "Rp.$price",
                                          style: AppWidget
                                              .semiBoldTextFeildStyle(),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> dialogDetail(BuildContext context, base64Image, String docId,
      foodName, detail, int price) {
    final TextEditingController count = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          height: 500,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              base64Image != null
                  ? _getImageFromBase64(base64Image)
                  : Image.asset(
                      "assets/images/salad2.png",
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                foodName,
                style: kSubTitle,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                detail,
                style: kText,
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  'Rp.$price',
                  style: kSubTitle,
                  textAlign: TextAlign.left,
                ),
              ),
              Spacer(),
              Container(
                width: double.infinity,
                child: Text(
                  "Jumlah pesanan",
                  style: kSubTitle,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xFFececf8),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: count,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Masukan jumlahnya",
                      hintStyle: AppWidget.LightTextFeildStyle()),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    orderController.addOrder(
                        docId, foodName, int.parse(count.text), price);
                  },
                  child: Text('Tambahkan ke keranjang')),
            ],
          ),
        ),
      ),
    );
  }
}
