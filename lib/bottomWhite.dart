import 'package:flutter/material.dart';
import 'data.dart';
import 'head.dart';
import 'tracksList.dart';
import 'player.dart';

// ignore: must_be_immutable
class BottomWhite extends StatefulWidget {
  Player player = Player();

  BottomWhite({required this.player});

  @override
  _NewState createState() => _NewState();
}

class _NewState extends State<BottomWhite> {
  double tab1 = 0;
  double tab2 = 0;
  double tab3 = 0;
  double MaxTab = 0;
  int durationMS = 300;

  @override
  void initState() {
    super.initState();
    MaxTab = 170;
    tab1 = 170;
  }

  void _updateTabs(double delta) {
    // double Cdn = 0;
    // double Cup = 0;
    // double percent = 0;

    setState(
      () {
        //To the left drag is negative and to the right drag is positive
        //print hello

        if (delta < 10) {
          if (tab2 == MaxTab) {
            tab2 = 0;
            tab3 = MaxTab;
          } else if (tab1 == MaxTab) {
            tab1 = 0;
            tab2 = MaxTab;
          }
        }
        if (delta > -10) {
          if (tab2 == MaxTab) {
            tab1 = MaxTab;
            tab2 = 0;
          } else if (tab3 == MaxTab) {
            tab2 = MaxTab;
            tab3 = 0;
          }
        }

        // if (delta > 10 || delta < -10) {
        //   Cup = ContainerHeight1 + delta;
        //   Cdn = ContainerHeight2 - delta;

        //   if ((Cup <= ContainerHeightMax && Cdn <= ContainerHeightMax) &&
        //       (Cup >= 0 && Cdn >= 0)) {
        //     if (delta < 0) {
        //       ContainerHeight1 = 0;
        //       ContainerHeight2 = ContainerHeightMax;
        //       // ContainerHeight1 = ContainerHeight1 + delta;
        //       // ContainerHeight2 = ContainerHeight2 - delta;
        //       if (Cdn >= 2 / 10 * ContainerHeightMax) {
        //         ContainerHeight1 = 0;
        //         ContainerHeight2 = ContainerHeightMax;
        //       }
        //     }
        //     if (delta > 0) {
        //       ContainerHeight1 = ContainerHeightMax;
        //       ContainerHeight2 = 0;
        //       // ContainerHeight1 = ContainerHeight1 + delta;
        //       // ContainerHeight2 = ContainerHeight2 - delta;
        //       if (Cup >= 8 / 10 * ContainerHeightMax) {
        //         ContainerHeight1 = ContainerHeightMax;
        //         ContainerHeight2 = 0;
        //       }
        //     }
        //     //Αποθήκευσε πόσο μέρους του συνόλου ContainerHeightmax καταλαμβάνει το ContainerHeight1 σε ποσοστό
        //     percent = ContainerHeight2 / ContainerHeightMax;
        //     colorz = transitionColor(colorgray, colorblue, percent);
        //   }
        // }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        _updateTabs(details.primaryDelta!);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: durationMS),
        curve: Curves.easeInOut,
        color: Colors.transparent,
        child: Row(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: durationMS),
              curve: Curves.easeInOut,
              color: Color.fromARGB(29, 33, 149, 243),
              //child: AudioFilesScreen(playerz: widget.player),
            ),
            // AnimatedContainer(
            //   width: tab2,
            //   duration: Duration(milliseconds: durationMS),
            //   curve: Curves.easeInOut,
            //   color: Color.fromARGB(29, 244, 67, 54),
            //   child: MyApp(),
            // ),
            // Container(
            //   width: tab3,
            //   color: Color.fromARGB(76, 76, 175, 79),
            //   child: TracksTab(playerz: widget.player),
            // ),
          ],
        ),
      ),
    );
  }
}
