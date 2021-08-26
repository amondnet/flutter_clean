import 'package:async/async.dart';
import 'package:clean/core/interactor/use_case.dart';
import 'package:clean/core/resource.dart';

import 'domain/movie.dart';
import 'movie_repository.dart';

class GetMovies extends UseCase<List<Movie>, None> {
  final MoviesRepository _moviesRepository;

  GetMovies(this._moviesRepository);

  @override
  Future<Result<List<Movie>>> call([None? params]) {
    return _moviesRepository.movies();
  }
}

class GetMoviesStream extends StreamUseCase<Resource<List<Movie>>, None> {
  final MoviesRepository _moviesRepository;

  GetMoviesStream(this._moviesRepository);

  @override
  Stream<Resource<List<Movie>>> call([None? params]) {
    return _moviesRepository.moviesStream();
  }
}
