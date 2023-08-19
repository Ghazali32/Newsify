import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_android/features/daily_news/Domain/usecase/get_article.dart';
import 'package:test_android/features/daily_news/presentation/bloc/remote/remote_article_event.dart';
import 'package:test_android/features/daily_news/presentation/bloc/remote/remote_article_state.dart';

import '../../../../../Core/Resources/data_State.dart';

class RemoteArticleBloc extends Bloc<RemoteArticlesEvent, RemoteArticlesState> {
  final GetArticleUseCase _getArticlesUseCase;

  RemoteArticleBloc(this._getArticlesUseCase)
      : super(const RemoteArticleLoading()) {
    on<GetArticles>(onGetArticles);
  }

  void onGetArticles(GetArticles event, Emitter <RemoteArticlesState> emit) async {
    final dataState = await _getArticlesUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(
        RemoteArticlesDone(dataState.data!)
      );
    }
    
    if (dataState is DataFailed) {
      emit(
        RemoteArticlesError(dataState.error!)
      );
    }
  }
}
