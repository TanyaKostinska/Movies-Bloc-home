import 'package:flutter/material.dart';
import 'package:movies/const.dart';
import 'package:movies/model/movie_model.dart';
import 'package:movies/movie_list/view/widget/reiteng_widget.dart';
import 'package:movies/style/app_colors.dart';

class MovieItem extends StatelessWidget {
  final MovieModel movie;

  const MovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ShaderMask(
          blendMode: BlendMode.dstOut,
          shaderCallback: (Rect rect) {
            return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0,
                  1
                ],
                colors: [
                  Colors.transparent,
                  AppColors.background,
                ]).createShader(rect);
          },
          child: GestureDetector(
            // onTap: () =>
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (BuildContext context) => MovieDetailPage(
            //           movieId: movie.id,
            //         ),
            //       ),
            //     ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
              ),
              child: Image.network(
                posterPath + movie.posterPath,
                fit: BoxFit.cover,
                height: 218,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 65,
          left: 5,
          child: RatingCircleWidget(
            rating: movie.voteAverage,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                maxLines: 2,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                movie.releaseDate,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
