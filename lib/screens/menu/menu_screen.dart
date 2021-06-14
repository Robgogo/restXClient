import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../widgets/user_info_form.dart';
import '../../widgets/menu/menu_builder.dart';
import '../orders/orders_screen.dart';
import '../../services/restaurant_service.dart';

class MenuScreen extends StatelessWidget {
  static const routeName = '/menu';
  final _auth = AuthService();
  Map queryParams = {};
  MenuScreen({this.queryParams = null});
  @override
  Widget build(BuildContext context) {
    final restService = RestaurantService();

    var _currentUser = _auth.getCurrentUser();
    if (_currentUser == null) {
      _auth.signInAnonymously();
    }

    return FutureBuilder(
      future: restService.getUserRestaurant(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return Container();
        }

        var restInfo = snapshot.data.data();

        return Scaffold(
          appBar: AppBar(
            title: Text('Menu-${restInfo != null ? restInfo["restName"] : ""}'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: Icon(Icons.payment),
                onPressed: () {
                  Navigator.of(context).pushNamed(OrdersScreen.routeName);
                },
              ),
              // IconButton(
              //   icon: Icon(Icons.exit_to_app),
              //   onPressed: () {
              //     _auth.signOut();
              //   },
              // ),
            ],
          ),
          backgroundColor: Colors.grey[300],
          body: FutureBuilder(
            future: _auth.getUserData(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData || snapshot.data.data() == null) {
                return UserInfo();
              }
              // print(queryParams);

              // var settings = ModalRoute.of(context).settings;
              // var uriData = Uri.parse(settings.name);
              // print(uriData);

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Text('Starters'),
                        ),
                        MenuBuilder(
                          category: 'starter',
                          restId: restInfo['restId'],
                          table: restInfo['table'],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Center(
                          child: Text('Main Dishes'),
                        ),
                        MenuBuilder(
                          category: 'main dish',
                          restId: restInfo['restId'],
                          table: restInfo['table'],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Center(
                          child: Text('Deserts'),
                        ),
                        MenuBuilder(
                          category: 'starter',
                          restId: restInfo['restId'],
                          table: restInfo['table'],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
