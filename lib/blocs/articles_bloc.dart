import 'package:Toot/models/article.dart';
import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ArticlesBloc {
  final _repository = Repository();
  final _articlesFetcher = PublishSubject<List<Article>>();

  Observable<List<Article>> get allArticles => _articlesFetcher.stream;

  fetchAllArticles() async {
    List<Article> itemModel = await _repository.fetchArticleList();
    _articlesFetcher.sink.add(itemModel);
  }
 
  dispose() {
    _articlesFetcher.close();
  }
}

final bloc = ArticlesBloc();