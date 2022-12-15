import 'package:flutter/material.dart';

import '../../commons/extensions.dart';
import 'card_comment/avatar_comment.dart';

class CardComment extends StatelessWidget {
  const CardComment({super.key, required this.title, required this.subTitle, required this.userId});

  final String title;
  final String subTitle;
  final int userId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        userId != 0 
        ? AvatarComment(
            userId: userId.toString(),
          )
        : const SizedBox(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title.textTitle,
            subTitle.textSubTitle.pH8
          ],
        )
      ],
    );
  }
}