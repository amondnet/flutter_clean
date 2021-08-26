import '../domain/movie.dart';

/// It is not DomainEntity!!
class MovieEntity {
  final int id;
  final String poster;

  MovieEntity(this.id, this.poster);

  Movie toMovie() => movie;

  late final movie = Movie(id, poster);
}
