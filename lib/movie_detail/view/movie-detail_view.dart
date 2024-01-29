import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/const.dart';
import 'package:movies/model/movie_model.dart';
import 'package:movies/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movies/movie_detail/trailer.dart';

import '../movie_info.dart';

class MovieDetailView extends StatelessWidget {
  const MovieDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
      if (state.statusLoading == StatusLoading.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.statusLoading == StatusLoading.success) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 400,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background:
                    BackgraundImageWithGradient(movie: state.movieDetail!),
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.favorite_border),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: MovieInfo(movie: state.movieDetail!),
            ),
            SliverToBoxAdapter(
              child: Trailer(
                trailers: state.trailers!,
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                state.actors!.length.toString(),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 100,
                child: ListView.builder(
                  itemCount: state.actors?.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          state.actors == null? SizedBox.shrink() : Container(
                            width: 70,
                            height: 70,
                            decoration:  BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                image: NetworkImage(posterPath + state.actors![index].foto ?? ''),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(state.actors![index].name),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      } else {
        return const Center(
          child: Text('Error detail movie'),
        );
      }
    });
  }
}

class BackgraundImageWithGradient extends StatelessWidget {
  final MovieModel movie;

  const BackgraundImageWithGradient({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          posterPath + movie.posterPath,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Color(0xFF151618),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.2, 0.7],
            ),
          ),
        ),
      ],
    );
  }
}
