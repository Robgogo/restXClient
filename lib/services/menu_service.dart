import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './auth_service.dart';

class MenuService {
  var auth = AuthService();
  User user = AuthService().getCurrentUser();
  FirebaseStorage storage = FirebaseStorage.instance;

  final menuCollection = FirebaseFirestore.instance.collection("menu");

  Stream<QuerySnapshot<Map<String, dynamic>>> filterByRest(String restId) {
    return menuCollection.where('restId', isEqualTo: restId).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> filterByCategory(
      String category) {
    // Add restId filter here also
    return menuCollection.where('category', isEqualTo: category).snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getMenuDetail(String id) {
    return menuCollection.doc(id).get();
  }
}
