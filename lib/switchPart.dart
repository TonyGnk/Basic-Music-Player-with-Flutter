import 'package:flutter/material.dart';
import 'package:musicgnk/player.dart';

// ignore: must_be_immutable
class SwitchPart extends StatefulWidget {
  SwitchPart({required this.player});
  Player player = Player();

  @override
  _NewState createState() => _NewState();
}

class _NewState extends State<SwitchPart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 116, 94, 158),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        child: Text("Παύση"),
        onPressed: () {
          //Κάλεσε την μέθοδο pause της player
          widget.player.pause();
        },
      ),
    );
  }
}
