import 'package:Adte/models/app_theme_bk.dart';
import 'package:Adte/widgets/login_ui.dart';
import 'package:flutter/material.dart';
import 'package:Adte/widgets/login_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key, this.reason, this.callback}) : super(key: key);
  final String reason;
  final Function callback;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBackground loginBackground;
  
  @override
  void initState() {
    loginBackground = const LoginBackground();
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
                LoginUi(reason: widget.reason, callback: widget.callback),
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
