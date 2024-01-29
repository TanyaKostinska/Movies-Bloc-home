import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies/model/movie_model.dart';

class MovieInfo extends StatelessWidget {
  final MovieModel movie;
  const MovieInfo({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF151618),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: Text(movie.title,
                    maxLines: 8, style: Theme.of(context).textTheme.bodyMedium),
              ),
              const SizedBox(height: 15),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFABABAB),
                        Color(0xFF6D75E8),
                      ],
                      stops: [0.3, 0.8],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Center(
                    child: Text(formatFullDate(movie.releaseDate)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFF4F4F4),
                  ),
                ),
                child: const Text('16+'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('*'),
              ),
              SizedBox(
                height: 20,
                child: ListView.separated(
                    itemCount: movie.genreList.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) =>
                        const VerticalDivider(
                          color: Color(0xFFF4F4F4),
                          width: 20,
                        ),
                    itemBuilder: (BuildContext context, int index) {
                      final genre = movie.genreList[index];
                      return Row(
                        children: [
                          Text(
                            genre.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            movie.runtime == null ? '' : formatRunTime(movie.runtime!),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 8),
            child: Text(
              'Огляд',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            movie.overview,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

String formatFullDate(String date) {
  final DateFormat inputFormat = DateFormat('yyyy-MM-dd');
  final DateTime inputDate = inputFormat.parse(date);
  final DateFormat outputFormat = DateFormat('dd MMMM yyyy', 'uk_UA');
  final String formattedDate = outputFormat.format(inputDate);

  return formattedDate;
}

String formatRunTime(int totalMinutes) {
  final hours = totalMinutes ~/ 60;
  final minutes = totalMinutes % 60;

  final formattedHours = hours > 0 ? '${hours} год' : '';
  final formattedMinutes = minutes > 0 ? '${minutes} хв' : '';

  return '$formattedHours,$formattedMinutes';
}
