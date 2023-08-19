import 'package:test_android/Core/Resources/data_State.dart';
import 'package:test_android/Core/use_case/usecase.dart';
import 'package:test_android/features/daily_news/Domain/entities/article.dart';
import 'package:test_android/features/daily_news/Domain/repository/article_repository.dart';

class GetArticleUseCase
    implements UseCase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepository _articleRepository;

  GetArticleUseCase(this._articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return _articleRepository.getNewsArticles();
  }
}
