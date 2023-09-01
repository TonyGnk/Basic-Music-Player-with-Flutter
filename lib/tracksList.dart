import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:musicgnk/player.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class TracksList extends StatefulWidget {
  Player playerz = Player();
  TracksList({required this.playerz});
  Directory dir = Directory.current;

  @override
  _TracksList createState() => _TracksList();
}

class _TracksList extends State<TracksList> {
  List<FileSystemEntity> audioFiles = []; //Δημιουργία λίστας για τα αρχεία ήχου

  @override
  void initState() {
    super.initState();
    loadAudioFiles(); //Κλήση για την φόρτωση των αρχείων ήχου
  }

  Future<void> loadAudioFiles() async {
    if (await Permission.storage.request().isGranted) {
      //Δημιουργία αντικειμένου Directory με την διαδρομή του φακέλου που θέλουμε να ανοίξουμε

      Directory directory = Directory.current;
      List<FileSystemEntity> files = [];

      if (Platform.isWindows) {
        directory = Directory('C:/Downloads');
        files = directory.listSync();
      } else if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Music');
        files = directory.listSync();
      }

      //Αποθήκευση των αρχείων που βρίσκονται στον φάκελο στην λίστα audioFiles

      //Φιλτράρισμα των αρχείων με βάση την κατάληξη τους
      setState(() {
        audioFiles = files
            .where((file) =>
                file.path.endsWith('.m4a') ||
                file.path.endsWith('.mp3') ||
                file.path.endsWith('.wav'))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: audioFiles.length,
        itemBuilder: (context, index) {
          return ListTile(
            //Εμφάνιση του ονόματος του αρχείου στην λίστα
            title: Text(audioFiles[index].uri.pathSegments.last),

            //Εμφάνιση του filepath του αρχείου στην λίστα
            subtitle: Text(audioFiles[index].path),

            //Κατά το πάτημα του κάθε αρχείου θα εκτελείται η συνάρτηση playerz.play(filePath);
            onTap: () {
              widget.playerz.play(audioFiles[index].path);
            },
          );
        },
      ),
    );
  }
}
