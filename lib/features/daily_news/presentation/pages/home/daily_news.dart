import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_android/features/daily_news/presentation/bloc/remote/remote_article_bloc.dart';
import 'package:test_android/features/daily_news/presentation/bloc/remote/remote_article_state.dart';
import 'package:test_android/features/daily_news/presentation/pages/news_detail/articledetail.dart';
import 'package:test_android/features/daily_news/presentation/widgets/article_tile.dart';

import '../../../Domain/entities/article.dart';
import '../saved_articles/saved_articles.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Daily News',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        GestureDetector(
          onTap: () => _onShowSavedArticlesViewTapped(context),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Icon(Icons.bookmark, color: Colors.black),
          ),
        )
      ],
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticleBloc, RemoteArticlesState>(
      builder: (_, state) {
        if (state is RemoteArticleLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is RemoteArticlesError) {
          return const Center(child: Icon(Icons.refresh));
        }
        if (state is RemoteArticlesDone) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ArticleWidget(
                article: state.articles![index],
                onArticlePressed: (article) =>
                    _onArticlePressed(context, article),
              );
            },
            itemCount: state.articles!.length,
          );
        }
        return const SizedBox();
      },
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    // Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ArticleDetails(
                  article: article,
                )));
  }

  void _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SavedArticles()));
    // Navigator.pushNamed(context, '/SavedArticles');
  }
}
