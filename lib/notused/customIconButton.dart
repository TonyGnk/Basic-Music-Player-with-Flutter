import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;

  CustomIconButton({required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      child: Material(
        shape: CircleBorder(),
        color: Colors.transparent,
        child: IconButton(
          onPressed: onPressed,
          icon: icon,
          splashRadius: 18, // Adjust the splash radius as needed
        ),
      ),
    );
  }
}
