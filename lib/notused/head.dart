// import 'package:audioplayers/audioplayers.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:musicgnk/player.dart';
// import 'package:path_provider/path_provider.dart';

// // ignore: must_be_immutable
// class TracksTab extends StatelessWidget {
//   final player = AudioPlayer();
//   Player playerz = Player();

//   TracksTab({required this.playerz});

//   //Create function A setting this await player.setSource(AssetSource('assets/Online.m4a'));
//   void playfun() async {
//     // Create a variable file, with file picker
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//     if (result != null) {
//       PlatformFile file = result.files.first;

//       print(file.name);
//       print(file.bytes);
//       print(file.size);
//       print(file.extension);
//       print(file.path);

//       String filePath = file.path!;

//       //1
//       //Κάλεσε την μέθοδο play του playerz και πέρνα την παράμετρο filePath
//       playerz.play(filePath);

//       //2
//       // await player.setSource(DeviceFileSource(filePath));
//       // print("Here");
//       // await player.resume();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       alignment: Alignment.center,
//       child: ListView(
//         scrollDirection: Axis.vertical,
//         children: [
//           //Create a button, when pressed call function A
//           ElevatedButton(
//             onPressed: () {
//               //Call function A
//               playfun();
//             },
//             child: Text('Select Song'),
//           ),
//         ],
//       ),
//     );
//   }
// }
