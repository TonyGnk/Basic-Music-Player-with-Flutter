import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicgnk/screen.dart';
import 'main.dart';

class TracksList extends StatelessWidget {
  const TracksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final audioFilesAsync = ref.watch(audioFilesProvider);
        final myPlayer = ref.watch(playerProvider);
        final currentIndex = ref.watch(playingIndex);
        return audioFilesAsync.when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
          data: (audioFiles) {
            return ListView.builder(
              itemCount: audioFiles.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  myPlayer.setLastSong(audioFiles[index].path);
                }
                return trackTile(
                  audioFiles,
                  index,
                  Row(
                    children: [
                      musicIcon(context),
                      const SizedBox(width: 1),
                      Expanded(
                        child: Container(
                          height: 70,
                          padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                          decoration: index != audioFiles.length - 1
                              ? const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1.0,
                                      color: Color.fromARGB(255, 232, 232, 232),
                                    ),
                                  ),
                                )
                              : null,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                removeExtension(
                                    audioFiles[index].uri.pathSegments.last),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              Text(
                                "Unknown",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                      .withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget trackTile(
    List<FileSystemEntity> audioFiles,
    int index,
    Widget child,
  ) =>
      Consumer(
        builder: (context, ref, _) {
          final myPlayer = ref.watch(playerProvider);
          final currentIndex = ref.watch(playingIndex);

          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Material(
              clipBehavior: Clip.antiAlias,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(22),
                ),
              ),
              color: currentIndex == index
                  ? Colors.grey.withOpacity(0.1)
                  : Colors.transparent,
              child: InkWell(
                onTap: () {
                  myPlayer.play(audioFiles[index].path);
                  ref.read(playingIndex.notifier).state = index;
                  ref.read(playingStateProvider.notifier).state = true;
                },
                child: child,
              ),
            ),
          );
        },
      );

  Widget musicIcon(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      padding: const EdgeInsets.all(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onError,
          borderRadius: const BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.music_note_rounded,
            size: 26,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  String removeExtension(String str) {
    return str.substring(0, str.length - 4);
  }
}

final playingIndex = StateProvider<int>((ref) => -1);
final totalSongsProvider = StateProvider<int>((ref) => -1);
