import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../widgets/user_info_form.dart';
import '../../widgets/menu/menu_builder.dart';
import '../orders/orders_screen.dart';

class MenuScreen extends StatelessWidget {
  static const routeName = '/menu';
  final _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    var _currentUser = _auth.getCurrentUser();
    if (_currentUser == null) {
      _auth.signInAnonymously();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Menu-restName'),
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
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
