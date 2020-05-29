import 'package:Adte/models/app_theme.dart';
import 'package:Adte/themes/article_card_theme.dart';
import 'package:flutter/material.dart';
import 'package:Adte/models/article.dart';

class ArticleCard extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;
  final Article article;

  const ArticleCard(
      {Key key, this.animationController, this.animation, this.article})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: AppTheme.articleCardPadding(context),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: ArticleCardTheme.articleCardBorderRadius,
                  boxShadow: <BoxShadow>[ArticleCardTheme.articleCardBoxShadow],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 8, bottom: 8),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 4, right: 4, top: 4, bottom: 4),
                            child: Text(
                              article.description,
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              style: ArticleCardTheme.titleTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 16),
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: AppTheme.background,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12, top: 12, bottom: 12),
                                child: Container(
                                  child: Text(
                                    article.content,
                                    style: TextStyle(
                                        fontFamily: AppTheme.fontName,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: AppTheme.darkText),
                                  ),
                                ))),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 2, right: 2, top: 2, bottom: 2),
                            child: Container(
                                width: 100.0,
                                height: 100.0,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    article.content,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: AppTheme.fontName,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: AppTheme.darkText),
                                  ),
                                ))),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 16),
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: AppTheme.background,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 8, bottom: 8),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 4, right: 4, top: 4, bottom: 4),
                            child: Text(
                              'footer',
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              style: ArticleCardTheme.titleTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
