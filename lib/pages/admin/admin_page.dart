import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yumm_yum/controllers/admin/admin_page_controller.dart';
import 'package:yumm_yum/widgets/widget_support.dart';

class AdminPage extends StatelessWidget {
  final AdminPageController adminPageController =
      Get.put(AdminPageController());

  AdminPage({super.key});

  Image _getImageFromBase64(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.cover,
      height: 50,
      width: 50,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard Admin",
          style: AppWidget.HeadlineTextFeildStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed('/adminaddfood');
                },
                child: Material(
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Color(0xffD57F42),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image.asset(
                              "assets/images/food.jpg",
                              height: 75,
                              width: 75,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 30.0,
                          ),
                          const Text(
                            "Add Food Items",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/orderlist');
                },
                child: Material(
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image.asset(
                              "assets/images/salad.png",
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 30.0,
                          ),
                          const Text(
                            "Pesanan Masuk",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Obx(
                () {
                  if (adminPageController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (adminPageController.errorMessage.isNotEmpty) {
                    return Center(
                        child:
                            Text('Error: ${adminPageController.errorMessage}'));
                  }

                  if (adminPageController.foodItems.isEmpty) {
                    return Center(child: Text('No food items found.'));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: adminPageController.foodItems.length,
                    itemBuilder: (context, index) {
                      final docId = adminPageController.foodItems[index].id;
                      final doc = adminPageController.foodItems[index].data()
                          as Map<String, dynamic>;

                      final foodName = doc["name"] ?? 'Unknown Food';
                      final price = doc["price"] ?? '0';
                      final stock = doc["stock"] ?? '0';
                      final base64Image = doc["image"];
                      final detail = doc["detail"] ?? 'No details available';

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                // color: Color(0xffD57F42),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: base64Image != null
                                            ? _getImageFromBase64(base64Image)
                                            : Image.asset(
                                                "assets/images/food.jpg",
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        foodName,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            // color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Material(
                                        elevation: 1,
                                        borderRadius: BorderRadius.circular(5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            // border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          height: 25,
                                          width: 25,
                                          child: Text(
                                            '$stock',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Material(
                                        elevation: 1,
                                        borderRadius: BorderRadius.circular(5),
                                        child: GestureDetector(
                                          onTap: () {
                                            adminPageController.updateFoodStock(
                                                docId, stock - 1);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              // border: Border.all(),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            height: 25,
                                            width: 25,
                                            child: Text(
                                              '-',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Material(
                                        elevation: 1,
                                        borderRadius: BorderRadius.circular(5),
                                        child: GestureDetector(
                                          onTap: () {
                                            adminPageController.updateFoodStock(
                                                docId, stock + 1);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            height: 25,
                                            width: 25,
                                            child: Text(
                                              '+',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
