import 'package:Toot/hotel_booking/hotel_home_screen.dart';
import 'package:Toot/models/app_const.dart';
import 'package:Toot/screens/champion_screen.dart';
import 'package:Toot/login/view/view.dart';
import 'package:Toot/screens/login_screen.dart';
import 'package:Toot/screens/post_article_screen.dart';
import 'package:flutter/material.dart';

import 'package:Toot/models/tabIcon_data.dart';
import 'package:Toot/screens/handmades_screen.dart';
import 'package:Toot/screens/services_screen.dart';
import 'package:Toot/widgets/bottom_bar_view.dart';
import 'package:Toot/models/app_theme.dart';
import 'package:Toot/screens/all_post_screen_bk.dart';
import 'package:Toot/design_course/home_design_course.dart';
import 'package:Toot/models/globals.dart' as globals;
import 'package:Toot/resources/user_repository.dart';

class AppHomeScreen extends StatefulWidget {
  const AppHomeScreen({Key key}) : super(key: key);

  @override
  _AppHomeScreenState createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  String token;
  String userId;

  Widget tabBody = Container(
    color: AppTheme.background,
  );

  @override
  void initState() {
    _getUserAuthenInfo.call();

    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = AllPostScreen(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(context),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar(BuildContext context) {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {
            moveTo(context);
          },
          changeIndex: (int index) {
            switch (index) {
              case 0:
                {
                  animationController.reverse().then<dynamic>((data) {
                    if (!mounted) {
                      return;
                    }
                    setState(() {
                      tabBody = AllPostScreen(
                          animationController: animationController);
                    });
                  });
                }
                break;

              case 1:
                {
                  animationController.reverse().then<dynamic>((data) {
                    if (!mounted) {
                      return;
                    }
                    setState(() {
                      tabBody = ServicesScreen(
                          animationController: animationController);
                    });
                  });
                }
                break;

              case 2:
                {
                  animationController.reverse().then<dynamic>((data) {
                    if (!mounted) {
                      return;
                    }
                    setState(() {
                      tabBody = HandmadesScreen(
                          animationController: animationController);
                    });
                  });
                }
                break;

              case 3:
                {
                  animationController.reverse().then<dynamic>((data) {
                    if (!mounted) {
                      return;
                    }
                    setState(() {
                      tabBody = LoginPage();
                    });
                  });
                }
                break;
            }
          },
        ),
      ],
    );
  }

  void _getUserAuthenInfo() async {
    token = await globals.storage.read(key: "jwt");
    userId = await globals.storage.read(key: "userId");
    if (userId == null)
      globals.isLoggedIn = false;
    else
      globals.isLoggedIn = true;

    print('app_home_screen: $userId ${globals.isLoggedIn}');
  }
}

void moveTo(BuildContext context) {
  if (!globals.isLoggedIn) {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) =>
            LoginScreen(reason: POST_ARTICLE_LOGIN),
      ),
    );
  } else {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => PostArticleScreen(),
      ),
    );
  }
}
