import 'package:flutter/material.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/utils/colors.dart';
import 'package:tictactoe/widgets/buttons.dart';
import 'package:tictactoe/widgets/custom_text_field.dart';
import 'package:tictactoe/widgets/glowing_text.dart';

class JoinRoomScreen extends StatefulWidget {
  static const String route = 'joinRoom';
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final _nameController = TextEditingController();
  final _gameIdController = TextEditingController();
  late final SocketMethods _socketMethods;

  @override
  void initState() {
    super.initState();
    _socketMethods = SocketMethods();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _socketMethods.errorOccuredListener(context);
      _socketMethods.updatePlayerStateListener(context);
      _socketMethods.updateRoomListener(context);
      _socketMethods.joinRoomSuccessListener(context);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _gameIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomGlowingText(
              text: 'Join  Room',
              shadows: [
                Shadow(
                  color: kAccentColor,
                  blurRadius: 40,
                )
              ],
              fontSize: 70,
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            CustomTextField(
                controller: _nameController, hintText: 'Enter your nickname'),
            SizedBox(
              height: size.height * 0.03,
            ),
            CustomTextField(
                controller: _gameIdController, hintText: 'Enter game id'),
            SizedBox(
              height: size.height * 0.03,
            ),
            CustomButton(
                onPressed: () {
                  _socketMethods.joinRoom(_nameController.text.trim(),
                      _gameIdController.text.trim());
                },
                text: 'Join')
          ],
        ),
      ),
    );
  }
}
