import 'genre_model.dart';

class MovieModel {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;
  final List<GenreModel> genreList;
  final int? runtime;

  MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.genreList,
    required this.runtime,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        id: json['id'],
        title: json['title'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        releaseDate: json['release_date'],
        voteAverage: json['vote_average'].toDouble(),
        genreList: (json['genres'] as List<dynamic>?)
                ?.map((element) =>
                    GenreModel.fromJson(element as Map<String, dynamic>))
                .toList() ??
            [],
        runtime: json['runtime'],
      );
}
