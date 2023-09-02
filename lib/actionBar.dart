import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musicgnk/player.dart';

import 'main.dart';

class ActionBar extends StatelessWidget {
  ActionBar({required this.player});
  Player player = Player();
  bool play = true;
  bool play2 = true;

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
            child: Consumer(
              builder: (_, WidgetRef ref, __) {
                final nowPlaying = ref.watch(playingStateProvider);
                return ElevatedButton.icon(
                  onPressed: () {
                    if (nowPlaying) {
                      print("Set to pause");
                      player.pause();
                      ref.read(playingStateProvider.notifier).state = false;
                    } else {
                      print("Set to play");
                      player.resume();
                      ref.read(playingStateProvider.notifier).state = true;
                    }
                  },
                  icon: SvgPicture.asset(
                    nowPlaying ? 'assets/stop.svg' : 'assets/play.svg',
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
                );
              },
            ),
          ),
          SizedBox(width: 1),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                player.dispose();
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
