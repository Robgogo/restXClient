import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './auth_service.dart';

class Restaurant {
  final String restId;
  final String name;
  final int table;
  Restaurant(
    this.restId,
    this.name,
    this.table,
  );
}

class RestaurantService {
  var auth = AuthService();
  User user = AuthService().getCurrentUser();

  final userRestaurantCollection =
      FirebaseFirestore.instance.collection("user-restaurant");
  final restaurantCollection = FirebaseFirestore.instance.collection("users");

  Future<void> addUserRestaurant(String restId, int table) async {
    var restaurant = await getRestaurantInfo(restId);

    await userRestaurantCollection.doc(user.uid).set({
      'uid': user.uid,
      'restId': restaurant.id,
      'restName': restaurant.data()['username'],
      'table': table,
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserRestaurant() async {
    return await userRestaurantCollection.doc(user.uid).get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getRestaurantInfo(
      String id) async {
    return await restaurantCollection.doc(id).get();
  }
}
