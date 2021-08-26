import 'package:clean/core/network_response.dart';
import 'package:http/http.dart';
import 'package:mobx/mobx.dart';

import 'movie_details_entity.dart';
import 'data/movie_entity.dart';

class MoviesService {
  final _client = Client();

  Future<List<MovieEntity>> movies() async {
    return [
      MovieEntity(1, 'test'),
      MovieEntity(2, 'test'),
    ];
  }

  Observable<ApiResponse<List<MovieEntity>>> moviesObservable() {
    return Observable(ApiSuccessResponse([
      MovieEntity(1, 'test'),
      MovieEntity(2, 'test'),
    ]));
  }

  Stream<ApiResponse<List<MovieEntity>>> moviesStream() {
    return Stream.value(ApiSuccessResponse([
      MovieEntity(1, 'test'),
      MovieEntity(2, 'test'),
    ]));
  }

  Future<MovieDetailsEntity> movieDetails() async {
    return MovieDetailsEntity(
        1, 'title', 'poster', 'summary', 'cast', 'director', 2020, 'trailer');
  }
}
