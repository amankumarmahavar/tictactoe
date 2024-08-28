# Multiplayer Tic-Tac-Toe Game

## Overview
Welcome to the Multiplayer Tic-Tac-Toe Game! 🎮 This game is designed to be completely responsive and works seamlessly across Android, iOS, Web, and Desktop platforms. Enjoy a classic game of Tic-Tac-Toe with friends in real-time, featuring a vibrant and glow-themed UI!

## Features
- **Create/Join Room**: Effortlessly create or join a game room.
- **Real-Time Gameplay**: Play in real-time with friends or other players.
- **Points Display**: Keep track of points scored by each player.
- **Round & Game Winner**: View winners of each round and the overall game.
- **Responsive Glow-Themed UI**: Enjoy a visually appealing, glow-themed user interface.
- **Cross-Platform Support**: Play on Android, iOS, Web, and Desktop.

## Installation

### Install Dependencies
To get started, install the necessary dependencies with:
```bash
flutter pub get
```

### Server Configuration
Ensure the server is up and running by visiting: [TicTacToe Server](https://tictactoe-server-gdrz.onrender.com)

### Configuration

#### For macOS
Navigate to `macos/Runner` and ensure the following keys are present in `DebugProfile.entitlements` and `Release.entitlements`:
```xml
<key>com.apple.security.network.server</key>
<true/>
<key>com.apple.security.network.client</key>
<true/>
```

#### For Android
Configure Internet permissions by adding the following line to the `AndroidManifest.xml` file located in `android/app/src/main/`:
```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

## Run the App
Launch the app on your desired device with:
```bash
flutter run --release
```

## Tech Stack
- **Server**: Node.js, Express, Socket.io, Mongoose, MongoDB
- **Client**: Flutter, Provider

## Credits
This app was inspired by the tutorial made by [RivaanRanawat](https://github.com/RivaanRanawat). Special thanks to their [YouTube tutorial](https://www.youtube.com/RivaanRanawat) for the guidance and resources.

## Feedback
We’d love to hear from you! For any feedback or questions, please reach out:
- Email: [amankumarmahavar@gmail.com](mailto:amankumarmahavar@gmail.com)

Enjoy playing Tic-Tac-Toe! 🕹️