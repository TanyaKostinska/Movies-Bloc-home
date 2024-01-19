import 'package:flutter/material.dart';
import 'package:movies/style/app_colors.dart';

class RatingCircleWidget extends StatelessWidget {
  final double rating;

  const RatingCircleWidget({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    double normalizedRating = rating / 10;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
          ),
          child: CircularProgressIndicator(
            value: normalizedRating,
            strokeWidth: 3,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
            backgroundColor: AppColors.background,
          ),
        ),
        Text(
          '$rating',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}