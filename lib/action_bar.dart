import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicgnk/screen.dart';

import 'main.dart';

// ignore: must_be_immutable
class ActionBar extends StatelessWidget {
  const ActionBar({super.key});

  @override
  Widget build(BuildContext context) => Consumer(
        builder: (_, WidgetRef ref, __) {
          final myPlayer = ref.watch(playerProvider);
          {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ref.read(darkStateProvider.notifier).state =
                            !ref.watch(darkStateProvider);
                      },
                      icon: const Icon(
                        Icons.skip_previous_rounded,
                        color: Colors.white,
                        size: 32,
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
                          icon: Icon(
                            nowPlaying
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 32,
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
                        myPlayer.dispose();
                      },
                      icon: const Icon(
                        Icons.skip_next_rounded,
                        color: Colors.white,
                        size: 32,
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
        },
      );
}
