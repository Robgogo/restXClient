import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../screens/menu/menu_screen.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  var _name = '';

  _submitForm() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      print("Saving $_name");
      await _auth.saveUserName(_name.trim());
      Navigator.of(context).pushReplacementNamed(MenuScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Please insert your name'),
      content: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                key: ValueKey('name'),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please insert your name so that we can serve you better";
                  }
                  if (value.length < 2) {
                    return "Please insert a valid name!";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                onSaved: (value) {
                  _name = value;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        Center(
          child: ElevatedButton(
            child: Text("Submit"),
            onPressed: _submitForm,
          ),
        ),
      ],
    );
  }
}
