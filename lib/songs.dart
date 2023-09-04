// //Αυτή είναι η κλάση για κάθε τραγούδι.
// //Κάθε τραγούδι περιέχει τον τίτλο, τον καλλιτέχνη, τον χρόνο και το άλμπουμ.
// //Για την δημιουργία του κάθε τραγουδιού χρειάζεται ένα FileSystemEntity που είναι αρχείο ήχου

// import 'package:metadata_god/metadata_god.dart';
// import 'dart:io';
// import 'package:path/path.dart' as path;

// class Song {
//   late String title;
//   late String artist;
//   late String album;
//   late double duration;

//   Song(FileSystemEntity audioFile) {
//     print("Call Song");
//     initializeMetadata(audioFile);
//   }

//   Future<void> initializeMetadata(FileSystemEntity audioFile) async {
//     // Ελέγξτε τον τύπο του αρχείου πριν από την ανάγνωση των μεταδεδομένων.
//     if (audioFile is File && path.extension(audioFile.path) == '.mp3') {
//       final metadata = await MetadataGod.readMetadata(file: audioFile.path);

//       title = metadata.title ?? "Unknown Title";
//       print(title);
//       artist = metadata.artist ?? "Unknown Artist";
//       print(artist);
//       album = metadata.album ?? "Unknown Album";
//       print(album);
//     } else {
//       print("Unsupported file type or format: ${audioFile.runtimeType}");
//     }
//   }
// }
