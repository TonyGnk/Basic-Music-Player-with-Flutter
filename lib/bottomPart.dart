import 'package:flutter/material.dart';
import 'data.dart';
import 'list.dart';

class BottomPart extends StatefulWidget {
  final double initialHeight;
  final double initialWidth;

  BottomPart({required this.initialHeight, required this.initialWidth});

  @override
  _NewState createState() => _NewState();
}

class _NewState extends State<BottomPart> {
  double tab1 = 0;
  double tab2 = 0;
  double tab3 = 0;
  double MaxTab = 0;
  int durationMS = 300;

  @override
  void initState() {
    super.initState();

    MaxTab = widget.initialWidth;
    tab1 = widget.initialWidth;
  }

  void _updateTabs(double delta) {
    // double Cdn = 0;
    // double Cup = 0;
    // double percent = 0;

    setState(
      () {
        //To the left drag is negative and to the right drag is positive
        //print hello
        if (delta < 0) {
          print("Hello");
          tab1 = 0;
          tab2 = MaxTab;
        }
        if (delta > 0) {
          print("2");
          tab1 = MaxTab;
          tab2 = 0;
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
              width: tab1,
              color: Color.fromARGB(29, 33, 149, 243),
              child: MyApp(),
            ),
            AnimatedContainer(
              width: tab2,
              duration: Duration(milliseconds: durationMS),
              curve: Curves.easeInOut,
              color: Color.fromARGB(29, 244, 67, 54),
              child: AudioFilesScreen(),
            ),
            Container(
              width: tab3,
              color: Color.fromARGB(76, 76, 175, 79),
            ),
          ],
        ),
      ),
    );
  }
}
