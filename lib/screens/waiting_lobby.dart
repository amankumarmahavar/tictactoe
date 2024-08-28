import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/utils/colors.dart';
import 'package:tictactoe/utils/utils.dart';
import 'package:tictactoe/widgets/custom_text_field.dart';
import 'package:tictactoe/widgets/glowing_text.dart';

class WaitingLobby extends StatefulWidget {
  const WaitingLobby({super.key});
  static const String route = "waitingLobby";

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  late final SocketMethods _socketMethods;
  late final TextEditingController _textEditingController;



  @override
  void initState() {
    super.initState();
    _socketMethods = SocketMethods();
    final roomId =
        Provider.of<RoomDataProvider>(context, listen: false).roomData['_id'];
    _textEditingController = TextEditingController(text: roomId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _socketMethods.updatePlayerStateListener(context);
      _socketMethods.updateRoomListener(context);
      _socketMethods.initializeGameListener(context);
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomGlowingText(
                    text: 'Waiting  . . .',
                    shadows: [
                      Shadow(
                        color: kAccentColor,
                        blurRadius: 40,
                      )
                    ],
                    fontSize: 40),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "The game will start when someone joins in",
                  style: TextStyle(color: kWhiteColor),
                ),
                SizedBox(
                  height: 48,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      controller: _textEditingController,
                      hintText: '',
                      readOnly: true,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Clipboard.setData(
                            ClipboardData(text: _textEditingController.text));
                        showSnackBar(context, "Coppied");
                      },
                      label: Text(
                        'Copy Room ID',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      icon: Icon(
                        Icons.copy_outlined,
                        color: kWhiteColor,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
