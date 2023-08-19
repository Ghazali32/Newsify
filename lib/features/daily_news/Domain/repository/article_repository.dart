import 'package:test_android/Core/Resources/data_State.dart';
import '../entities/article.dart';

abstract class ArticleRepository {
  // Api Methods
  Future<DataState<List<ArticleEntity>>> getNewsArticles();

  // Database Methods:
  Future<List<ArticleEntity>> getSavedArticles();

  Future<void> saveArticle(ArticleEntity article);

  Future<void> removeArticle(ArticleEntity article);
}
