part of 'movie_detail_bloc.dart';

enum StatusLoading { initial, loading, success, error }

class MovieDetailState extends Equatable {
  final MovieModel? movieDetail;
  final List<TrailerModel>? trailers;
  final List<ActorModel>? actors;
  final StatusLoading statusLoading;

  const MovieDetailState({
    this.movieDetail,
    this.trailers,
    this.actors,
    this.statusLoading = StatusLoading.initial,
  });

  MovieDetailState copyWith({
    MovieModel? movieDetail,
    List<TrailerModel>? trailers,
    List<ActorModel>? actors,
    StatusLoading? statusLoading,
  }) {
    return MovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      trailers: trailers ?? this.trailers,
      actors: actors ?? this.actors,
      statusLoading: statusLoading ?? this.statusLoading,
    );
  }

  @override
  List<Object?> get props => [movieDetail, trailers, statusLoading];

  @override
  String toString() {
    return '';
  }
}
