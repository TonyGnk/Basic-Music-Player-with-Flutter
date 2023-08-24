import 'package:flutter/material.dart';
import 'actions.dart';

class Fab extends StatefulWidget {
  @override
  _FabState createState() => _FabState();
}

class _FabState extends State<Fab> {
  bool _isActionsVisible = false;
  double initialContainerHeight = 0;

  void _openActionsVisibility() {
    setState(() {
      _isActionsVisible = true;
    });
  }

  void _closeActionsVisibility() {
    setState(() {
      _isActionsVisible = false;
    });
  }

  void _updateActionsVisibility(double delta, bool isup) {
    double a = 0;
    setState(() {
      //Setting if isup is true then initialContainerHeight = initialContainerHeight - delta;
      a = initialContainerHeight - 2 * delta;
      if (a < 370 && a > 0) {
        initialContainerHeight = initialContainerHeight - 2 * delta;
      } else if (a >= 370) {
        initialContainerHeight = 370;
      } else if (a <= 0) {
        initialContainerHeight = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 21, 71, 107),
      ),
      //padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 21, 71, 107),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onVerticalDragUpdate: (DragUpdateDetails details) {
                    if (details.primaryDelta! < 0) {
                      _updateActionsVisibility(details.primaryDelta!, true);
                    } else if (details.primaryDelta! > 0) {
                      _updateActionsVisibility(details.primaryDelta!, false);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    color: Color.fromARGB(0, 116, 54, 158),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start, //Set to TOP
                      children: [
                        Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 240, 240, 240),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(110),
                              bottomRight: Radius.circular(110),
                              topLeft: Radius.circular(110),
                              topRight: Radius.circular(110),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 0),
            child: Container(
              width: double.infinity,
              height: initialContainerHeight,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 21, 71, 107),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Child views.
                ],
              ),
            ),
          ),
        ],
      ),
      //This i a container
    );
  }
}
