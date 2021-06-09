import 'package:flutter/material.dart';

import '../../services/menu_service.dart';
import '../../widgets/menu/menu_item_detail.dart';

class MenuDetailScreen extends StatefulWidget {
  static const routeName = '/menu/detail';

  @override
  _MenuDetailScreenState createState() => _MenuDetailScreenState();
}

class _MenuDetailScreenState extends State<MenuDetailScreen> {
  final _menuService = MenuService();
  String _id;

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _id = ModalRoute.of(context).settings.arguments;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final id = ModalRoute.of(context).settings.arguments;
    return FutureBuilder(
      future: _menuService.getMenuDetail(_id),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final doc = snapshot.data.data();
        return Scaffold(
          appBar: AppBar(
            title: Text(doc['name']),
          ),
          body: MenuItemDetail(
            name: doc['name'],
            price: doc['price'],
            image: doc['image'],
            ingredients: doc['ingredients'],
            id: _id,
          ),
        );
      },
    );
  }
}
