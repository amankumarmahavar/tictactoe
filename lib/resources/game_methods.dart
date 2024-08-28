import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/utils/utils.dart';

class GameMethods {
  void checkWinner(BuildContext context, Socket socketClient) {
    final RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);

    String winner = '';

    // Helper function to check winning conditions
    bool checkLine(int a, int b, int c) {
      if (roomDataProvider.displayElements[a] ==
              roomDataProvider.displayElements[b] &&
          roomDataProvider.displayElements[a] ==
              roomDataProvider.displayElements[c] &&
          roomDataProvider.displayElements[a] != '') {
        roomDataProvider.updateMatchIndex([a, b, c]);
        return true;
      }
      return false;
      
    }

    // Check Rows
    for (int i = 0; i < 9; i += 3) {
      if (checkLine(i, i + 1, i + 2)) {
        winner = roomDataProvider.displayElements[i];
        break;
      }
    }

    // Check Columns
    for (int i = 0; i < 3; i++) {
      if (checkLine(i, i + 3, i + 6)) {
        winner = roomDataProvider.displayElements[i];
        break;
      }
    }

    // Check Diagonals
    if (checkLine(0, 4, 8)) {
      winner = roomDataProvider.displayElements[0];
    } else if (checkLine(2, 4, 6)) {
      winner = roomDataProvider.displayElements[2];
    }
    // Handle Draw
    if (winner == '' && roomDataProvider.filledBoxes == 9) {
      showSnackBar(context, 'Match Draw ... ');
      roomDataProvider.resetBoard();
      return;
    }

    // Handle Winner
    if (winner != '') {
      String winnerSocketId = winner == roomDataProvider.player1.playerType
          ? roomDataProvider.player1.socketId
          : roomDataProvider.player2.socketId;

      if (socketClient.id != winnerSocketId) {
        socketClient.emit('winner', {
          'winnerSocketId': winnerSocketId,
          'roomId': roomDataProvider.roomData['_id'],
        });
      }

      String winnerName = winner == roomDataProvider.player1.playerType
          ? roomDataProvider.player1.nickname
          : roomDataProvider.player2.nickname;

      showSnackBar(context, '$winnerName won this round, reseting in 2 seconds');
      roomDataProvider.resetBoard();
      
    }
  }
}
