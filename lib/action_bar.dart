import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicgnk/screen.dart';

import 'main.dart';

icon(
  BuildContext context,
  void Function() onPressed,
  IconData icon,
) =>
    IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Colors.white,
        size: 28,
      ),
    );

// ignore: must_be_immutable
class ActionBar extends StatelessWidget {
  const ActionBar({super.key});

  @override
  Widget build(BuildContext context) => Consumer(
        builder: (_, WidgetRef ref, __) {
          final myPlayer = ref.watch(playerProvider);
          final nowPlaying = ref.watch(playingStateProvider);
          {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: icon(
                        context,
                        () {},
                        Icons.skip_previous_rounded,
                      ),
                    ),
                    const SizedBox(width: 1),
                    Expanded(
                      child: icon(
                        context,
                        () {
                          if (nowPlaying) {
                            print("Set to pause");
                            myPlayer.pause();
                            ref.read(playingStateProvider.notifier).state =
                                false;
                          } else {
                            print("Set to play");
                            myPlayer.resume();
                            ref.read(playingStateProvider.notifier).state =
                                true;
                          }
                        },
                        nowPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                      ),
                    ),
                    const SizedBox(width: 1),
                    Expanded(
                      child: icon(
                        context,
                        () {},
                        Icons.skip_next_rounded,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      );
}
