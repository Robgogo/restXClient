import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class DefaultScreen extends StatelessWidget {
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    var _currentUser = _auth.getCurrentUser();
    if (_currentUser == null) {
      _auth.signInAnonymously();
    }
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Just a default screen"),
        ),
      ),
    );
  }
}
