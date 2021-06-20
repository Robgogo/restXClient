import 'package:flutter/material.dart';

import '../../widgets/payment/payment_item.dart';
import '../../services/order_service.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = '/payment';

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _orderService = OrderService();

  var total_price = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Payment summary"),
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
          documents.forEach((element) {
            total_price += element.data()['price'];
          });
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: documents.length,
                itemBuilder: (ctx, i) {
                  return Column(
                    children: [
                      PaymentItem(
                        id: documents[i].id,
                        name: documents[i].data()['name'],
                        tableId: documents[i].data()['table'],
                        price: documents[i].data()['price'],
                        paid: documents[i].data()['paid'],
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
              TextButton(
                  onPressed: () {}, child: Text("Total Price: \$$total_price"))
            ],
          );
        },
      ),
    );
  }
}
