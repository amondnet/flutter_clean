class MovieDetails {
  final int id;
  final String title;
  final String poster;
  final String summary;
  final String cast;
  final String director;
  final int year;
  final String trailer;



  static MovieDetails empty = MovieDetails(0, '', '', '', '', '', 0, '');

  MovieDetails(this.id, this.title, this.poster, this.summary, this.cast, this.director, this.year, this.trailer);

}
