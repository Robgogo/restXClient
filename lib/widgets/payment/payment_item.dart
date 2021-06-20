import 'package:flutter/material.dart';

import '../../services/order_service.dart';

class PaymentItem extends StatelessWidget {
  final _orderService = OrderService();

  final String id;
  final String name;
  final int tableId;
  final double price;
  final bool paid;

  PaymentItem({
    this.id,
    this.name,
    this.tableId,
    this.price,
    this.paid,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text('table: ${tableId.toString()}'),
      leading: CircleAvatar(
        child: Icon(Icons.food_bank),
      ),
      trailing: FittedBox(
        fit: BoxFit.contain,
        child: Row(
          children: [
            Text("$price"),
          ],
        ),
      ),
    );
  }
}
