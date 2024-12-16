import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yumm_yum/controllers/user/home_controller.dart';
import 'package:yumm_yum/pages/details.dart';
import 'package:yumm_yum/widgets/widget_support.dart';

class Home extends StatelessWidget {
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
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Yumm Yum!", style: AppWidget.boldTextFeildStyle()),
            SizedBox(
              height: 20.0,
            ),
            Text("Healthy Food", style: AppWidget.HeadlineTextFeildStyle()),
            Text("Blater Super Delicious Food",
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
                      final doc = homeController.foodItems[index].data()
                          as Map<String, dynamic>;
                      final foodName = doc["name"] ?? 'Unknown Food';
                      final price = doc["price"] ?? '0';
                      final base64Image = doc["image"];
                      final detail = doc["detail"] ?? 'No details available';

                      return Container(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        foodName,
                                        style:
                                            AppWidget.semiBoldTextFeildStyle(),
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        detail,
                                        style: AppWidget.LightTextFeildStyle(),
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        "Rp.$price",
                                        style:
                                            AppWidget.semiBoldTextFeildStyle(),
                                      ),
                                    ),
                                  ],
                                )
                              ],
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
}
