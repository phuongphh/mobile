import 'package:Adte/models/app_const.dart';
import 'package:Adte/models/app_theme.dart';
import 'package:Adte/themes/article_card_theme.dart';
import 'package:flutter/material.dart';
import 'package:Adte/models/article.dart';
import 'package:intl/intl.dart';

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              article.description,
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              style: ArticleCardTheme.titleTextStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Icon(
                                      Icons.access_time,
                                      color: AppTheme.grey.withOpacity(0.5),
                                      size: 16,
                                    )),
                                Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Text(
                                      _getDateTime(article.createdAt),
                                      textAlign: TextAlign.left,
                                      style: ArticleCardTheme.dateTextStyle,
                                    ))
                              ])
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Container(
                                  child: Text( 
                                    article.content,
                                    style: ArticleCardTheme.contentTextStyle,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 6,
                                  ),
                                  
                                ))),
                        _getPrimaryPhoto(article.photos)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 4, right: 4, top: 4, bottom: 4),
                              child: Icon(
                                Icons.favorite_border,
                                color: AppTheme.nearlyDarkBlue,
                                size: 16,
                              )),
                          Row(children: <Widget>[
                            _getRate(article.author.rated),
                            ArticleCardTheme.footerStarIcon,
                          ]),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 4, right: 4, top: 4, bottom: 4),
                              child:
                                  _getPrice(article.price, article.category)),
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

Widget _getRate(double rating) {
  if (rating != null) {
    return Text(
      '$rating',
      style: ArticleCardTheme.footerTextStyle,
    );
  } else {
    return Text('0', style: ArticleCardTheme.footerTextStyle);
  }
}

Widget _getPrice(int price, Category category) {
  if (price != null) {
    if (category.name == 'Service') {
      return Text(
          NumberFormat.currency(locale: "vi", symbol: 'đ', decimalDigits: 0)
                  .format(price) +
              '/1h',
          textAlign: TextAlign.left,
          maxLines: 1,
          style: ArticleCardTheme.footerTextStyle);
    } else {
      return Text(
          NumberFormat.currency(locale: "vi", symbol: 'đ', decimalDigits: 0)
              .format(price),
          textAlign: TextAlign.left,
          maxLines: 1,
          style: ArticleCardTheme.footerTextStyle);
    }
  } else {
    return Text('here');
  }
}

Widget _getPrimaryPhoto(List<Photo> photos) {
  if (photos.isNotEmpty) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: AppTheme.grey.withOpacity(0.6),
                    offset: const Offset(2.0, 4.0),
                    blurRadius: 8),
              ],
            ),
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                  SERVER_URL + photos.elementAt(0).formats.small.url),
              backgroundColor: Colors.transparent,
            )));
  } else {
    return SizedBox.shrink();
  }
}

String _getDateTime(DateTime createAt) {
  return createAt.day.toString() +
      '/' +
      createAt.month.toString() +
      ' - ' +
      (createAt.hour + 7).toString() +
      ':' +
      createAt.minute.toString();
}
