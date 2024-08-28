import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/utils/colors.dart';
import 'package:tictactoe/views/score_board.dart';
import 'package:tictactoe/views/tictactoe_board.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});
  static const String route = 'gameScreen';

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final SocketMethods _socketMethods ;

  @override
  void initState() {
    super.initState();
    _socketMethods = SocketMethods();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _socketMethods.updatePlayerStateListener(context);
      _socketMethods.updateRoomListener(context);
      _socketMethods.endGameListener(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                // 'Aman\'s turn',
                '${roomDataProvider.roomData['turn']['nickname']}\'s turn',
                style: TextStyle(
                    color: kWhiteColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
              // SizedBox(
              //   height: 12,
              // ),
              const Scoreboard(),
              SizedBox(
                height: 20,
              ),
              const TicTacToeBoard(),
              SizedBox(
                height: 30,
              ),
              //   Container(
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         color: kAccentColor),
              //     child: TextButton.icon(
              //       onPressed: () {
              //         roomDataProvider.resetBoard();
              //       },
              //       label: Text(
              //         'Reset Board',
              //         style: TextStyle(color: Colors.white, fontSize: 16),
              //       ),
              //       icon: Icon(
              //         Icons.restart_alt_outlined,
              //         color: kWhiteColor,
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
