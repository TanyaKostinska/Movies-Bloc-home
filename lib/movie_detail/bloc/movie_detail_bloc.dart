import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;

import '../../model/actor_model.dart';
import '../../model/movie_model.dart';
import '../../model/trailer_model.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc() : super(const MovieDetailState()) {
    on<GetMovieById>(_onMovieFetched);
  }

  Future<void> _onMovieFetched(
      GetMovieById event, Emitter<MovieDetailState> emit) async {
    emit(state.copyWith(statusLoading: StatusLoading.loading));
    try {
      final movieDetail = await _fetchMovieDetail(event.movieId);
      final trailers = await _fetchTrailers(event.movieId);
      final actors = await _fetchActors(event.movieId);
      emit(
        state.copyWith(
          movieDetail: movieDetail,
          trailers: trailers,
          actors: actors,
          statusLoading: StatusLoading.success,
        ),
      );
    } catch (_) {
      emit(state.copyWith(statusLoading: StatusLoading.error));
    }
  }

  Future<MovieModel> _fetchMovieDetail(int movieId) async {
    final response = await http
        .get(Uri.https('api.themoviedb.org', '/3/movie/$movieId'), headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhOGMxYTYwMjFlMjdkZjNlZmRkZGRjODU1NTRlMjFiNyIsInN1YiI6IjY0YmY4MmZhMDE3NTdmMDBlMjE2YTYxNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.mSVgZBD29DTsQVYmKFcbxzeTD37tDCikD19_wJQI20A'
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      // final data = json.decode(response.body);
      return MovieModel.fromJson(data);
    } else {
      throw Exception('Error movies');
    }
  }

  Future<List<TrailerModel>> _fetchTrailers(int moviesId) async {
    final response = await http.get(
        Uri.https('api.themoviedb.org', '/3/movie/$moviesId/videos'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhOGMxYTYwMjFlMjdkZjNlZmRkZGRjODU1NTRlMjFiNyIsInN1YiI6IjY0YmY4MmZhMDE3NTdmMDBlMjE2YTYxNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.mSVgZBD29DTsQVYmKFcbxzeTD37tDCikD19_wJQI20A'
        });
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      List<TrailerModel> trailers = [];
      for (var item in data['results']) {
        trailers.add(TrailerModel.fromJson(item));
      }
      return trailers;
    } else {
      throw Exception('Error trailers');
    }
  }

  Future<List<ActorModel>> _fetchActors(int moviesId) async {
    final response = await http.get(
        Uri.https('api.themoviedb.org', '/3/movie/$moviesId/credits'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhOGMxYTYwMjFlMjdkZjNlZmRkZGRjODU1NTRlMjFiNyIsInN1YiI6IjY0YmY4MmZhMDE3NTdmMDBlMjE2YTYxNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.mSVgZBD29DTsQVYmKFcbxzeTD37tDCikD19_wJQI20A'
        });
    if (response.statusCode == 200) {
      //final data = jsonDecode(response.body);
     Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));

      return List<ActorModel>.from(
        data['cast'].map(
          (item) => ActorModel.fromJson(item),
        ),
      );
    } else {
      throw Exception('Error actors');
    }
  }
}
