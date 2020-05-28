import 'package:Adte/widgets/article_card.dart';
import 'package:Adte/widgets/dashboard.dart';
import 'package:Adte/widgets/scroll_down_card.dart';
import 'package:Adte/widgets/component_title.dart';
import 'package:Adte/models/app_theme.dart';
import 'package:Adte/widgets/water_view.dart';
import 'package:flutter/material.dart';
import 'package:Adte/widgets/custom_app_bar.dart';
import 'package:Adte/models/article.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class AllPostScreen extends StatefulWidget {
  const AllPostScreen({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _AllPostScreenState createState() => _AllPostScreenState();
}

class _AllPostScreenState extends State<AllPostScreen>
    with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  final title = 'All posts';
  Future<List<Article>> futureArticles;

  @override
  void initState() {
    // addAllListData();
    super.initState();
    futureArticles = fetchArticles();
    futureArticles.then((value) {
      addAllListData(value);
    });
  }

  Future<List<Article>> fetchArticles() async {
    final response = await http.get('http://18.141.176.197:1337/articles');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return articleFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load articles');
    }
  }

  void addAllListData(List<Article> listArticle) {
    int count = 9;

    listViews.add(
      ComponentTitle(
        titleTxt: 'Dashboard',
        subTxt: 'more',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 6, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      Dashboard(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      ComponentTitle(
        titleTxt: 'Posts',
        subTxt: 'more',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 6, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );

    // listViews.add(Divider(
    //   height: 1,
    //   color: AppTheme.grey.withOpacity(0.6),
    // ));

    listArticle.forEach((element) {
      listViews.add(ArticleCard(
        animationController: widget.animationController,
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 5, 1.0, curve: Curves.fastOutSlowIn))),
        article: element,
      ));
    });

    listViews.add(
      ComponentTitle(
        titleTxt: 'Water',
        subTxt: 'Aqua SmartBottle',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 6, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      WaterView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController,
                curve: Interval((1 / count) * 7, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
      ),
    );
    listViews.add(
      ScrollDownCard(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve: Interval((1 / count) * 8, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController),
    );
  }

  // Future<bool> getData() async {
  //   await Future<dynamic>.delayed(const Duration(milliseconds: 50));
  //   return true;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            CustomAppBar(
                animationController: widget.animationController,
                scrollController: scrollController,
                title: title),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<List<Article>>(
      future: futureArticles,
      builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }
}
