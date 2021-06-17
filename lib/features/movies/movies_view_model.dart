import 'package:clean/core/base_view_model.dart';
import 'package:clean/features/movies/get_movies.dart';
import 'package:mobx/mobx.dart';

import 'movie.dart';
import 'movie_view.dart';
import '../../core/result.dart';

part 'movies_view_model.g.dart';

class MoviesViewModel = MoviesViewModelBase with _$MoviesViewModel;

abstract class MoviesViewModelBase extends BaseViewModel with Store {
  @observable
  ObservableFuture<List<MovieView>>? movies;

  final GetMovies getMovies;

  MoviesViewModelBase(this.getMovies);

  @action
  Future<List<MovieView>> loadMovies() {
    return movies = ObservableFuture(getMovies.call().then((value) =>
        value.isValue
            ? handleMovieList(value.asValue!.value)
            : throw handleFailure(value.failure)));
  }

  List<MovieView> handleMovieList(List<Movie> movies) {
    return movies.map((it) => MovieView(it.id, it.poster)).toList();
  }
}
