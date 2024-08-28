import 'package:flutter/foundation.dart';
import 'package:tictactoe/models/player.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};
  int _filledBoxes = 0;
  List<String> _displayElements = ['', '', '', '', '', '', '', '', ''];
  List<int> _matchIndexs = [];
  bool _inProcessing = false;
  Player _player1 =
      Player(nickname: '', socketId: '', points: 0, playerType: '');
  Player _player2 =
      Player(nickname: '', socketId: '', points: 0, playerType: '');

  void initRoomData() {
    print('initializing roomDataProvider');
    _inProcessing = false;
    _roomData = {};
    _filledBoxes = 0;
    _displayElements = ['', '', '', '', '', '', '', '', ''];
    _matchIndexs = [];
    _player1 = Player(nickname: '', socketId: '', points: 0, playerType: '');
    _player2 = Player(nickname: '', socketId: '', points: 0, playerType: '');
    notifyListeners();
  }

  Map<String, dynamic> get roomData => _roomData;
  Player get player1 => _player1;
  Player get player2 => _player2;
  List<String> get displayElements => _displayElements;
  int get filledBoxes => _filledBoxes;
  List<int> get matchIndex => _matchIndexs;
  bool get inProcessing => _inProcessing;

  void updateRoom(Map<String, dynamic> data) {
    _roomData = data;
    notifyListeners();
  }

  void updateInProcessing(bool inProcessing) {
    _inProcessing = inProcessing;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    _player1 = Player.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    _player2 = Player.fromMap(player2Data);
    notifyListeners();
  }

  void updateElements(int index, String choice) {
    _displayElements[index] = choice;
    _filledBoxes++;
    notifyListeners();
  }

  void updateMatchIndex(List<int> matchIndex) {
    _matchIndexs = matchIndex;
    notifyListeners();
  }

  void resetBoard() {
    Future.delayed(Duration(seconds: 2), () {
      for (int i = 0; i < _displayElements.length; i++) {
        _displayElements[i] = '';
      }
      _filledBoxes = 0;
      _matchIndexs.clear();
      notifyListeners();
    });
  }
}
