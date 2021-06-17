import 'package:clean/features/movies/movie_details.dart';
import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String poster;

  Movie(this.id, this.poster);

  @override
  List<Object> get props => [id, poster];

}
