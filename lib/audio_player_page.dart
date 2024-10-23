import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerPage extends StatefulWidget {
  const AudioPlayerPage({super.key});

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  late AudioPlayer advancedPlayer;

  Duration position = Duration.zero;
  Duration musicLength = Duration.zero;

  String imagePath = "assets/a.jpg";

  @override
  void initState() {
    super.initState();

    advancedPlayer = AudioPlayer();

    advancedPlayer.onDurationChanged.listen((duration) {
      setState(() => musicLength = duration);
    });

    advancedPlayer.onPositionChanged.listen((position) {
      setState(() => this.position = position);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.grey,
      body: ListView(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 600) {
                    // Mobile layout
                    return Column(
                      children: [
                        Image.asset(imagePath),
                        Slider(
                          activeColor: Colors.black54,
                          value: position.inSeconds.toDouble(),
                          max: musicLength.inSeconds.toDouble(),
                          onChanged: (value) => seekToSecond(value.toInt()),
                        ),
                      ],
                    );
                  } else {
                    // Tablet or desktop layout
                    return Row(
                      children: [
                        Expanded(
                          child: Image.asset(imagePath),
                        ),
                        Expanded(
                          child: Slider(
                            activeColor: Colors.black54,
                            value: position.inSeconds.toDouble(),
                            max: musicLength.inSeconds.toDouble(),
                            onChanged: (value) => seekToSecond(value.toInt()),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: IconButton(
                        icon: const Icon(Icons.skip_previous),
                        onPressed: () => playPrevious(),
                      ),
                    ),
                    Flexible(
                      child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return IconButton(
                            icon: Icon(
                              advancedPlayer.state == PlayerState.playing
                                  ? Icons.pause
                                  : Icons.play_arrow,
                            ),
                            onPressed: () => setState(() => _togglePlayer()),
                          );
                        },
                      ),
                    ),
                    Flexible(
                      child: IconButton(
                        icon: const Icon(Icons.skip_next),
                        onPressed: () => playNext(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  void seekToSecond(int second) =>
      advancedPlayer.seek(Duration(seconds: second));

  void playPrevious() {
    // logic to play previous track
  }

  void playNext() {
    // logic to play next track
  }

  void _togglePlayer() {
    advancedPlayer.state == PlayerState.playing
        ? advancedPlayer.pause()
        : advancedPlayer.play(AssetSource("auoob.m4a"));
  }
}

////////////////////////////
///
///