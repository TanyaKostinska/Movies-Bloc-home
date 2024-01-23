import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movie_list/bloc/movie_list_bloc.dart';
import 'package:movies/movie_list/view/movie-list.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => MovieListBloc()..add(MovieFetched()),
        child: const MovieList(),
      ),
    );
  }
}
