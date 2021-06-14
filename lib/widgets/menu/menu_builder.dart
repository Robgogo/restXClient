import 'package:flutter/material.dart';

import './menu_item.dart';
import '../../services/menu_service.dart';

class MenuBuilder extends StatelessWidget {
  final _menuService = MenuService();
  final String category;
  final String restId;
  final int table;
  MenuBuilder({this.category, this.restId, this.table});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _menuService.filterByCategory(category, restId),
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
              item.id,
              item.data()['name'],
              item.data()['price'],
              item.data()['ingredients'],
              item.data()['image'],
              restId,
              table,
            );
          }).toList(),
        );
      },
    );
  }
}
