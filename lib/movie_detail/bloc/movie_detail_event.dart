part of 'movie_detail_bloc.dart';

sealed class MovieDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetMovieById extends MovieDetailEvent {
  final int movieId;

  GetMovieById(this.movieId);

  @override
  List<Object> get props => [movieId];
}
