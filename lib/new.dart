import 'dart:math';

import 'package:flutter/material.dart';
import 'actions.dart';

class idea extends StatefulWidget {
  final double initialHeight;

  idea({required this.initialHeight});

  @override
  _NewState createState() => _NewState();
}

class _NewState extends State<idea> {
  bool _isActionsVisible = false;
  //Store in variable initialContainerHeight1 the height of the max height that can rich the first container. Something like double.infinity.
  double ContainerHeight1 = 330;
  double ContainerHeight2 = 0;
  double ContainerHeightMax = 0;
  double swicherHeight = 0;
  // store the color Color.fromARGB(255, 21, 71, 107),
  Color colorgray = Color.fromARGB(255, 234, 234, 234);
  Color colorblue = Color.fromARGB(255, 21, 71, 107);
  Color colorz = Color.fromARGB(255, 234, 234, 234);

  @override
  void initState() {
    super.initState();
    swicherHeight = 2 / 5 * widget.initialHeight;
    ContainerHeightMax = 3 / 5 * widget.initialHeight;
    ContainerHeight1 = ContainerHeightMax;
    //print initialContainerHeightMax
    print(ContainerHeightMax);
  }

  Color transitionColor(Color startColor, Color endColor, double percentage) {
    int rd = endColor.red - startColor.red;
    int gd = endColor.green - startColor.green;
    int bd = endColor.blue - startColor.blue;

    int r = (startColor.red + (rd * percentage)).toInt();
    int g = (startColor.green + (gd * percentage)).toInt();
    int b = (startColor.blue + (bd * percentage)).toInt();

    return Color.fromARGB(255, r, g, b);
  }

  void _updateActionsVisibility(double delta, bool isup) {
    double Cdn = 0;
    double Cup = 0;
    double percent = 0;

    setState(() {
      //The up drag is negative and the down drag is positive

      Cup = ContainerHeight1 + delta;
      Cdn = ContainerHeight2 - delta;

      if ((Cup <= ContainerHeightMax && Cdn <= ContainerHeightMax) &&
          (Cup >= 0 && Cdn >= 0)) {
        if (delta < 0) {
          // ContainerHeight1 = 0;
          // ContainerHeight2 = ContainerHeightMax;
          ContainerHeight1 = ContainerHeight1 + delta;
          ContainerHeight2 = ContainerHeight2 - delta;
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300), // Διάρκεια της animation
          curve: Curves.easeInOut,
          width: double.infinity,
          height: ContainerHeight1,
          color: colorz,
        ),
        GestureDetector(
          onVerticalDragUpdate: (DragUpdateDetails details) {
            _updateActionsVisibility(details.primaryDelta!, true);
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300), // Διάρκεια της animation
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: colorz,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
              ),
            ),
            width: double.infinity,
            height: swicherHeight,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300), // Διάρκεια της animation
          curve: Curves.easeInOut,
          width: double.infinity,
          height: ContainerHeight2,
          color: colorz,
        ),
      ],
    );
  }
}
