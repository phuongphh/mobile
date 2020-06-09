import 'package:Adte/models/app_theme_bk.dart';
import 'package:Adte/widgets/login_ui.dart';
import 'package:flutter/material.dart';
import 'package:Adte/widgets/login_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key, this.reason}) : super(key: key);
  final String reason;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBackground loginBackground;
  LoginUi loginUi;
  
  @override
  void initState() {
    loginBackground = const LoginBackground();
    loginUi = LoginUi(reason: widget.reason);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: new GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Stack(
              children: <Widget>[
                loginBackground,
                loginUi,
                Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: SizedBox(
                    width: AppBar().preferredSize.height,
                    height: AppBar().preferredSize.height,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                            AppBar().preferredSize.height),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AppTheme.nearlyBlack,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}
