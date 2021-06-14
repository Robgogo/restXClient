import 'package:flutter/material.dart';

import '../../services/order_service.dart';
import '../../services/restaurant_service.dart';

class MenuItemDetail extends StatelessWidget {
  final _orderService = OrderService();
  final restService = RestaurantService();
  final String image;
  final String ingredients;
  final String name;
  final double price;
  final String id;

  MenuItemDetail(
      {this.id, this.image, this.ingredients, this.name, this.price});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: restService.getUserRestaurant(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Container();
          }

          var restInfo = snapshot.data.data();
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.network(
                        image,
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("Dish name: $name"),
                    SizedBox(
                      height: 8,
                    ),
                    Text("Ingredients: $ingredients"),
                    SizedBox(
                      height: 8,
                    ),
                    Text("price: ${price.toString()}"),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Text('ORDER'),
                        onPressed: () {
                          _orderService.addOrder(id, price, name,
                              restId: restInfo['restId'],
                              table: restInfo['table']);
                          Navigator.of(context).pop();
                        },
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
