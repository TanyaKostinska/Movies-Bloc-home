import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movie_list/view/movie_list_page.dart';
import 'package:movies/observer.dart';
import 'package:movies/style/theme.dart';

void main() {
  Bloc.observer = MovieObserver();
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MovieListPage(),
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
    );
  }
}
