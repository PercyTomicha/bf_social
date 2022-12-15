import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../commons/helpers.dart';

class MyFormField extends StatelessWidget {
  const MyFormField({super.key, required this.controller, required this.keyboardType, this.inputFormatters, required this.hintText, required this.validator});

  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String hintText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: Helpers.inputDecoration.copyWith(
          hintText: hintText
        ),
        validator: validator,
      ),
    );
  }
}