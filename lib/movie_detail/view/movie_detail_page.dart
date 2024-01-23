import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movie_detail/movie_detail.dart';
import 'package:movies/movie_list/view/movie-list.dart';

import '../bloc/movie_detail_bloc.dart';

class MovieDetailPage extends StatelessWidget {
  final int movieId;
  const MovieDetailPage({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          MovieDetailBloc()..add(GetMovieById(movieId)),
      child: const MovieDetail(),
    );
  }
}
