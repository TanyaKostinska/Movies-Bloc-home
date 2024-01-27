import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movie_detail/bloc/movie_detail_bloc.dart';

class MovieDetailView extends StatelessWidget {
  const MovieDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
      if (state.statusLoading == StatusLoading.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.statusLoading == StatusLoading.success) {
        return const CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 400,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background:
                    BackgroundImageWithGradient(movie: state.movieDetail!),
              ),
            ),
          ],
        );
      }
    });
  }
}

