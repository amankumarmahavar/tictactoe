import 'package:flutter/material.dart';
import 'package:tictactoe/utils/colors.dart';

class CustomGlowingText extends StatelessWidget {
  final String text;
  final List<Shadow> shadows;
  final double fontSize;
  const CustomGlowingText(
      {super.key,
      required this.text,
      required this.shadows,
      required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize,
          height: 1,
          color: kWhiteColor,
          shadows: shadows,
          fontWeight: FontWeight.bold),
    );
  }
}
