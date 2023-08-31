import 'package:flutter/material.dart';
import 'package:musicapp/controller/contoller.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class PlayerScreen extends StatefulWidget {
  final SongModel data;
  const PlayerScreen({super.key, required this.data});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SongsProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text("Songs"),
          ),
          body: Column(children: [
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: QueryArtworkWidget(
                  artworkQuality: FilterQuality.high,
                  id: widget.data.id,
                  type: ArtworkType.AUDIO,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        widget.data.displayNameWOExt,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.data.artist.toString(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              value.position,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Slider(
                                inactiveColor: Colors.black,
                                thumbColor: Colors.white,
                                value: value.value,
                                min: const Duration(seconds: 0)
                                    .inSeconds
                                    .toDouble(),
                                max: value.max,
                                onChanged: (newvalue) {
                                  value.changeDurationtoSeconds(
                                      newvalue.toInt());
                                  newvalue = newvalue;
                                },
                              ),
                            ),
                            Text(
                              value.duration,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              value.playSongs(
                                  widget.data.uri, value.playIndex - 1);
                            },
                            icon: const Icon(
                              Icons.skip_previous_rounded,
                              color: Colors.black,
                              size: 35,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                if (value.isplaying) {
                                  value.stopMusic();
                                  value.isplaying = false;
                                } else {
                                  value.audioplayer.play();
                                  value.isplaying = true;
                                }
                              },
                              icon: value.isplaying
                                  ? const Icon(
                                      Icons.pause,
                                      color: Colors.black,
                                      size: 40,
                                    )
                                  : const Icon(
                                      Icons.play_arrow_rounded,
                                      color: Colors.black,
                                      size: 40,
                                    )),
                          IconButton(
                            onPressed: () {
                              value.playSongs(
                                  widget.data.uri, value.playIndex + 1);
                            },
                            icon: const Icon(
                              Icons.skip_next_rounded,
                              color: Colors.black,
                              size: 35,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}
