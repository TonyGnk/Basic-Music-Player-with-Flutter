import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TopBar extends StatefulWidget {
  @override
  _NewState createState() => _NewState();
}

class _NewState extends State<TopBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Μουσική",
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 20,
        ),
      ),
    );
  }
}


// Expanded(
//               child: Container(
//                 width: 150,
//                 height: 40,
//                 alignment: Alignment.centerRight,
//                 child: CustomIconButton(
//                   onPressed: () {
//                     AppSettings.openAppSettings();
//                   },
//                   icon: SvgPicture.asset('assets/info.svg'),
//                 ),
//               ),