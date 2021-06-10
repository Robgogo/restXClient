import 'package:flutter/material.dart';

import '../../services/order_service.dart';

class OrderItem extends StatelessWidget {
  final _orderService = OrderService();

  final String id;
  final String name;
  final String orderedBy;
  final int tableId;
  final bool accepted;
  final bool served;

  OrderItem({
    this.id,
    this.name,
    this.orderedBy,
    this.tableId,
    this.accepted,
    this.served,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text('$orderedBy - table: ${tableId.toString()}'),
      leading: CircleAvatar(
        child: Icon(Icons.food_bank),
      ),
    );
  }
}
