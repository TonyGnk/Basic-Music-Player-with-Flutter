//Περιγραφή εφαρμογής: Αυτή είναι μια εφαρμογή αναπαραγωγής μουσικής. Ο χρήστης μπορεί να ακούσει τα τραγούδια που έχει στην συσκευή του. Μπορεί να πατήσει το κουμπί play για να ακούσει το τραγούδι που είναι επιλεγμένο. Μπορεί να πατήσει το κουμπί pause για να σταματήσει το τραγούδι που παίζει.
//Θέλω να ενσωματώσω στην εφαρμογή dark theme και Light theme. Θα δημιουργήσω μια κλάση ThemeData όπου θα ορίζω τα χρώματα για το Light Theme και το Dark Theme. Μετά θα φτιάξω ένα ThemeProvider στην Main που ανάλογα τις ρυθμίσεις της συσκευής θα επιστρέφει το Light Theme ή το Dark Theme.

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicgnk/themeData.dart';
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

final darkStateProvider = StateProvider<bool>((ref) {
  return false;
});

final themeProvider = Provider<ThemeData>((ref) {
  // Επιλέξτε το θέμα βάσει των ρυθμίσεων της εφαρμογής (φωτεινή ή σκοτεινή λειτουργία)
  bool isDarkMode = ref.watch(darkStateProvider);
  return isDarkMode ? MyThemeData.darkTheme : MyThemeData.lightTheme;
});

//Create a provider that asynchronously loads a list of audio files
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

//Κλάση MyApp
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      theme: theme,
      home: Scaffold(
        //Set the background color to primaryColor of theme
        backgroundColor: theme.colorScheme.background,
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
