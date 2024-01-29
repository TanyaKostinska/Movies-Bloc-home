import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../model/trailer_model.dart';

class Trailer extends StatelessWidget {
  final List<TrailerModel> trailers;

  const Trailer({super.key, required this.trailers});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Trailer'),
        SizedBox(
          height: 400,
          child: PageView.builder(
              itemCount: trailers.length,
              itemBuilder: (BuildContext, int index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  width: MediaQuery.of(context).size.width * 0.96,
                  child: _videoTrailer(trailers: trailers[index]),
                );
              }),
        ),
      ],
    );
  }

  Widget _videoTrailer({required TrailerModel trailers}) {
    return Scaffold(
      body: Container(
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: trailers.key,
              flags: const YoutubePlayerFlags(
                autoPlay: true,
                mute: false,
              ),
            ),
            showVideoProgressIndicator: false,
            progressIndicatorColor: Colors.red,
            progressColors: const ProgressBarColors(
              playedColor: Colors.red,
              handleColor: Colors.redAccent,
            ),
          ),
          builder:(context, player) => player,
        ),
      ),
    );
  }
}
