import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movie_list/bloc/movie_list_bloc.dart';
import 'package:movies/movie_list/view/widget/item_movie.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieListBloc, MovieListState>(
        builder: (context, state) {
      if (state.status == MovieStatus.failure) {
        return const Center(child: Text('Sorry! Error'));
      }
      if (state.status == MovieStatus.success) {
        if (state.movies.isEmpty) {
          return const Center(child: Text('No movies'));
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            controller:  _scrollController,
              itemCount: state.hasReachedMax ? state.movies.length :  state.movies.length + 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 263,
              ),
              itemBuilder: (context, index) {
                return index >= state.movies.length
                    ? const CircularProgressIndicator()
                    : MovieItem(
                        movie: state.movies[index],
                      );
              }),
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<MovieListBloc>().add(MovieFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;

    final maxScroll = _scrollController.position.maxScrollExtent;

    final currentScroll = _scrollController.offset;

    return currentScroll >= (maxScroll * 0.9);
  }
}
