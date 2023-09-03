import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TabPart extends StatefulWidget {
  @override
  _NewState createState() => _NewState();
}

class _NewState extends State<TabPart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Όλα τα τραγούδια",
        style: TextStyle(
          color: const Color.fromARGB(255, 76, 76, 76),
          fontSize: 20,
        ),
      ),
    );
  }
}
