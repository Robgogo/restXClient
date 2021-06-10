import 'package:flutter/material.dart';

import '../../screens/menu/menu_detail_screen.dart';
import '../../services/order_service.dart';

class MenuItem extends StatelessWidget {
  final _orderService = OrderService();
  final String id;
  final String name;
  final double price;
  final String ingredients;
  final String image;

  MenuItem(
    this.id,
    this.name,
    this.price,
    this.ingredients,
    this.image,
  );

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              MenuDetailScreen.routeName,
              arguments: id,
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
            clipBehavior: Clip.hardEdge,
          )),
      footer: GridTileBar(
        backgroundColor: Colors.black45,
        title: Text(name),
        subtitle: Text(ingredients),
        trailing: Row(
          children: [
            Text(
              price.toString(),
              style: TextStyle(color: Colors.white),
            ),
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  _orderService.addOrder(id, price, name);
                  // Navigator.of(context).pop();
                }),
          ],
        ),
      ),
    );
  }
}
