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
class Screen extends StatefulWidget {
  //Αρχικοποίηση Μεταβλητών
  Player player = Player();

  int primeMs = 200;

  Screen({super.key}); //Ιδανικό 350

  @override
  _NewState createState() => _NewState();
}

class _NewState extends State<Screen> {
  //Πρώτη Εκτέλεση
  @override
  void initState() {
    super.initState();

    requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final settingsOpened = ref.watch(settingsState);
      return WillPopScope(
        onWillPop: () async {
          final settingsOpened = ref.watch(settingsState);
          if (settingsOpened) {
            ref.read(settingsState.notifier).state = false;
            return false; // Prevent the back navigation
          } else {
            return true; // Allow the back navigation
          }
        },
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                ref.read(settingsState.notifier).state =
                    !ref.watch(settingsState);
                print(ref.watch(settingsState));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(0, 255, 255, 255), // background color
                foregroundColor: Colors.white,
                shadowColor: const Color.fromARGB(0, 255, 255, 255),
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                elevation: 0,
              ),
              child: AnimatedContainer(
                duration: Duration(milliseconds: widget.primeMs),
                curve: Curves.easeInOut,
                width: settingsOpened
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width - 20,
                height: settingsOpened
                    ? height(MediaQuery.of(context).size.height, 11)
                    : height(MediaQuery.of(context).size.height, 1),
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
            SizedBox(
                height: settingsOpened
                    ? 0
                    : height(MediaQuery.of(context).size.height, 2)),
            AnimatedContainer(
              duration: Duration(milliseconds: widget.primeMs),
              curve: Curves.easeInOut,
              width: MediaQuery.of(context).size.width - 20,
              height: settingsOpened
                  ? 0
                  : height(MediaQuery.of(context).size.height, 3),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.all(
                  Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: widget.primeMs),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(40),
                      ),
                    ),
                    child: Column(children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: widget.primeMs),
                        curve: Curves.easeInOut,
                        width: MediaQuery.of(context).size.width - 20,
                        height: settingsOpened
                            ? 0
                            : height(MediaQuery.of(context).size.height, 31),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                        ),
                        child: const TabPart(),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: widget.primeMs),
                        curve: Curves.easeInOut,
                        width: MediaQuery.of(context).size.width - 20,
                        height: settingsOpened
                            ? 0
                            : height(MediaQuery.of(context).size.height, 32),
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: TracksList(playerz: widget.player),
                      )
                    ]),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: widget.primeMs),
                    curve: Curves.easeInOut,
                    width: MediaQuery.of(context).size.width - 20,
                    height: settingsOpened
                        ? 0
                        : height(MediaQuery.of(context).size.height, 33),
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: ActionBar(player: widget.player),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  void requestPermissions() async {
    if (await Permission.storage.request().isGranted) {
      print("TRUE = await Permission.storage.request().isGranted");
    } else {
      print("NOT");
    }
  }

  double height(double height, int type) {
    double heightUp = 0;
    double heightSpacer = 0;
    double heightDown = 0;
    double stableTop = 0;
    double percentTop = 0;
    double paddingTop = 0;
    double impact = 0;
    double stableSpacer = 0;
    double heightDownFirst = 0;
    double heightDownSecond = 0;
    double heightDownThird = 0;

    stableTop = 400;
    percentTop = 0.15; //Πόσο μέρος θέλει να πιάνει το UP
    paddingTop = 40; //Για την StatusBar
    impact = 1; //Η οθόνη αλλάζει κατά τόσο % ανάλογα με τις μεταβολές
    stableSpacer = 30; //Σταθερό μέρος του Spacer

    //Υπολογισμοί
    height = height - paddingTop;
    heightUp = impact * (height * percentTop) + stableTop * (1 - impact);
    heightSpacer = 0.3 * (height * 0.04 + (1 - 0.3) * stableSpacer);
    heightDown = height - heightUp - heightSpacer;

    heightDownFirst = 0.3 * (heightDown * 0.1) + 0.7 * 70;
    heightDownThird = 0.3 * (heightDown * 0.1) + 0.7 * 60;
    heightDownSecond = heightDown - heightDownFirst - heightDownThird;

    //UP = TRUE, Down = FALSE
    if (type == 1) {
      return heightUp;
    } else if (type == 2) {
      return heightSpacer;
    } else if (type == 3) {
      return heightDown;
    } else if (type == 31) {
      return heightDownFirst;
    } else if (type == 32) {
      return heightDownSecond;
    } else if (type == 33) {
      return heightDownThird;
    } else {
      return height + 10;
    }
  }

  Color transitionColor(Color startColor, Color endColor, double percentage) {
    int random = Random().nextInt(255);
    int random2 = Random().nextInt(255);

    int rd = endColor.red - startColor.red;
    int gd = random2 - startColor.green;
    int bd = random - startColor.blue;

    int r = (startColor.red + (rd * percentage)).toInt();
    int g = (startColor.green + (gd * percentage)).toInt();
    int b = (startColor.blue + (bd * percentage)).toInt();

    return Color.fromARGB(255, r, g, b);
  }
}
