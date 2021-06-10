import 'package:flutter/material.dart';

import '../../widgets/orders/order_item.dart';
import '../../services/order_service.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  final _orderService = OrderService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      body: FutureBuilder(
        future: _orderService.getOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = snapshot.data.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, i) => Column(
              children: [
                OrderItem(
                  id: documents[i].id,
                  name: documents[i].data()['name'],
                  orderedBy: documents[i].data()['orderedBy'],
                  tableId: documents[i].data()['table'],
                  accepted: documents[i].data()['accepted'],
                  served: documents[i].data()['served'],
                ),
                Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}
