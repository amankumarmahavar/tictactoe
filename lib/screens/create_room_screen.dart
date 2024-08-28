import 'package:flutter/material.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/utils/colors.dart';
import 'package:tictactoe/widgets/buttons.dart';
import 'package:tictactoe/widgets/custom_text_field.dart';
import 'package:tictactoe/widgets/glowing_text.dart';

class CreateRoomScreen extends StatefulWidget {
  static const String route = 'createRoom';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final _nameController = TextEditingController();
  late final SocketMethods _socketMethods;

  @override
  void initState() {
    super.initState();
    _socketMethods = SocketMethods();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _socketMethods.errorOccuredListener(context);
      _socketMethods.updatePlayerStateListener(context);
      _socketMethods.updateRoomListener(context);
      _socketMethods.createRoomSuccessListener(context);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 22.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomGlowingText(
              text: 'Create Room',
              shadows: [
                Shadow(
                  color: xColor,
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
              height: size.height * 0.04,
            ),
            CustomButton(
                onPressed: () {
                  _socketMethods.createRoom(_nameController.text.trim());
                },
                text: 'Create')
          ],
        ),
      ),
    );
  }
}
