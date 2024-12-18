import 'package:cloud_firestore/cloud_firestore.dart';

class OrderItem {
  final String id;
  final String name;
  final int count;
  final int price;

  OrderItem(this.id, this.name, this.count, this.price);
}

class Orders {
  final String email;
  final List<OrderItem> orderItems;
  final int sum;
  final String notes;
  final bool done;

  Orders({
    required this.email,
    required this.orderItems,
    required this.sum,
    required this.notes,
    required this.done,
  });

  factory Orders.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Ensure orderItems is a list of maps, then convert each map into an OrderItem
    List<OrderItem> orderItems = [];
    if (data['orders'] != null) {
      orderItems = List<OrderItem>.from(
        data['orders'].map((item) => OrderItem(
              item['id'] ?? '',
              item['name'] ?? '',
              item['count'] ?? 0,
              item['price'] ?? 0,
            )),
      );
    }

    return Orders(
      email: data['email'] ?? '',
      orderItems: orderItems,
      sum: data['sum'] ?? 0,
      notes: data['notes'] ?? '',
      done: data['done'] ?? false,
    );
  }
}
