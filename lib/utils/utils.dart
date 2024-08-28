import 'package:flutter/material.dart';
import 'package:tictactoe/resources/socket_client.dart';
import 'package:tictactoe/screens/main_menu_screen.dart';
import 'package:tictactoe/utils/colors.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
      ),
    ),
  );
}

void gameOverDialog(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Over', style: TextStyle(fontWeight: FontWeight.bold),),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.popUntil(
                      context,   
              (Route<dynamic> route) => route.settings.name == MainMenuScreen.route);
                  SocketClient.instance.socket?.disconnect();
                },
                child: Text(
                  "Play Again",
                  style: TextStyle(color: kPrimaryColor),
                ))
          ],
        );
      });
}
