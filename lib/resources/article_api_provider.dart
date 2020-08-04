import 'package:http/http.dart' show Client;
import 'package:Toot/models/article.dart';
import 'package:Toot/models/app_const.dart';

class ArticleApiProvider {
  Client client = Client();

  Future<List<Article>> fetchArticles() async {
    final response =
        await client.get("$SERVER_URL/articles?_sort=updatedAt:desc");

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
}
