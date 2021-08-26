import 'package:async/async.dart';
import 'package:clean/core/base_view_model.dart';
import 'package:clean/core/resource.dart';
import 'package:clean/features/movies/get_movies.dart';
import 'package:mobx/mobx.dart';

import '../../core/result.dart';
import 'domain/movie.dart';
import 'movie_view.dart';

part 'movies_view_model.g.dart';

class MoviesViewModel = MoviesViewModelBase with _$MoviesViewModel;

abstract class MoviesViewModelBase extends BaseViewModel with Store {
  @observable
  List<MovieView> movies = ObservableList();

  final GetMoviesStream getMovies;

  MoviesViewModelBase(this.getMovies);

  @action
  void loadMovies() {
    getMovies().listen((resource) {
      resource.when(
          (data) => movies =
              ObservableList.of(data.map((e) => MovieView(e.id, e.poster))),
          error: (msg, data) {},
          loading: (data) {});
    });
  }
}
