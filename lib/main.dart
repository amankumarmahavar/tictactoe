import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/screens/create_room_screen.dart';
import 'package:tictactoe/screens/game_screen.dart';
import 'package:tictactoe/screens/join_room_screen.dart';
import 'package:tictactoe/screens/main_menu_screen.dart';
import 'package:tictactoe/screens/waiting_lobby.dart';
import 'package:tictactoe/utils/colors.dart';

// var logger = Logger(

//   printer: PrettyPrinter(methodCount: 0,noBoxingByDefault: false,printEmojis: false, excludeBox: {Level.debug: true}, colors: true,levelColors: {Level.debug: AnsiColor.fg(2)}),
// );

// void demo() {
//   logger.d('Just a message');
// }

void main() {
  // demo();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: GoogleFonts.karlaTextTheme(),
            // fontFamily: 'dongle',
            scaffoldBackgroundColor: kPrimaryColor,
            useMaterial3: true),
        routes: {
          MainMenuScreen.route: (_) => const MainMenuScreen(),
          CreateRoomScreen.route: (_) => const CreateRoomScreen(),
          JoinRoomScreen.route: (_) => const JoinRoomScreen(),
          WaitingLobby.route: (_) => const WaitingLobby(),
          GameScreen.route: (_) => const GameScreen(),
        },
        initialRoute: MainMenuScreen.route,
      ),
    );
  }
}
