import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:test_android/features/daily_news/Domain/repository/article_repository.dart';
import 'package:test_android/features/daily_news/Domain/usecase/get_article.dart';
import 'package:test_android/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:test_android/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:test_android/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:test_android/features/daily_news/presentation/bloc/local/local_article_bloc.dart';
import 'package:test_android/features/daily_news/presentation/bloc/remote/remote_article_bloc.dart';

import 'features/daily_news/Domain/usecase/get_saved_article.dart';
import 'features/daily_news/Domain/usecase/remove_article.dart';
import 'features/daily_news/Domain/usecase/save_article.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  //Dio
  sl.registerSingleton<Dio>(Dio());

  //Dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));
  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl(), sl()));
  //Use Cases

  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase((sl())));

  sl.registerSingleton<GetSavedtArticleUseCase>(GetSavedtArticleUseCase(sl()));

  sl.registerSingleton<SavetArticleUseCase>(SavetArticleUseCase(sl()));

  sl.registerSingleton<RemovetArticleUseCase>(RemovetArticleUseCase(sl()));

  //bloc
  sl.registerFactory<RemoteArticleBloc>(() => RemoteArticleBloc(sl()));

  sl.registerFactory<LocalArticleBloc>(
      () => LocalArticleBloc(sl(), sl(), sl()));
}
