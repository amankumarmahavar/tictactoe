import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/resources/game_methods.dart';
import 'package:tictactoe/resources/socket_client.dart';
import 'package:tictactoe/screens/game_screen.dart';
import 'package:tictactoe/screens/waiting_lobby.dart';
import 'package:tictactoe/utils/utils.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit("createRoom", {'nickname': nickname});
    }
  }

  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on('createRoomSuccess', (roomData) {
      Navigator.of(context).pushNamed(WaitingLobby.route);
    });
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {'nickname': nickname, 'roomId': roomId});
    }
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on("joinRoomSuccess", (roomData) {
      Navigator.of(context).pushNamed(GameScreen.route);
    });
  }

  void errorOccuredListener(BuildContext context) {
    _socketClient.on("errorOccured", (message) {
      showSnackBar(context, message);
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      if (context.mounted) {
        Provider.of<RoomDataProvider>(context, listen: false).updateRoom(data);
      }
    });
  }

  void updatePlayerStateListener(BuildContext context) {
    _socketClient.on("updatePlayers", (playerData) {
      if (context.mounted) {
        Provider.of<RoomDataProvider>(context, listen: false)
            .updatePlayer1(playerData[0]);

        if (playerData.length > 1) {
          Provider.of<RoomDataProvider>(context, listen: false)
              .updatePlayer2(playerData[1]);
        }
      }
    });
  }

  void initializeGameListener(BuildContext context) {
    _socketClient.on("initializeGame", (data) {
      Navigator.of(context).pushReplacementNamed(GameScreen.route);
    });
  }

  void gridTap(
      List<String> element, int index, String roomId, BuildContext context) {
    if (element[index] == '') {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateInProcessing(true);
      _socketClient.emit("tap", {'roomId': roomId, 'index': index});
    }
  }

  void tappedListener(BuildContext context) {
    _socketClient.on("tapped", (data) {
      if (context.mounted) {
        Provider.of<RoomDataProvider>(context, listen: false)
            .updateElements(data['index'], data['choice']);
        GameMethods().checkWinner(context, _socketClient);
        Provider.of<RoomDataProvider>(context, listen: false)
            .updateInProcessing(false);
      }
    });
  }

  void endGameListener(BuildContext context) {
    _socketClient.on('endGame', (playerData) {
      if (context.mounted) {
        gameOverDialog(context, '${playerData['nickname']} won the game!');
      }
    });
  }
}
