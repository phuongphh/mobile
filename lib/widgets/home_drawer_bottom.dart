import 'package:Toot/models/app_theme.dart';
import 'package:flutter/material.dart';

class HomeDrawerBottom extends StatefulWidget {
  HomeDrawerBottom({Key key, this.title, this.icon, this.submitFunction}) : super(key: key);
  final String title;
  final Icon icon;
  final Function submitFunction;
  
  @override
  _HomeDrawerBottomState createState() => _HomeDrawerBottomState();
}

class _HomeDrawerBottomState extends State<HomeDrawerBottom> {  
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          ListTile(
            title: Text(
              widget.title,
              style: TextStyle(
                fontFamily: AppTheme.fontName,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppTheme.darkText,
              ),
              textAlign: TextAlign.left,
            ),
            trailing: widget.icon,
            onTap: () {
              widget.submitFunction();
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      );
  }
}
