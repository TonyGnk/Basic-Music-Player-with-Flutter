import 'package:flutter/material.dart';

class TabPart extends StatelessWidget {
  const TabPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Κομμάτια",
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 20,
        ),
      ),
    );
  }
}
