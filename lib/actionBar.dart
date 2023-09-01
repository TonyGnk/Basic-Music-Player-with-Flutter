import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musicgnk/player.dart';

// ignore: must_be_immutable
class ActionBar extends StatefulWidget {
  ActionBar({required this.player});
  Player player = Player();
  bool play = true;
  bool play2 = true;

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
                if (widget.player.nowPlaying) {
                  print("h1");
                  widget.player.pause();
                  setState(() {
                    widget.player.setNowPlaying(false);
                  });
                } else {
                  print("h2");
                  widget.player.resume();
                  setState(() {
                    widget.player.setNowPlaying(true);
                  });
                }
              },
              icon: SvgPicture.asset(
                widget.player.nowPlaying
                    ? 'assets/stop.svg'
                    : 'assets/play.svg',
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
              ),
            ),
          ),
          SizedBox(width: 1),
          Expanded(
            child: ElevatedButton.icon(
                onPressed: () {
                  widget.player.dispose();
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
                  elevation: 0,
                )),
          ),
        ],
      ),
    );
  }
}
