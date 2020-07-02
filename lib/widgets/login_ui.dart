import 'dart:convert';

import 'package:Toot/custom_drawer/drawer_user_controller.dart';
import 'package:Toot/models/globals.dart' as globals;
import 'package:Toot/models/app_const.dart';
import 'package:Toot/models/app_theme.dart';
import 'package:Toot/screens/post_article_screen.dart';
import 'package:flutter/material.dart';
import 'package:Toot/widgets/login_input.dart';

import 'package:http/http.dart' as http;
import 'dart:async';

class LoginUi extends StatefulWidget {
  const LoginUi({Key key, this.animationController, this.reason, this.callback})
      : super(key: key);
  final AnimationController animationController;
  final String reason;
  final VoidCallback callback;

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
                              submissionFunction(loginStep).call();
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
    } else if (loginStep == LoginSteps.ForgotPassword) {
      listViews.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            roundedRectButton("Send to email", signInGradients, false),
          ]));
    }
  }

  Widget roundedRectButton(
      String title, List<Color> gradient, bool isEndIconVisible) {
    return Builder(builder: (BuildContext mContext) {
      return Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: () {
              submissionFunction(loginStep);
            },
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
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.3),
        ),
        Column(
          children: listViews,
        )
      ],
    );
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
                Navigator.of(context).pop();
                _openPostArticleScreen();
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

    if (response.statusCode == 200) {
      token = json.decode(response.body)["jwt"];
      userId = json.decode(response.body)["user"]["id"];
      return true;
    } else
      return false;
  }

  void submitEmail() {
    if (_validateEmail(textController.text)) {
      setState(() {
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
  }

  void _openPostArticleScreen() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => PostArticleScreen(),
      ),
    );
  }

  void submitPassword() {
    currentPassword = textController.text;
    _validatePassword(currentEmail, currentPassword).then((value) async {
      if (value == true) {
        await globals.storage.write(key: "jwt", value: token);
        await globals.storage.write(key: "userId", value: userId);
        globals.isLoggedIn = true;
        _showDialog();
      } else {
        warning = true;
        warningMessage = 'wrong password';
        loginStep = LoginSteps.ForgotPassword;
        addViews(loginStep);
      }
    });
  }

  void submitCreateAccount() {
    print(loginStep);
    currentPassword = textController.text;
    _validatePassword(currentEmail, currentPassword).then((value) async {
      if (value) {
        await globals.storage.write(key: "jwt", value: token);
        await globals.storage.write(key: "userId", value: userId);
        _showDialog();
      } else {
        warning = true;
        warningMessage = 'wrong password';
        loginStep = LoginSteps.ForgotPassword;
        addViews(loginStep);
      }
    });
  }

  void submitForgotPassword() {
    print(loginStep);
    currentPassword = textController.text;
    _validatePassword(currentEmail, currentPassword).then((value) async {
      if (value) {
        await globals.storage.write(key: "jwt", value: token);
        await globals.storage.write(key: "userId", value: userId);
        _showDialog();
      } else {
        warning = true;
        warningMessage = 'wrong password';
        loginStep = LoginSteps.ForgotPassword;
        addViews(loginStep);
      }
    });
  }

  Function submissionFunction(LoginSteps loginStep) {
    if (loginStep == LoginSteps.InputEmail) {
      return submitEmail;
    } else if (loginStep == LoginSteps.InputPassword) {
      return submitPassword;
    } else if (loginStep == LoginSteps.CreateAccount) {
      return submitCreateAccount;
    } else {
      //ForgotPassword case
      return submitForgotPassword;
    }
  }
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
