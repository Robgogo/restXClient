import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import './menu_item.dart';

class MenuBuilder extends StatelessWidget {
  final String category;
  MenuBuilder({this.category});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("menu")
          .where('category', isEqualTo: category)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final documents = snapshot.data.docs as List;
        return GridView(
          padding: EdgeInsets.all(15),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          children: documents.map((item) {
            return MenuItem(
              item.data()['name'],
              item.data()['price'],
              item.data()['ingredients'],
              item.data()['image'],
            );
          }).toList(),
        );
      },
    );
  }
}
