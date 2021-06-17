import 'package:async/async.dart';
import 'package:clean/core/interactor/use_case.dart';
import 'package:clean/features/movies/movie_details_view.dart';
import 'package:equatable/equatable.dart';

import 'movie_details.dart';
import 'movie_repository.dart';

class GetMovieDetails extends UseCase<MovieDetails, GetMovieDetailsParams> {
  final MoviesRepository _moviesRepository;

  GetMovieDetails(this._moviesRepository);

  @override
  Future<Result<MovieDetails>> call(GetMovieDetailsParams params) {
    return _moviesRepository.movieDetails(params.id);
  }
}

class GetMovieDetailsParams extends Equatable {
  final int id;

  GetMovieDetailsParams(this.id);

  @override
  List<Object?> get props => [id];
}
