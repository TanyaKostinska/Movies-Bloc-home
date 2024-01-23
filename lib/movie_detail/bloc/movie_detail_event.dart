part of 'movie_detail_bloc.dart';

sealed class MovieDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetMovieById extends MovieDetailEvent {
  final int movieId;

  GetMovieById(this.movieId);
}
