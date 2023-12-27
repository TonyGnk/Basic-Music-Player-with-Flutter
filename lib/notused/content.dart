import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 21, 71, 107),
            Color.fromARGB(255, 21, 71, 107),
          ],
          stops: [0, 0.49, 0.51, 1],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Column(
        verticalDirection: VerticalDirection.down,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    50,
                    (index) => Container(
                        height: 40,
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0),
                              width: 3.0,
                            ),
                            top: BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0),
                              width: 3.0,
                            ),
                            right: BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0),
                              width: 3.0,
                            ),
                            bottom: BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0),
                              width: 3.0,
                            ),
                          ),
                        ),
                        child: const Text("Hello World")),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
