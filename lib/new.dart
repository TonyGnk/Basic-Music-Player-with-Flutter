import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'customIconButton.dart';
import 'head.dart';

class idea extends StatefulWidget {
  final double initialHeight;
  final double initialWidth;

  idea({required this.initialHeight, required this.initialWidth});

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

  double tab1 = 0;
  double tab2 = 0;
  double tab3 = 0;
  double MaxTab = 0;

  int durationMS = 2200;
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

    MaxTab = widget.initialWidth;
    tab1 = widget.initialWidth;

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

  void _updateActionsVisibility(double delta, bool isup) {
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

  void _updateTabs(double delta) {
    double Cdn = 0;
    double Cup = 0;
    double percent = 0;

    setState(() {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildUp(),
        GestureDetector(
          onVerticalDragUpdate: (DragUpdateDetails details) {
            _updateActionsVisibility(details.primaryDelta!, true);
          },
          child: _buildSwitcher(),
        ),
        _buildDown(),
      ],
    );
  }

  Widget _buildUp() {
    return AnimatedContainer(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Switch Music",
                style: TextStyle(
                  color: const Color.fromARGB(255, 76, 76, 76),
                  fontSize: 20,
                ),
              ),
              Expanded(
                child: Container(
                  width: 150,
                  height: 40,
                  alignment: Alignment.centerRight,
                  child: CustomIconButton(
                    onPressed: () {
                      AppSettings.openAppSettings();
                    },
                    icon: SvgPicture.asset('assets/info.svg'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSwitcher() {
    return AnimatedContainer(
      duration: Duration(milliseconds: durationMS), // Διάρκεια της animation
      curve: Curves.easeInOut,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      decoration: BoxDecoration(
        color: colorz,
        borderRadius: BorderRadius.circular(0),
        //Make transparent the color of the border
        border: Border.all(
          color: colorz,
          width: 0,
        ),
      ),
      width: double.infinity,
      height: swicherHeight,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Widget _buildDown() {
    return AnimatedContainer(
      duration: Duration(milliseconds: durationMS), // Διάρκεια της animation
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
      child: GestureDetector(
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
                child: tracksTab(),
              ),
              AnimatedContainer(
                width: tab2,
                duration: Duration(milliseconds: durationMS),
                curve: Curves.easeInOut,
                color: Color.fromARGB(29, 244, 67, 54),
              ),
              Container(
                width: tab3,
                color: Color.fromARGB(76, 76, 175, 79),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
