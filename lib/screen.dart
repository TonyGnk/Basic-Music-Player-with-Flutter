import 'dart:math';
import 'package:flutter/material.dart';
import 'package:musicgnk/switchPart.dart';
import 'package:musicgnk/topPart.dart';
import 'package:permission_handler/permission_handler.dart';
import 'bottomPart.dart';

class Screen extends StatefulWidget {
  final double initialHeight;
  final double initialWidth;

  Screen({required this.initialHeight, required this.initialWidth});

  @override
  _NewState createState() => _NewState();
}

class _NewState extends State<Screen> {
  //Store in variable initialContainerHeight1 the height of the max height that can rich the first container. Something like double.infinity.
  double ContainerHeight1 = 330;
  double ContainerHeight2 = 0;
  double ContainerHeightMax = 0;
  double swicherHeight = 0;

  int durationMS = 300;
  // store the color Color.fromARGB(255, 21, 71, 107),
  Color colorgray = Color.fromARGB(255, 234, 234, 234);
  Color colorblue = Color.fromARGB(255, 26, 34, 62);
  Color colorz = Color.fromARGB(255, 234, 234, 234);

  @override
  void initState() {
    super.initState();
    swicherHeight = 2 / 5 * widget.initialHeight;
    ContainerHeightMax = 3 / 5 * widget.initialHeight;
    ContainerHeight1 = ContainerHeightMax;

    requestPremissions();
  }

  requestPremissions() {
    Permission.storage.request();
    // Permission.manageExternalStorage.request();
    // Permission.mediaLibrary.request();
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

  void _updateActionsVisibility(double delta) {
    double Cdn = 0;
    double Cup = 0;
    double percent = 0;

    setState(() {
      //The up drag is negative and the down drag is positive

      if (delta > 10 || delta < -10) {
        Cup = ContainerHeight1 + delta;
        Cdn = ContainerHeight2 - delta;

        if ((Cup <= ContainerHeightMax && Cdn <= ContainerHeightMax) &&
            (Cup >= 0 && Cdn >= 0)) {
          if (delta < 0) {
            ContainerHeight1 = 0;
            ContainerHeight2 = ContainerHeightMax;
            // ContainerHeight1 = ContainerHeight1 + delta;
            // ContainerHeight2 = ContainerHeight2 - delta;
            if (Cdn >= 2 / 10 * ContainerHeightMax) {
              ContainerHeight1 = 0;
              ContainerHeight2 = ContainerHeightMax;
            }
          }
          if (delta > 0) {
            ContainerHeight1 = ContainerHeightMax;
            ContainerHeight2 = 0;
            // ContainerHeight1 = ContainerHeight1 + delta;
            // ContainerHeight2 = ContainerHeight2 - delta;
            if (Cup >= 8 / 10 * ContainerHeightMax) {
              ContainerHeight1 = ContainerHeightMax;
              ContainerHeight2 = 0;
            }
          }
          //Αποθήκευσε πόσο μέρους του συνόλου ContainerHeightmax καταλαμβάνει το ContainerHeight1 σε ποσοστό
          percent = ContainerHeight2 / ContainerHeightMax;
          colorz = transitionColor(colorgray, colorblue, percent);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: durationMS),
          curve: Curves.easeInOut,
          width: double.infinity,
          height: ContainerHeight1,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
          decoration: BoxDecoration(
            color: colorz,
            border: Border.all(
              color: colorz,
              width: 0.1,
            ),
          ),
          child: topPart(),
        ),
        GestureDetector(
          onVerticalDragUpdate: (DragUpdateDetails details) {
            _updateActionsVisibility(details.primaryDelta!);
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: durationMS),
            curve: Curves.easeInOut,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            decoration: BoxDecoration(
              color: colorz,
              borderRadius: BorderRadius.circular(0),
              border: Border.all(
                color: colorz,
                width: 0,
              ),
            ),
            width: double.infinity,
            height: swicherHeight,
            child: switchPart(),
          ),
        ),
        AnimatedContainer(
          duration:
              Duration(milliseconds: durationMS), // Διάρκεια της animation
          curve: Curves.easeInOut,
          width: double.infinity,
          height: ContainerHeight2,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: colorz,
            border: Border.all(
              color: colorz,
              width: 0,
            ),
          ),
          //Create a child scrollable horizontal item
          child: BottomPart(
            initialHeight: widget.initialHeight,
            initialWidth: widget.initialWidth,
          ),
        ),
      ],
    );
  }
}
