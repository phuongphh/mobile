import 'package:Adte/widgets/login_ui.dart';
import 'package:flutter/material.dart';
import 'package:Adte/widgets/login_background.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            LoginBackground(),
            LoginUi(),
          ],
        ));
  }
}
