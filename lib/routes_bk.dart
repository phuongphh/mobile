import 'package:Toot/resources/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:Toot/models/app_theme.dart';
import 'package:Toot/custom_drawer/drawer_user_controller.dart';
import 'package:Toot/custom_drawer/home_drawer.dart';
import 'package:Toot/screens/feedback_screen.dart';
import 'package:Toot/screens/app_home_screen.dart';
import 'package:Toot/screens/help_screen.dart';
import 'package:Toot/screens/invite_friend_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class NavigationHomeScreen extends StatelessWidget {
  final UserRepository userRepository;
  NavigationHomeScreen({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  // Text screenTitle;
  Widget screenView;
  DrawerIndex drawerIndex;

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        screenView = AppHomeScreen();
      }
    } else if (drawerIndex == DrawerIndex.Help) {
      screenView = HelpScreen();
    } else if (drawerIndex == DrawerIndex.FeedBack) {
      screenView = FeedbackScreen();
    } else if (drawerIndex == DrawerIndex.Invite) {
      screenView = InviteFriend();
    } else {
      //do in your way......
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }
}
