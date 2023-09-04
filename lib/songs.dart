// //Αυτή είναι η κλάση για κάθε τραγούδι.
// //Κάθε τραγούδι περιέχει τα αναμενόμενα απαραίτητα πεδία
// //Για την δημιουργία του κάθε τραγουδιού χρειάζεται ένα FileSystemEntity που είναι αρχείο ήχου

// import 'dart:io';

// import 'package:flutter_media_metadata/flutter_media_metadata.dart';

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
//     if (audioFile is File) {
//       final metadata = await MetadataRetriever.fromFile(audioFile);

//       title = metadata.trackName ?? "Unknown Title";
//       print(title);
//       artist = metadata.authorName ?? "Unknown Artist";
//       print(artist);
//       album = metadata.albumName ?? "Unknown Album";
//       print(album);
//     } else {
//       print("Unsupported file type or format: ${audioFile.runtimeType}");
//     }
//   }
// }
