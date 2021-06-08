import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MenuDetailScreen extends StatelessWidget {
  static const routeName = '/menu/detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('menu').doc(id).get(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(snapshot.data.data()['name']),
          ),
          body: Text("workin"),
        );
      },
    );
  }
}
