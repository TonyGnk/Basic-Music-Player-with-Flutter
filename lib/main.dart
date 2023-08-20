import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SVG Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SVG Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //
            SvgPicture.asset(
              'assets/fab_icon.svg', // Το μονοπάτι προς το SVG αρχείο
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'SVG Icon Example',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
