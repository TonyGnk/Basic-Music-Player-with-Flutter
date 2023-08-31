import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Player {
  final source = AudioPlayer();

  //Δημιούργησε μια μέθοδο όπου θα δέχεται την παράμετρο String filePath και θα κάνει await source.setSource(DeviceFileSource(filePath)); και μετά await source.resume();
  void play(String filePath) async {
    await source.setSource(DeviceFileSource(filePath));
    await source.resume();
  }

  //Δημιούργησε μια μέθοδο όπου δεν θα δέχεται τίποτα και θα κάνει await source.pause();
  void pause() async {
    await source.pause();
  }
}
