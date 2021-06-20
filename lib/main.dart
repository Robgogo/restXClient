import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/menu/menu_screen.dart';
import './screens/menu/menu_detail_screen.dart';
import './screens/orders/orders_screen.dart';
import './screens/payment/payment_screen.dart';
import './services/restaurant_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map queryParams;
    // var settings = ModalRoute.of(context).settings;
    // var uriData = Uri.parse(settings.name);
    // print(uriData);
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
        PaymentScreen.routeName: (ctx) => PaymentScreen(),
      },
      onGenerateRoute: (settings) {
        final restService = RestaurantService();
        if (settings.name != null) {
          var uriData = Uri.parse(settings.name);
          queryParams = uriData.queryParameters;
        }
        // print(queryParams);
        restService.addUserRestaurant(
            queryParams['restId'], int.parse(queryParams['table']));
        return MaterialPageRoute(
          builder: (ctx) {
            return MenuScreen(
              queryParams: queryParams,
            );
          },
        );
      },
    );
  }
}
