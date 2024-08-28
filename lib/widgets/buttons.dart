import 'package:flutter/material.dart';
import 'package:tictactoe/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: xColor,
              blurRadius: 12,
            )
          ]),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            // backgroundColor: WidgetStatePropertyAll(),
            minimumSize: WidgetStatePropertyAll(
                Size(MediaQuery.of(context).size.width, 50))),
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: kSecondaryColor),
        ),
      ),
    );
  }
}
