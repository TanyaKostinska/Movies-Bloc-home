part of 'movie_list_bloc.dart';

enum MovieStatus { initial, success, failure }

final class MovieListState extends Equatable {
  final MovieStatus status;
  final List<MovieModel> movies;
  final bool hasReachedMax;

  const MovieListState({
    this.status = MovieStatus.initial,
    this.movies = const <MovieModel>[],
    this.hasReachedMax = false,
  });

  MovieListState copyWith({
    MovieStatus? status,
    List<MovieModel>? movies,
    bool? hasReachedMax,
  }) {
    return MovieListState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [status, movies, hasReachedMax];
}
