import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:test_android/Core/constanst/constanst.dart';
import 'package:test_android/features/daily_news/data/models/article.dart';
part 'news_api_service.g.dart';

@RestApi(baseUrl: newsAPIBaseURL)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET('/top-headlines')
  Future<HttpResponse<List<ArticleModel>>> getNewsArticles({
    @Query("apiKey") String? apiKey,
    @Query("country") String? country,
    @Query("category") String? category,
  });
}

class HttpResponse<T> {
  final T data;
  final Response response;

  HttpResponse(this.data, this.response);

  HttpResponse.fromJson(Map<String, dynamic> map, this.data, this.response);
}
