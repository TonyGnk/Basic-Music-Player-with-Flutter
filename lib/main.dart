import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'screen.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); //Εξασφαλίζει ότι η συσκευή έχει αρχικοποιηθεί πλήρως
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(ProviderScope(child: MyApp()));
}

final playingStateProvider = StateProvider<bool>((ref) {
  return false;
});

final audioFilesProvider = FutureProvider<List<FileSystemEntity>>((ref) async {
  if (await Permission.storage.request().isGranted) {
    Directory directory = Directory.current;
    List<FileSystemEntity> files = [];

    if (Platform.isWindows) {
      directory = Directory('C:/Downloads');
      files = directory.listSync();
    } else if (Platform.isAndroid) {
      directory = Directory('/storage/emulated/0/Music');
      files = directory.listSync();
    }

    return files
        .where((file) =>
            file.path.endsWith('.m4a') ||
            file.path.endsWith('.mp3') ||
            file.path.endsWith('.wav'))
        .toList();
  }
  return <FileSystemEntity>[];
});

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 243, 243),
        body: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Screen(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
