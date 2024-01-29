
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:movies/movie_list/view/movie_list_page.dart';
import 'package:movies/observer.dart';
import 'package:movies/style/theme.dart';


void main() async {
  await initializeDateFormatting('uk_UA');


  Bloc.observer = MovieObserver();
  runApp(const App());
}


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MovieListPage(),
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
    );
  }
}
