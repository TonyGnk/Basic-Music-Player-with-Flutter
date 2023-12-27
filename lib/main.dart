/// This file contains the main code for the MusicGNK Flutter application.
/// It imports necessary packages and defines the main function that runs the app.
/// The app uses the Flutter Riverpod package for state management.
/// The main function initializes the app and sets the system UI overlay style.
/// The MyApp class is a ConsumerWidget that builds the app UI using the theme and state providers.
/// The playingStateProvider, settingsState, darkStateProvider, and themeProvider are all state providers used in the app.
/// The audioFilesProvider is a FutureProvider that asynchronously loads a list of audio files from the device's storage.
library;

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicgnk/theme_data.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); //Εξασφαλίζει ότι η συσκευή έχει αρχικοποιηθεί πλήρως
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(const ProviderScope(child: MyApp()));
}

//Κλάση MyApp
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Scaffold(
        //Set the background color to primaryColor of theme
        backgroundColor: theme.colorScheme.background,
        body: Center(
          child: Consumer(
            builder: (_, WidgetRef ref, __) {
              final settingsOpened = ref.watch(settingsState);
              return Padding(
                padding: settingsOpened
                    ? const EdgeInsets.fromLTRB(0, 30, 0, 0)
                    : const EdgeInsets.fromLTRB(10, 30, 10, 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.all(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Screen(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

final playingStateProvider = StateProvider<bool>((ref) {
  return false;
});

final settingsState = StateProvider<bool>((ref) {
  return false;
});

final darkStateProvider = StateProvider<bool>((ref) {
  final sharedPreferencesAsyncValue = ref.watch(prefs);
  return sharedPreferencesAsyncValue.when(
    data: (sharedPreferences) {
      bool? darkEnabled = sharedPreferences.getBool('darkMode');
      if (darkEnabled != null) {
        return darkEnabled;
      } else {
        return false;
      }
    },
    loading: () {
      // Handle the case when SharedPreferences is still loading
      return false; // You can change this to an appropriate default value
    },
    error: (error, stackTrace) {
      // Handle the error case
      return false; // You can change this to an appropriate default value
    },
  );
});

//Δημιουργία ενός StateProvider που θα αποθηκεύει τις ρυθμίσεις της εφαρμογής
final prefs = FutureProvider<SharedPreferences>((ref) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences;
});

final themeProvider = Provider<ThemeData>((ref) {
  bool isDarkMode = ref.watch(darkStateProvider);
  return isDarkMode ? MyThemeData.darkTheme : MyThemeData.lightTheme;
});

final audioMetadata = Provider<ThemeData>((ref) {
  bool isDarkMode = ref.watch(darkStateProvider);
  return isDarkMode ? MyThemeData.darkTheme : MyThemeData.lightTheme;
});

//Create a provider that asynchronously loads a list of audio files
final audioFilesProvider = FutureProvider<List<FileSystemEntity>>((ref) async {
  if (await Permission.storage.request().isGranted) {
    Directory directory = Directory.current;
    List<FileSystemEntity> files = [];

    if (Platform.isWindows) {
      //directory for users music
      directory =
          Directory('C:/Users/${Platform.environment['USERNAME']}/Music');
      files = directory.listSync();
    } else if (Platform.isAndroid) {
      directory = Directory('/storage/emulated/0/Music');
      files = directory.listSync();
    }

    // for (var file in files) {
    //   Song(file);
    // }

    final audioFiles = files
        .where((file) =>
            file.path.endsWith('.m4a') ||
            file.path.endsWith('.mp3') ||
            file.path.endsWith('.wav'))
        .toList();

    for (var file in audioFiles) {
      //Song(file);
    }

    return audioFiles;
  }
  return <FileSystemEntity>[];
});
