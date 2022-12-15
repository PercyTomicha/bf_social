import 'package:flutter/material.dart';

class ButtonAction extends StatelessWidget {
  const ButtonAction({super.key, required this.onPressed, required this.icon, required this.color, required this.text});

  final Function()? onPressed;
  final Color color;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton.icon(
        onPressed: onPressed,
        label: Icon(
          icon,
          color: color
        ),
        icon: Text(
          text,
          style: TextStyle(
            color: color
          )
        ),
      ),
    );
  }
}