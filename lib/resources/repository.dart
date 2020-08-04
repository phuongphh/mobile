import 'package:Toot/models/article.dart';
import 'article_api_provider.dart';

class Repository {
  final articleApiProvider = ArticleApiProvider();

  Future<List<Article>> fetchArticleList() =>
      articleApiProvider.fetchArticles();
}
