import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screen.dart';

void main() {
  //appbar icons to dark
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
    statusBarIconBrightness: Brightness.dark, // status bar icons' color
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height + 0;
    double width = MediaQuery.of(context).size.width + 0;
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 243, 243),
        body: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Screen(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
