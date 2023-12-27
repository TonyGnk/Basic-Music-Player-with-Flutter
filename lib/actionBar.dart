import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musicgnk/player.dart';

import 'main.dart';

// ignore: must_be_immutable
class ActionBar extends StatelessWidget {
  ActionBar({super.key, required this.player});
  Player player = Player();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Consumer(
              builder: (_, WidgetRef ref, __) {
                return ElevatedButton.icon(
                  onPressed: () {
                    ref.read(darkStateProvider.notifier).state =
                        !ref.watch(darkStateProvider);
                    print(ref.watch(darkStateProvider));
                  },
                  icon: SvgPicture.asset(
                    'assets/previous.svg',
                    width: 34,
                    height: 34,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: const Text(
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
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 1),
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
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: const Text(
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
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 1),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                player.dispose();
              },
              icon: SvgPicture.asset(
                'assets/next.svg',
                width: 34,
                height: 34,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              label: Text(
                '',
                style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.background),
              ),
              //Changing the style, removing the color and shadow
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
