part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();
  @override
  List<Object?> get props => [];
}

class MovieDetailInitialState extends MovieDetailState {}

class MovieDetailErrorState extends MovieDetailState {}

class MovieDetailSuccessState extends MovieDetailState {
  final MovieModel movie;
  const MovieDetailSuccessState({required this.movie});
}

class MovieDetailLoadingState extends MovieDetailState {}
