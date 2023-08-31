import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioFilesScreen extends StatefulWidget {
  @override
  _AudioFilesScreenState createState() => _AudioFilesScreenState();
}

class _AudioFilesScreenState extends State<AudioFilesScreen> {
  List<FileSystemEntity> audioFiles = [];

  @override
  void initState() {
    super.initState();
    loadAudioFiles();
  }

  Future<void> loadAudioFiles() async {
    if (await Permission.storage.request().isGranted) {
      Directory directory = Directory(
          '/storage/emulated/0/Music'); // Replace with the directory where your .m4a files are located
      List<FileSystemEntity> files = directory.listSync();
      setState(() {
        audioFiles = files.where((file) => file.path.endsWith('.m4a')).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Files'),
      ),
      body: ListView.builder(
        itemCount: audioFiles.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(audioFiles[index].uri.pathSegments.last),
            onTap: () {
              // Add code here to play the selected .m4a audio file
            },
          );
        },
      ),
    );
  }
}
