import 'package:flutter/material.dart';

class MyFormButton extends StatelessWidget {
  const MyFormButton({super.key, required this.onPressed, required this.text});

  final Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // ignore: sized_box_for_whitespace
      child: Container(
        width: double.infinity,
        height: 50,
        child: MaterialButton(
          onPressed: onPressed,
          color: Colors.black,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20
            ),
          ),
        ),
      ),
    );
  }
}