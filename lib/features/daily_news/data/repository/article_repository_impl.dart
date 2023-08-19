import 'dart:io';

import 'package:dio/dio.dart';
import 'package:test_android/Core/Resources/data_State.dart';
import 'package:test_android/Core/constanst/constanst.dart';
import 'package:test_android/features/daily_news/Domain/entities/article.dart';
import 'package:test_android/features/daily_news/Domain/repository/article_repository.dart';
import 'package:test_android/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:test_android/features/daily_news/data/data_sources/remote/news_api_service.dart';

import '../models/article.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;
  ArticleRepositoryImpl(this._newsApiService, this._appDatabase);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final httpResponce = await _newsApiService.getNewsArticles(
        apiKey: newsApiKey,
        category: category,
        country: country,
      );

      if (httpResponce.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponce.data);
      } else {
        return DataFailed(DioException(
            error: httpResponce.response.statusMessage,
            response: httpResponce.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponce.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<List<ArticleModel>> getSavedArticles() async {
    return _appDatabase.articleDao.getArticles();
  }

  @override
  Future<void> removeArticle(ArticleEntity article) {
    return _appDatabase.articleDao
        .deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
    return _appDatabase.articleDao
        .insertArticle(ArticleModel.fromEntity(article));
  }
}
