import 'package:audioplayers/audioplayers.dart';
import '/models/audio_list.dart';

class AudioPlayerSingleton {
  static final AudioPlayerSingleton _singleton =
      AudioPlayerSingleton._internal();
  late List<AudioPlayer> audioPlayers;

  factory AudioPlayerSingleton() {
    return _singleton;
  }

  AudioPlayerSingleton._internal() {
    // audioPlayers = List.generate(audioFile.length, (index) => AudioPlayer());

    audioPlayers = List.generate(
      audioFile.length,
      (index) => AudioPlayer(),
    );
  }
}
