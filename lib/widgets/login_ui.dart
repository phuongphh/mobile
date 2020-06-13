import 'dart:convert';

import 'package:Adte/main.dart';
import 'package:Adte/models/app_const.dart';
import 'package:Adte/models/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:Adte/widgets/login_input.dart';

import 'package:http/http.dart' as http;
import 'dart:async';

class LoginUi extends StatefulWidget {
  const LoginUi({Key key, this.animationController, this.reason})
      : super(key: key);
  final AnimationController animationController;
  final String reason;

  @override
  _LoginUiState createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  final textController = TextEditingController();
  String userId;
  String token;

  List<Widget> listViews = <Widget>[];
  String title;
  bool warning = false;
  bool obscure = false;
  String warningMessage;
  String guidance = 'Enter your email id to continue... !';
  String hint;
  LoginSteps loginStep;
  String currentEmail;
  String currentPassword;

  @override
  void initState() {
    loginStep = LoginSteps.InputEmail;
    title = 'Email';
    hint = 'someone@example.com';

    super.initState();
    addViews(loginStep);
  }

  @override
  void dispose() {
    textController.dispose();
    listViews.clear();
    super.dispose();
  }

  void addViews(LoginSteps loginStep) {
    listViews.clear();
    listViews.add(
      Padding(
        padding: EdgeInsets.only(left: 40, bottom: 10),
        child: Text(
          widget.reason,
          style: TextStyle(fontSize: 16, color: AppTheme.nearlyDarkBlue),
        ),
      ),
    );
    listViews.add(
      Padding(
        padding: EdgeInsets.only(left: 40, bottom: 10),
        child: Text(
          title,
          style: TextStyle(fontSize: 16, color: Color(0xFF999A9A)),
        ),
      ),
    );

    listViews.add(
      Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          LoginInput(
            topRight: 30.0,
            bottomRight: 0.0,
            textController: textController,
            hint: hint,
            obscure: obscure,
          ),
          Padding(
              padding: EdgeInsets.only(right: 50),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      guidance,
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 12),
                    ),
                  )),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: ShapeDecoration(
                        shape: CircleBorder(),
                        gradient: LinearGradient(
                            colors: signInGradients,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            borderRadius: BorderRadius.circular(40),
                            onTap: () {
                              signInSubmission(loginStep);
                            },
                            child: ImageIcon(
                              AssetImage("assets/images/ic_forward.png"),
                              size: 40,
                              color: Colors.white,
                            )),
                      )),
                ],
              ))
        ],
      ),
    );

    if (warning) {
      listViews.add(
        Padding(
          padding: EdgeInsets.only(left: 40, bottom: 10),
          child: Text(
            warningMessage,
            style: TextStyle(fontSize: 16, color: AppTheme.warningRed),
          ),
        ),
      );
    }

    listViews.add(
      Padding(
        padding: EdgeInsets.only(bottom: 50),
      ),
    );

    if (loginStep == LoginSteps.InputEmail) {
      listViews.add(
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 40, bottom: 10),
        ),
        roundedRectButton("Let's get Started", signInGradients, false),
        roundedRectButton("Create an Account", signUpGradients, false),
      ]));
    } else if (loginStep == LoginSteps.InputPassword) {
      listViews.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            roundedRectButton("Let's get Started", signInGradients, false),
          ]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.3),
        ),
        Column (
          children: listViews,
        )
      ],
    );
  }

  void signInSubmission(LoginSteps loginStep) {
    if (loginStep == LoginSteps.InputEmail) {
      // email is valid
      if (_validateEmail(textController.text)) {
        setState(() {
          print(loginStep);
          currentEmail = textController.text;
          title = 'Email | Password >>';
          guidance = 'Enter your password ...';
          textController.clear();
          warning = false;
          obscure = true;
          loginStep = LoginSteps.InputPassword;
          hint = 'your password';
          addViews(loginStep);
        });
      } else {
        setState(() {
          warning = true;
          warningMessage = "email invalid !";
          addViews(loginStep);
        });
      }
    } else if (loginStep == LoginSteps.InputPassword) {
      print(loginStep);
      currentPassword = textController.text;
      _validatePassword(currentEmail, currentPassword).then((value) async {
        if (value) {
          await storage.write(key: "jwt", value: token);
          await storage.write(key: "userId", value: userId);
          _showDialog();
        } else {
          warning = true;
          warningMessage = 'wrong password';
          loginStep = LoginSteps.ForgotPassword;
          addViews(loginStep);
        }
      });
    }
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Success !"),
          content: new Text("You are logged in !"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  bool _validateEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(email)) ? false : true;
  }

  Future<bool> _validatePassword(String email, String password) async {
    final response = await http.post('$SERVER_URL/auth/local',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'identifier': email,
          'password': password,
        }));
    token = json.decode(response.body)["jwt"];
    userId = json.decode(response.body)["user"]["id"];
    print(response.body);
    print(userId);
    return (response.statusCode == 200);
  }
}

Widget roundedRectButton(
    String title, List<Color> gradient, bool isEndIconVisible) {
  return Builder(builder: (BuildContext mContext) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Stack(
        alignment: Alignment(1.0, 0.0),
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(mContext).size.width / 1.7,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              gradient: LinearGradient(
                  colors: gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: Text(title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
            padding: EdgeInsets.only(top: 16, bottom: 16),
          ),
          Visibility(
            visible: isEndIconVisible,
            child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: ImageIcon(
                  AssetImage("assets/images/ic_forward.png"),
                  size: 30,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  });
}

const List<Color> signInGradients = [
  AppTheme.nearlyBlue,
  AppTheme.nearlyDarkBlue,
];

const List<Color> signUpGradients = [
  Color(0xFFFF9945),
  Color(0xFFFc6076),
];

enum LoginSteps {
  InputEmail,
  InputPassword,
  ForgotPassword,
  CreateAccount,
}
