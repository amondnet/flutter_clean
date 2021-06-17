import 'package:clean/features/movies/movie.dart';
import 'package:http/http.dart';

import 'movie_details_entity.dart';
import 'movie_entity.dart';

class MoviesService {
  final _client = Client();
  Future<List<MovieEntity>> movies() async {
    return [];
  }

  Future<MovieDetailsEntity> movieDetails() {}
}
