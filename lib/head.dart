import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'customIconButton.dart';

class Head extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 15),
      //color transparet
      color: Color.fromARGB(0, 0, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /*
		* Box of text
		*/
          Container(
            color: Colors.transparent, // Color of the box
            alignment: Alignment.centerLeft,
            child: Text(
              "Μουσική",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color.fromARGB(255, 76, 76, 76),
                fontSize: 20,
              ),
            ),
          ),
          /*
		* Box of Icons
		*/
          Row(children: [
            CustomIconButton(
              onPressed: () {
                // Add your onPressed logic here
              },
              icon: SvgPicture.asset('assets/search.svg'),
            ),
            /*
		* Box of Settings Icon
		*/
            CustomIconButton(
              onPressed: () {
                // Add your onPressed logic here
              },
              icon: SvgPicture.asset('assets/settings.svg'),
            ),
          ]),
        ],
      ),
    );
  }
}
