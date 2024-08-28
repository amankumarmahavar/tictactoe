import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/resources/socket_client.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/utils/colors.dart';

class TicTacToeBoard extends StatefulWidget {
  const TicTacToeBoard({super.key});

  @override
  State<TicTacToeBoard> createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  final _socketMethods = SocketMethods();
  // final e = ['O', 'X', 'O', 'O', 'X', 'O', 'O', 'X', 'O'];
  // final matchIndex = [0, 1, 2];

  // final e = ['', '', '', '', '', '', '', '', ''];
  @override
  void initState() {
    super.initState();
    _socketMethods.tappedListener(context);
  }

  void onCellTap(List<String> elements, int index, String roomId) {
    _socketMethods.gridTap(elements, index, roomId, context);
  }

  @override
  Widget build(BuildContext context) {
    final roomDataProvider = Provider.of<RoomDataProvider>(context);
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 400, maxWidth: 400),
      child: AbsorbPointer(
        absorbing: roomDataProvider.roomData['turn']['socketId'] !=
            SocketClient.instance.socket?.id || roomDataProvider.inProcessing,
        child: GridView.builder(
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => onCellTap(roomDataProvider.displayElements, index,
                    roomDataProvider.roomData['_id']),
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: roomDataProvider.matchIndex.contains(index)
                          ? yColor
                          : const Color.fromARGB(255, 48, 78, 177),
                      // border: Border.all(
                      //   color: yColor,
                      // ),
                      boxShadow: [
                        BoxShadow(
                          color: xColor,
                          blurRadius: 1,
                        )
                      ],
                      borderRadius: BorderRadius.circular(16)),
                  child: Center(
                      child: Text(
                    roomDataProvider.displayElements[index],
                    style: TextStyle(
                        height: 1,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 75,
                        shadows: [
                          Shadow(
                            color:
                                roomDataProvider.displayElements[index] == 'X'
                                    ? xColor
                                    : yColor,
                            blurRadius: 12,
                            // offset: Offset(0.5, 0.5),
                          )
                        ]),
                  )),
                ),
              );
            }),
      ),
    );
  }
}
