import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class SongsProvider extends ChangeNotifier {
  final OnAudioQuery onaudioquery = OnAudioQuery();
  final AudioPlayer audioplayer = AudioPlayer();
  var playIndex = 0;
  bool isplaying = false;

  // for checking the permission
  checkPermission() async {
    final per = Permission.storage.request();
    if (await per.isGranted) {
    } else {
      checkPermission();
    }
    notifyListeners();
  }

//for fetching the songs
  playSongs(String? uri, index) {
    playIndex = index;
    try {
      audioplayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      audioplayer.play();
      isplaying = true;
    } on Exception catch (e) {
      e;
    }
    notifyListeners();
  }

  void stopMusic() {
    audioplayer.pause();
    isplaying = false;
    notifyListeners();
  }

  void playingIndex(int index) {}
}
