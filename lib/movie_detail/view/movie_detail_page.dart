import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movie_detail_bloc.dart';
import 'movie-detail_view.dart';

class MovieDetail extends StatelessWidget {
  final int movieId;
  const MovieDetail({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) =>
            MovieDetailBloc()..add(GetMovieById(movieId)),
        child: const MovieDetailView(),
      ),
    );
  }
}
