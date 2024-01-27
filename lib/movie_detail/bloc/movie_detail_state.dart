part of 'movie_detail_bloc.dart';

enum StatusLoading { initial, loading, success, error }

class MovieDetailState extends Equatable {
  final MovieModel? movieDetail;
  final List<TrailerModel> trailers;
  final StatusLoading statusLoading;

  const MovieDetailState({
    required this.movieDetail,
    required this.trailers,
    required this.statusLoading,
  });

  MovieDetailState copyWith({
    MovieModel? movieDetail,
    List<TrailerModel>? trailers,
    StatusLoading? statusLoading,
  }) {
    return MovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      trailers: trailers ?? this.trailers,
      statusLoading: statusLoading ?? this.statusLoading,
    );
  }

  @override
  List<Object?> get props => [movieDetail, trailers, statusLoading];

  @override
  String toString() {
    return 'MovieDetailState $movieDetail, trailers:${trailers.length},statusLoading:$statusLoading';
  }
}
