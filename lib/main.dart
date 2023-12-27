import 'dart:io';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicgnk/adaptive_root.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!UniversalPlatform.isWeb) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      title: 'Flutter Audio Player',
      size: Size(360, 700),
      backgroundColor: Colors.transparent,
      titleBarStyle: TitleBarStyle.normal,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () {});
  }

  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(
    ProviderScope(
      child: buildApp(savedThemeMode: savedThemeMode),
    ),
  );
}

AdaptiveRoot buildApp({AdaptiveThemeMode? savedThemeMode}) => AdaptiveRoot(
      savedThemeMode: savedThemeMode,
      appTitle: 'Flutter Audio Player',
      debugShowFloatingThemeButton: false,
    );

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

final prefs = FutureProvider<SharedPreferences>((ref) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences;
});

final audioFilesProvider = FutureProvider<List<FileSystemEntity>>((ref) async {
  if (await Permission.storage.request().isGranted) {
    Directory directory = Directory.current;
    List<FileSystemEntity> files = [];

    if (UniversalPlatform.isWindows) {
      directory =
          Directory('C:/Users/${Platform.environment['USERNAME']}/Music');
      files = directory.listSync();
    } else if (UniversalPlatform.isAndroid) {
      directory = Directory('/storage/emulated/0/Music');
      files = directory.listSync();
    }

    final audioFiles = files
        .where((file) =>
            file.path.endsWith('.m4a') ||
            file.path.endsWith('.mp3') ||
            file.path.endsWith('.wav'))
        .toList();

    return audioFiles;
  } else if (UniversalPlatform.isWeb) {
    //If the platform is web, we can't use the local audio files. We return the preloaded audio files inside the file assets/Web Audio Files and we load only the track titanium.mp3
    return [
      File('assets/Web Audio Files/titanium.mp3'),
      File('assets/Web Audio Files/glossy.mp3'),
    ];
  }
  return <FileSystemEntity>[];
});
