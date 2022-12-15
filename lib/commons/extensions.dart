import 'package:flutter/material.dart';

import '../commons/helpers.dart';

extension MyWidget on Widget {
  Padding get pH16 => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: this,
  );

  Padding get pH8 => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: this,
  );
}

extension MyDouble on double {
  SizedBox get vertical => SizedBox(
    height: this,
  );
}

extension MyString on String {
  Text get textTitle => Text(
    this,
    style: Helpers.styleTitle
  );

  Text get userComment => Text(
    this,
    style: Helpers.styleTitle.copyWith(
      color: Colors.white
    )
  );

  Text get textSubTitle => Text(
    this,
    style: Helpers.styleSubTitle,
  );

  Padding get titlePost => Text(
    this,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16
    )
  ).pH16;
  
  Padding get descriptionPost => Text(
    this,
    style: const TextStyle(
      fontSize: 12
    )
  ).pH16;
}