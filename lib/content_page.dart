import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '/audio_players.dart';
import '/models/audio_list.dart';
import '/status/home_status.dart';
import '/util/my_tile.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({super.key});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

final ValueNotifier<int> _currentPlayingIndex = ValueNotifier<int>(-1);
bool autoPlayNext = false;
bool autoRepeat = false;

class _ContentPageState extends State<ContentPage> {
  final List<ValueNotifier<PlayerState>> audioPlayerStates = List.generate(
      audioFile.length, (index) => ValueNotifier(PlayerState.stopped));

  final audioPlayers = AudioPlayerSingleton().audioPlayers;

  final ValueNotifier<Duration> _currentPosition =
      ValueNotifier<Duration>(Duration.zero);

  final ValueNotifier<Duration> _totalDuration =
      ValueNotifier<Duration>(Duration.zero);
  void stopAllPlayers(int currentIndex) async {
    await Future.delayed(const Duration(seconds: 1), () {
      for (var i = 0; i < audioPlayers.length; i++) {
        if (i != currentIndex) {
          audioPlayers[i].stop();
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < audioPlayers.length; i++) {
      audioPlayers[i].onPlayerStateChanged.listen((state) {
        audioPlayerStates[i].value = state;
      });
      audioPlayers[i].onPositionChanged.listen((position) {
        if (_currentPlayingIndex.value == i) {
          _currentPosition.value = position;
        }
      });
      audioPlayers[i].onDurationChanged.listen((duration) {
        if (_currentPlayingIndex.value == i) {
          _totalDuration.value = duration;
        }
      });
      audioPlayers[i].onPlayerComplete.listen((event) {
        audioPlayers[i].stop();

        if (_currentPlayingIndex.value != -1 &&
            _currentPlayingIndex.value < audioPlayers.length - 1 &&
            autoPlayNext == true) {
          setState(() {
            int nextIndex = _currentPlayingIndex.value + 1;

            audioPlayers[nextIndex].play(AssetSource(audioFile[nextIndex]));
            _currentPlayingIndex.value = nextIndex;
            stopAllPlayers(nextIndex);

            // Reset slider and position values
            _currentPosition.value = Duration.zero;
            _totalDuration.value = Duration.zero;
          });
        }

        // Check for autoRepeat here
        if (autoRepeat == true &&
            _currentPlayingIndex.value != -1 &&
            _currentPlayingIndex.value < audioPlayers.length - 1) {
          setState(() {
            stopAllPlayers(_currentPlayingIndex.value);
            audioPlayers[_currentPlayingIndex.value]
                .play(AssetSource(audioFile[_currentPlayingIndex.value]));
          });
        }
        _currentPosition.value = Duration.zero;
        _totalDuration.value = Duration.zero;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: false,
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: audioFile.length,
                    itemBuilder: (context, index) {
                      return ValueListenableBuilder(
                        valueListenable: audioPlayerStates[index],
                        builder: (context, value, child) {
                          return MyTile(
                            title: audioName[index],
                            onTapStatus: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return HomeStatus(
                                    sheikhName: sheikhName[index],
                                  );
                                },
                              ));
                            },
                            subTitle: sheikhName[index],
                            onTap: () {
                              setState(() {
                                if (_currentPlayingIndex.value == index) {
                                  audioPlayers[index].pause();
                                  _currentPlayingIndex.value = -1;
                                } else {
                                  if (_currentPlayingIndex.value != -1) {
                                    audioPlayers[_currentPlayingIndex.value]
                                        .stop();
                                    stopAllPlayers(index);
                                  }
                                  audioPlayers[index]
                                      .play(AssetSource(audioFile[index]));
                                  _currentPlayingIndex.value = index;
                                  stopAllPlayers(index);
                                }
                              });
                            },
                            primaryColor: _currentPlayingIndex.value == index &&
                                    value == PlayerState.playing
                                ? Colors.green
                                : Colors.white,
                          );
                        },
                      );
                    },
                  ),
                ),
                _currentPlayingIndex.value != -1
                    ? Container(color: Colors.grey[300], height: 98.9)
                    : const SizedBox(),
              ],
            ),
            //--------------------------------------------------------------

            _currentPlayingIndex.value != -1
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: _currentPosition,
                        builder: (context, value, child) {
                          return Container(
                            color: Colors.white,
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 4,
                                  ),
                                  child: Text(_currentPosition.value
                                      .toString()
                                      .substring(2, 7)),
                                ),
                                Expanded(
                                  child: 
                                  Slider(
                                    activeColor: Colors.grey[700],
                                    value: min(
                                        _currentPosition.value.inSeconds
                                            .toDouble(),
                                        _totalDuration.value.inSeconds
                                            .toDouble()),
                                    min: 0.0,
                                    max: (_totalDuration.value.inSeconds
                                        .toDouble()),
                                    onChanged: (value) {
                                      setState(() {
                                        if (_currentPlayingIndex.value != -1) {
                                          audioPlayers[
                                                  _currentPlayingIndex.value]
                                              .seek(Duration(
                                                  seconds: value.toInt()));
                                          _currentPosition.value =
                                              Duration(seconds: value.toInt());
                                        }
                                      });
                                    },
                                  ),
            
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 4),
                                  child: Text(_totalDuration.value
                                      .toString()
                                      .substring(2, 7)),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      Container(
                        color: Colors.green,
                        // padding: const EdgeInsets.all(0.0),/////////----
                        child: ValueListenableBuilder(
                          valueListenable: _currentPlayingIndex.value > 0
                              ? audioPlayerStates[_currentPlayingIndex.value]
                              : audioPlayerStates[0],
                          builder: (context, value, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  tooltip: 'تكرار الملف الحالي',
                                  icon: const Icon(Icons.cached_rounded),
                                  color: autoRepeat == true
                                      ? Colors.black
                                      : Colors.green[800],
                                  onPressed: () {
                                    setState(() {
                                      autoRepeat = !autoRepeat;
                                      if (autoPlayNext == true) {
                                        autoPlayNext = false;
                                      }
                                    });
                                  },
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (_currentPlayingIndex.value > 0 &&
                                          _currentPlayingIndex.value <
                                              audioFile.length) {
                                        audioPlayers[_currentPlayingIndex.value]
                                            .stop();
                                        _currentPlayingIndex.value--;
                                        audioPlayers[_currentPlayingIndex.value]
                                            .play(AssetSource(audioFile[
                                                _currentPlayingIndex.value]));
                                      }
                                    });
                                  },
                                  icon: const Icon(Icons.skip_previous_rounded,
                                      size: 40),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (_currentPlayingIndex.value > -1) {
                                        if (value == PlayerState.playing) {
                                          audioPlayers[
                                                  _currentPlayingIndex.value]
                                              .pause();
                                        } else {
                                          audioPlayers[
                                                  _currentPlayingIndex.value]
                                              .resume();
                                        }
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    value == PlayerState.playing
                                        ? Icons.pause
                                        : Icons.play_arrow_rounded,
                                    size: 45,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (_currentPlayingIndex.value > -1 &&
                                          // value == PlayerState.playing &&
                                          _currentPlayingIndex.value <
                                              audioFile.length - 1) {
                                        audioPlayers[_currentPlayingIndex.value]
                                            .stop();
                                        _currentPlayingIndex.value++;
                                        audioPlayers[_currentPlayingIndex.value]
                                            .play(AssetSource(audioFile[
                                                _currentPlayingIndex.value]));
                                      }
                                    });
                                  },
                                  icon: const Icon(Icons.skip_next_rounded,
                                      size: 40),
                                ),
                                //
                                IconButton(
                                    tooltip: 'تشغيل تلقائي للتالي',
                                    color: autoPlayNext == true
                                        ? Colors.black
                                        : Colors.green[800],
                                    onPressed: () {
                                      setState(() {
                                        autoPlayNext = !autoPlayNext;
                                        if (autoRepeat == true) {
                                          autoRepeat = false;
                                        }
                                      });
                                    },
                                    icon: const Icon(Icons.shuffle_rounded))
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
