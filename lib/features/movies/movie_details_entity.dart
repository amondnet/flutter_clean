import 'package:clean/features/movies/movie_details.dart';

class MovieDetailsEntity {
  final int _id;
  final String _title;
  final String _poster;
  final String _summary;
  final String _cast;
  final String _director;
  final int _year;
  final String _trailer;

  MovieDetailsEntity(this._id, this._title, this._poster, this._summary,
      this._cast, this._director, this._year, this._trailer);

  MovieDetails toMovieDetails() => MovieDetails(
      _id, _title, _poster, _summary, _cast, _director, _year, _trailer);

  static MovieDetailsEntity empty =
      MovieDetailsEntity(0, '', '', '', '', '', 0, '');
}
