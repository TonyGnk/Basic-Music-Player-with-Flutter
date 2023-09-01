import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musicgnk/player.dart';

// ignore: must_be_immutable
class ActionBar extends StatefulWidget {
  ActionBar({required this.player});
  Player player = Player();
  bool play = false;

  @override
  _NewState createState() => _NewState();
}

class _NewState extends State<ActionBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton.icon(
                onPressed: () {
                  //For later
                },
                icon: SvgPicture.asset(
                  'assets/previous.svg',
                  width: 34,
                  height: 34,
                  colorFilter: ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                label: Text(
                  '',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                //Changing the style, removing the color and shadow
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                )),
          ),
          SizedBox(width: 1),
          Expanded(
            child: ElevatedButton.icon(
                onPressed: () {
                  if (widget.play) {
                    widget.player.resume();
                    setState(() {
                      widget.play = false;
                    });
                  } else {
                    widget.player.pause();
                    setState(() {
                      widget.play = true;
                    });
                  }
                },
                icon: SvgPicture.asset(
                  widget.play ? 'assets/play.svg' : 'assets/stop.svg',
                  width: 34,
                  height: 34,
                  colorFilter: ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                label: Text(
                  '',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                //Changing the style, removing the color and shadow
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                )),
          ),
          SizedBox(width: 1),
          Expanded(
            child: ElevatedButton.icon(
                onPressed: () {
                  //For later
                },
                icon: SvgPicture.asset(
                  'assets/next.svg',
                  width: 34,
                  height: 34,
                  colorFilter: ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                label: Text(
                  '',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                //Changing the style, removing the color and shadow
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                )),
          ),
        ],
      ),
    );
  }
}
