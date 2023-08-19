import 'package:test_android/Core/Resources/data_State.dart';
import 'package:test_android/Core/use_case/usecase.dart';
import 'package:test_android/features/daily_news/Domain/entities/article.dart';
import 'package:test_android/features/daily_news/Domain/repository/article_repository.dart';

class SavetArticleUseCase implements UseCase<void, ArticleEntity> {
  final ArticleRepository _articleRepository;

  SavetArticleUseCase(this._articleRepository);

  @override
  Future<void> call({ArticleEntity? params}) {
    return _articleRepository.saveArticle(params!);
  }
}
