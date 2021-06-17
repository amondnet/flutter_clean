import 'package:clean/core/base_view_model.dart';
import 'package:clean/features/movies/get_movie_details.dart';
import 'package:clean/features/movies/movie_details_view.dart';
import 'package:mobx/mobx.dart';

import 'movie_details.dart';

part 'movie_details_view_model.g.dart';

class MovieDetailsViewModel = MovieDetailsViewModelBase
    with _$MovieDetailsViewModel;

abstract class MovieDetailsViewModelBase extends BaseViewModel with Store {
  final GetMovieDetails _getMovieDetails;
  @observable
  ObservableFuture<MovieDetailsView>? movieDetails;

  MovieDetailsViewModelBase(this._getMovieDetails);

  @action
  Future<MovieDetailsView> loadMovieDetails(int movieId) {
    return _getMovieDetails(GetMovieDetailsParams(movieId)).then((value) =>
        value.isValue
            ? handleMovieDetails(value.asValue!.value)
            : Future.error('error'));
  }

  handleMovieDetails(MovieDetails movie) {
    movieDetails = ObservableFuture.value(MovieDetailsView(
        movie.id,
        movie.title,
        movie.poster,
        movie.summary,
        movie.cast,
        movie.director,
        movie.year,
        movie.trailer));
  }
}
