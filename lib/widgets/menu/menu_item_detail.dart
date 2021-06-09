import 'package:flutter/material.dart';

class MenuItemDetail extends StatelessWidget {
  final String image;
  final String ingredients;
  final String name;
  final double price;
  final String id;

  MenuItemDetail(
      {this.id, this.image, this.ingredients, this.name, this.price});

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
