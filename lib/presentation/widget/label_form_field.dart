import 'package:flutter/material.dart';

class LabelFormField extends StatelessWidget {
  const LabelFormField({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:16.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}