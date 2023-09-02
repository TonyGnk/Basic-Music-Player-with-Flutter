import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:musicgnk/player.dart';

import 'main.dart';

class TracksList extends StatelessWidget {
  final Player playerz;

  TracksList({required this.playerz});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final audioFilesAsync = ref.watch(audioFilesProvider);

        return audioFilesAsync.when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
          data: (audioFiles) {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: audioFiles.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    playerz.setLastSong(audioFiles[index].path);
                  }

                  return Consumer(
                    builder: (_, WidgetRef ref, __) {
                      final nowPlaying = ref.watch(playingStateProvider);
                      return ElevatedButton(
                        child: Row(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              padding: EdgeInsets.all(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 178, 171, 191),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/music.svg',
                                    width: 20,
                                    height: 20,
                                    colorFilter: ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 1),
                            Expanded(
                              child: Container(
                                height: 70,
                                padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                                decoration: index != audioFiles.length - 1
                                    ? BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            width: 1.0,
                                            color: Color.fromARGB(
                                                255, 232, 232, 232),
                                          ),
                                        ),
                                      )
                                    : null,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      removeLastFour(audioFiles[index]
                                          .uri
                                          .pathSegments
                                          .last),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 76, 76, 76),
                                      ),
                                    ),
                                    Text(
                                      "Άγνωστο",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 76, 76, 76),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          playerz.play(audioFiles[index].path);
                          print("Pressed");
                          ref.read(playingStateProvider.notifier).state = true;
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(
                              0, 255, 255, 255), // background color
                          foregroundColor: Colors.white,
                          shadowColor: const Color.fromARGB(0, 255, 255, 255),
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          elevation: 0,
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  String removeLastFour(String str) {
    return str.substring(0, str.length - 4);
  }
}

class MyEvent {
  final String path;

  MyEvent(this.path);
}
