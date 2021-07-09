import 'package:clean/features/movies/movie.dart';
import 'package:http/http.dart';

import 'movie_details_entity.dart';
import 'movie_entity.dart';

class MoviesService {
  final _client = Client();

  Future<List<MovieEntity>> movies() async {
    return [
      MovieEntity(1, 'test'),
      MovieEntity(2, 'test'),
    ];
  }

  Future<MovieDetailsEntity> movieDetails() async {
    return MovieDetailsEntity(
        1, 'title', 'poster', 'summary', 'cast', 'director', 2020, 'trailer');
  }
}
