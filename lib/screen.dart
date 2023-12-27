// ignore_for_file: avoid_print

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicgnk/tab_part.dart';
import 'package:musicgnk/top_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'main.dart';
import 'tracks_list.dart';
import 'player.dart';
import 'action_bar.dart';

// ignore: must_be_immutable
class Screen extends ConsumerStatefulWidget {
  Screen({super.key});
  final player = Player();

  final primeMs = 300;

  @override
  ConsumerState<Screen> createState() => _NewState();
}

class _NewState extends ConsumerState<Screen> {
  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  @override
  Widget build(BuildContext context) =>
      Consumer(builder: (_, WidgetRef ref, __) {
        final settingsOpened = ref.watch(settingsState);
        // ignore: deprecated_member_use
        return WillPopScope(
          onWillPop: () async {
            ref.read(settingsState.notifier).state = false;
            if (settingsOpened) {
              return false; // Prevent the back navigation
            } else {
              return true; // Allow the back navigation
            }
          },
          child: column(context, ref, settingsOpened),
        );
      });

  void requestPermissions() async {
    if (await Permission.storage.request().isGranted) {
      print("TRUE = await Permission.storage.request().isGranted");
    } else {
      print("FALSE = await Permission.storage.request().isGranted");
    }
  }

  column(BuildContext context, WidgetRef ref, bool settingsOpened) => Column(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                ref.read(settingsState.notifier).state =
                    !ref.watch(settingsState);
                print(ref.watch(settingsState));
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: settingsOpened
                    ? MediaQuery.of(context).size.height - 30
                    : 110,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: settingsOpened
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        )
                      : const BorderRadius.all(Radius.circular(40)),
                ),
                child: const TopBar(),
              ),
            ),
          ),
          SizedBox(height: settingsOpened ? 0 : 12),
          AnimatedContainer(
            height:
                settingsOpened ? 0 : MediaQuery.of(context).size.height - 162,
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(
                Radius.circular(40),
              ),
            ),
            child: column2(),
          ),
        ],
      );

  column2() => Column(
        children: [
          Expanded(
            child: AnimatedContainer(
              duration: Duration(milliseconds: widget.primeMs),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.all(
                  Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  AnimatedContainer(
                    height: 60,
                    duration: Duration(milliseconds: widget.primeMs),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                    ),
                    child: const TabPart(),
                  ),
                  Expanded(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: widget.primeMs),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: TracksList(playerz: widget.player),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 50,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: ActionBar(player: widget.player),
          )
        ],
      );
}
