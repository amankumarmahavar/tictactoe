import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/screens/create_room_screen.dart';
import 'package:tictactoe/screens/join_room_screen.dart';
import 'package:tictactoe/widgets/buttons.dart';

class MainMenuScreen extends StatelessWidget {
  static const String route = 'MainMenuScreen';
  const MainMenuScreen({super.key});

  void createRoom(BuildContext context) {
    Provider.of<RoomDataProvider>(context, listen: false).initRoomData();
    Navigator.pushNamed(context, CreateRoomScreen.route);
  }

  void joinRoom(BuildContext context) {
    Provider.of<RoomDataProvider>(context, listen: false).initRoomData();
    Navigator.pushNamed(context, JoinRoomScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              // onPressed: ()=>  gameOverDialog(context, 'Game Over'),
              onPressed: () => createRoom(context),
              text: 'Create Room',
            ),
            SizedBox(
              height: 16,
            ),
            CustomButton(
              onPressed: () => joinRoom(context),
              text: 'Join Room',
            ),
          ],
        ),
      ),
    );
  }
}
