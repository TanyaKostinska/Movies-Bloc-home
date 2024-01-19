import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/model/movie_model.dart';
import 'package:http/http.dart' as http;

part 'movie_list_event.dart';

part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  MovieListBloc() : super(const MovieListState()) {
    on<MovieFetched>(_onMovieFetched);
  }


  Future<void> _onMovieFetched(MovieFetched event, Emitter<MovieListState> emit) async {
    if (state.hasReachedMax) return;

    try {
      if (state.status == MovieStatus.initial) {
        final movies = await _fetchMovies();
        emit(state.copyWith(
          status: MovieStatus.success,
          movies: movies,
          hasReachedMax: false,
        ));
        return;
      }
      if (state.status == MovieStatus.success) {
        final nextPage = state.movies.length ~/ 20 + 1;
        final movies = await _fetchMovies(nextPage);
        emit(state.copyWith(
          status: MovieStatus.success,
          movies: List.of(state.movies)
            ..addAll(movies),
          hasReachedMax: false,
        ));

      }
    } catch (_) {
      emit(state.copyWith(status: MovieStatus.failure));
    }
  }


  Future<List<MovieModel>> _fetchMovies([int page = 1]) async {
    print('=================== Виклик методу _fetchMovies');
    final response = await http.get(
        Uri.https('api.themoviedb.org', '/3/movie/top_rated', {
          'page': '$page',
        }),
        headers: {
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhOGMxYTYwMjFlMjdkZjNlZmRkZGRjODU1NTRlMjFiNyIsInN1YiI6IjY0YmY4MmZhMDE3NTdmMDBlMjE2YTYxNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.mSVgZBD29DTsQVYmKFcbxzeTD37tDCikD19_wJQI20A'
        }
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<MovieModel>.from(data['results'].map((item) => MovieModel.fromJson(item),),);
    } else {
      throw Exception('Error fetch movies');
    }
  }
}