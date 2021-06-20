import 'package:flutter/material.dart';

import '../../widgets/orders/order_item.dart';
import '../../services/order_service.dart';
import '../payment/payment_screen.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  final _orderService = OrderService();

  _showMessageDialog(BuildContext context) => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Select Payment type:"),
          content: Container(
            width: double.infinity,
            height: 70,
            child: Column(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(PaymentScreen.routeName);
                    },
                    child: Text("Pay only your Orders")),
                TextButton(
                    onPressed: () {}, child: Text("Pay for entire table")),
              ],
            ),
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
        actions: [
          TextButton(
            onPressed: () {
              _showMessageDialog(context);
            },
            child: Text(
              'Pay Now',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _orderService.streamobject,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = snapshot.data.docs;
          print(documents);
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, i) => Column(
              children: [
                OrderItem(
                  id: documents[i].id,
                  name: documents[i].data()['name'],
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
