import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yumm_yum/pages/details.dart';
import 'package:yumm_yum/widgets/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecream = false, pizza = false, salad = false, burger = false;

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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text("Yumm Yum!", style: AppWidget.boldTextFeildStyle()),
            //     Container(
            //       margin: EdgeInsets.only(right: 20.0),
            //       padding: EdgeInsets.all(3),
            //       decoration: BoxDecoration(
            //           color: Colors.black,
            //           borderRadius: BorderRadius.circular(8)),
            //       child: Icon(
            //         Icons.shopping_cart_outlined,
            //         color: Colors.white,
            //       ),
            //     )
            //   ],
            // ),
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
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("Food").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                final data = snapshot.data?.docs ?? [];
                if (data.isEmpty) {
                  return Center(child: Text("No food items found."));
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final doc = data[index];
                      final foodName = doc["name"];
                      final price = doc["price"];
                      final base64Image = doc["image"];

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
                                SizedBox(
                                  width: 20.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          foodName,
                                          style: AppWidget
                                              .semiBoldTextFeildStyle(),
                                        )),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          doc["detail"],
                                          style:
                                              AppWidget.LightTextFeildStyle(),
                                        )),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          "Rp.$price",
                                          style: AppWidget
                                              .semiBoldTextFeildStyle(),
                                        )),
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
