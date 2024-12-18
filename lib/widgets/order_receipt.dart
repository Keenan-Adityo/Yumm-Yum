import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yumm_yum/controllers/user/order_controller.dart';
import 'package:yumm_yum/styles/text_styles.dart';
import 'package:yumm_yum/widgets/widget_support.dart';

class OrderReceipt extends StatelessWidget {
  OrderReceipt({
    super.key,
  });

  final OrderController orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (_) {
      return Container(
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
                    itemCount: orderController.order.length,
                    itemBuilder: (context, index) => Text(
                      orderController.order[index].name,
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
                    itemCount: orderController.order.length,
                    itemBuilder: (context, index) => Text(
                      "${orderController.order[index].count} pcs x Rp.${orderController.order[index].price}",
                      style: kText,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ],
            ),
            HorizontalLine(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Jumlah",
                  style: kSubTitle,
                ),
                Text(
                  "Rp.${orderController.sum}",
                  style: kSubTitle,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "notes :",
                  style: kSubTitle,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xFFececf8),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    maxLines: 6,
                    controller: orderController.notes,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Masukkan notes",
                        hintStyle: AppWidget.LightTextFeildStyle()),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
    );
  }
}
