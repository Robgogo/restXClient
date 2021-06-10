import 'package:flutter/material.dart';

import './screens/menu/menu_screen.dart';
import './screens/menu/menu_detail_screen.dart';
import './screens/orders/orders_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.red,
          backgroundColor: Colors.red[300],
          accentColor: Colors.deepOrange[300],
          accentColorBrightness: Brightness.dark,
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.red[400],
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          )),
      home: MenuScreen(),
      routes: {
        MenuScreen.routeName: (ctx) => MenuScreen(),
        MenuDetailScreen.routeName: (ctx) => MenuDetailScreen(),
        OrdersScreen.routeName: (ctx) => OrdersScreen(),
      },
    );
  }
}
