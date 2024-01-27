import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;

import '../../model/movie_model.dart';
import '../../model/trailer_model.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {

  MovieDetailBloc() : super(const MovieDetailState()) {
    on<GetMovieById>(_onMovieFetched);


  Future<void> _onMovieFetched(
      GetMovieById event, Emitter<MovieDetailState> emit) async {
    emit(state.copyWith(statusLoading: StatusLoading.loading));
  }
    try {
      final movieDetail = await _fetchMovieDetail(event.movieId);
      final trailers = await _fetchTrailers(event.movieId);
      emit(state.copyWith(
  movieDetail: movieDetail,
  trailers: trailers,
  statusLoading: StatusLoading.success,
  ));
    } catch (_) {
    emit(state.copyWith(statusLoading: StatusLoading.error));
  }


  Future<MovieModel> _getMovieById(int movieId) async {
    print('========================= _getMovieById');
    final response = await http
        .get(Uri.https('api.themoviedb.org', '/3/movie/$movieId'), headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhOGMxYTYwMjFlMjdkZjNlZmRkZGRjODU1NTRlMjFiNyIsInN1YiI6IjY0YmY4MmZhMDE3NTdmMDBlMjE2YTYxNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.mSVgZBD29DTsQVYmKFcbxzeTD37tDCikD19_wJQI20A'
    });
    if (response.statusCode == 200) {
      print('========================= response.statusCode == 200');

      final data = json.decode(response.body);
      print('========================= data $data');
      return MovieModel.fromJson(data);
    } else {
      print('========================= error');
      throw Exception('Error fetch movies');
    }
  }
}
