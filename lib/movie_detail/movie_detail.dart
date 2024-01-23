import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movies/movie_detail/trailer_model.dart';

class MovieDetail extends StatelessWidget {
  const MovieDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
        if (state is MovieDetailLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is MovieDetailSuccessState) {
          return TrailerModel(
            movie: state.movie,
          );
        }
        if (state is MovieDetailErrorState) {
          return const Center(child: Text('Error'));
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
