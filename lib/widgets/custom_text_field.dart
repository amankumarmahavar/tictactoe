import 'package:flutter/material.dart';
import 'package:tictactoe/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool readOnly;
  const CustomTextField(
      {super.key, required this.controller, required this.hintText, this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: xColor,
          blurRadius: 10,
          spreadRadius: 0,
        )
      ], borderRadius: BorderRadius.circular(8)),
      child: TextField(
        readOnly: readOnly,
        controller: controller,
        style: const TextStyle(color: kWhiteColor),
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            hintStyle: TextStyle(color: kWhiteColor.withOpacity(0.5)),
            hintText: hintText,
            fillColor: kPrimaryColor,
            filled: true),
      ),
    );
  }
}
