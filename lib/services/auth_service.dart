import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final customerCollection = FirebaseFirestore.instance.collection("customers");
  Future<UserCredential> signInAnonymously() async {
    var user = await FirebaseAuth.instance.signInAnonymously();
    return user;
  }

  Future<void> saveUserName(String name) async {
    final user = getCurrentUser();
    await FirebaseFirestore.instance
        .collection('customers')
        .doc(user.uid)
        .set({'name': name, 'uid': user.uid});
  }

  User getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    var user = getCurrentUser();
    var userData = await FirebaseFirestore.instance
        .collection("customers")
        .doc(user.uid)
        .get();
    return userData;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get streamobject {
    return customerCollection
        .where('uid', isEqualTo: getCurrentUser().uid)
        .snapshots();
  }
}
