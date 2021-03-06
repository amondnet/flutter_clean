import 'dart:async';

import 'package:async/async.dart';
import 'package:clean/core/exception/failure.dart';
import 'package:clean/core/network_handler.dart';
import 'package:clean/features/movies/movie_details_entity.dart';

import 'movie.dart';
import 'movie_details.dart';
import 'movie_entity.dart';
import 'movies_service.dart';
import '../../core/result.dart';

abstract class MoviesRepository {
  Future<Result<List<Movie>>> movies();

  Future<Result<MovieDetails>> movieDetails(int movieId);
}

class NetworkMoviesRepository implements MoviesRepository {
  final NetworkHandler _networkHandler;
  final MoviesService _service;

  NetworkMoviesRepository(this._networkHandler, this._service);

  @override
  Future<Result<MovieDetails>> movieDetails(int movieId) {
    return _networkHandler.isNetworkAvailable
        ? _request(
            _service.movieDetails(),
            (MovieDetailsEntity movie) => movie.toMovieDetails(),
            MovieDetailsEntity.empty)
        : Future.value(Result.error(NetworkConnection()));
  }

  @override
  Future<Result<List<Movie>>> movies() {
    return _networkHandler.isNetworkAvailable
        ? _request<List<MovieEntity>, List<Movie>>(
            _service.movies(),
            (List<MovieEntity> movies) =>
                movies.map((movie) => movie.toMovie()).toList(),
            [])
        : Future.value(Result.error(NetworkConnection()));
  }

  Future<Result<R>> _request<T, R>(
      Future<T> call, R Function(T) transform, T defaultValue) {
    return ResultX.fromNetwork(call.then((v) => transform(v)));
  }
}
