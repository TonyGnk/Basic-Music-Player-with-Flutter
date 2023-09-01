import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Player {
  final source = AudioPlayer();

  void play(String filePath) async {
    await source.setSource(DeviceFileSource(filePath));
    await source.resume();
  }

  //Δημιούργησε μια μέθοδο όπου δεν θα δέχεται τίποτα και θα κάνει await source.pause();
  void pause() async {
    await source.pause();
  }

  void resume() async {
    await source.resume();
  }
}
