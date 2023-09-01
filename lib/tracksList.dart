import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
          if (index == 0) {
            widget.playerz.setLastSong(audioFiles[index].path);
          }
          return ElevatedButton(
            child: Row(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  padding: EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 178, 171, 191),
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/music.svg',
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 1),
                Expanded(
                  child: Container(
                    height: 70,
                    padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                    decoration: index != audioFiles.length - 1
                        ? BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1.0,
                                color: Color.fromARGB(255, 232, 232, 232),
                              ),
                            ),
                          )
                        : null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          removeLastFour(
                              audioFiles[index].uri.pathSegments.last),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 76, 76, 76),
                          ),
                        ),
                        Text(
                          "Άγνωστο",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 76, 76, 76),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              widget.playerz.play(audioFiles[index].path);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Color.fromARGB(0, 255, 255, 255), // background color
              foregroundColor: Colors.white,
              shadowColor: const Color.fromARGB(0, 255, 255, 255),
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              elevation: 0,
            ),
          );
        },
      ),
    );
  }

  //Create a function to remove the 4 last letters of a String
  String removeLastFour(String str) {
    return str.substring(0, str.length - 4);
  }
}
