import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './auth_service.dart';

class OrderService {
  var auth = AuthService();
  User user = AuthService().getCurrentUser();

  final orderCollection = FirebaseFirestore.instance.collection("orders");

  Stream<QuerySnapshot<Map<String, dynamic>>> get streamobject {
    return orderCollection
        .orderBy('createdAt', descending: true)
        .where('customerId', isEqualTo: user.uid)
        .snapshots();
  }

  Future<void> addOrder(
    String menuId,
    double price,
    String name, {
    String restId,
    int table,
  }) async {
    await orderCollection.add({
      'name': name,
      'menuId': menuId,
      'price': price,
      'customerId': user.uid,
      'restId': restId,
      'table': table,
      'accepted': false,
      'served': false,
      'paid': false,
      'createdAt': Timestamp.now(),
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getOrders() async {
    return await orderCollection
        .orderBy('createdAt', descending: true)
        .where('customerId', isEqualTo: user.uid)
        .get();
  }
}
