import 'package:flutter/material.dart';
import 'package:movies/model/movie_model.dart';
import '../const.dart';

class TrailerModel extends StatelessWidget {
  final MovieModel movie;

  const TrailerModel({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ..._buildBackground(context, movie),
          Positioned(
            bottom: 150,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> _buildBackground(context, movie) {
  return [
    Container(
      height: double.infinity,
      color: const Color(0xFF151618),
    ),
    Image.network(
      posterPath + movie.posterPath,
      fit: BoxFit.cover,
      height: double.infinity,
      width: MediaQuery.of(context).size.height * 0.5,
    ),
    const Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
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
    ),
    const SizedBox(height: 10),
    Text(movie.title,
      maxLines: 8,
      style: Theme.of(context)
          .textTheme
          .bodySmall!
          .copyWith(height: 2, color: Colors.white),
    ),
  ];
}
