import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:test_android/features/daily_news/Domain/entities/article.dart';
import 'package:test_android/features/daily_news/presentation/bloc/local/local_article_bloc.dart';

import '../../../../../injection_container.dart';
import '../../bloc/local/local_article_event.dart';

class ArticleDetails extends HookWidget {
  final ArticleEntity? article;

  const ArticleDetails({Key? key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalArticleBloc>(),
      child: Scaffold(
        appBar: appBar(),
        extendBodyBehindAppBar: true,
        body: _buildBody(context),
        floatingActionButton: _floatingActionButton(),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: 10,
                width: 50,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: const Icon(Ionicons.chevron_back, color: Colors.black)),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [image(context), _TextArea(context)],
      ),
    );
  }

  Widget image(BuildContext context) {
    double h = (MediaQuery.of(context).size.height / 2);
    return Container(
      height: h,
      width: MediaQuery.of(context).size.width,
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: Stack(children: [
          SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                article!.urlToImage!,
                fit: BoxFit.fitHeight,
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 7,
              ),
              Container(
                height: h / 3,
                child: ClipRRect(
                  // make sure we apply clip it properly
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      alignment: Alignment.center,
                      color: Colors.grey.withOpacity(0.4),
                      child: Text(
                        '${article!.title}',
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Butler',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }

  Widget _TextArea(BuildContext context) {
    double w = MediaQuery.of(context).size.width / 2;
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 2.1,
        ),
        Container(
          height: MediaQuery.of(context).size.height / 2.2,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 15,
                  bottom: 8,
                  right: w,
                ),
                child: Text(
                  '${article!.author}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Butler',
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  '${article!.description ?? ''}\n\n${article!.content ?? ''}',
                  maxLines: 20,
                  style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Butler',
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _floatingActionButton() {
    return Builder(
      builder: (context) => FloatingActionButton(
        onPressed: () => _onFloatingActionButtonPressed(context),
        child: const Icon(Ionicons.bookmark, color: Colors.white),
      ),
    );
  }

  void _onFloatingActionButtonPressed(BuildContext context) {
    BlocProvider.of<LocalArticleBloc>(context).add(SaveArticle(article!));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: Text('Article saved successfully.'),
      ),
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }
}
