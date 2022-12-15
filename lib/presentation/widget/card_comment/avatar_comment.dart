import 'package:flutter/material.dart';

import '../../../commons/extensions.dart';

class AvatarComment extends StatelessWidget {
  const AvatarComment({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black
        ),
        child: Center(
          // ignore: sized_box_for_whitespace
          child: Container(
            width: 15,
            height: 15,
            child: userId=='0'
              ? const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              )
              : FittedBox(child: userId.userComment)
          ),
        ),
      ),
    );
  }
}