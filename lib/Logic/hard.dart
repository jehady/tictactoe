import 'dart:math';

import 'package:flutter/material.dart';

class wComputerh extends StatefulWidget {
  const wComputerh({super.key});

  @override
  State<wComputerh> createState() => _wComputerState();
}

class _wComputerState extends State<wComputerh> {
  List<List<String>> _board = List.generate(3, (_) => List.filled(3, ''));
  String _currentPlayer = 'X';
  String _winner = '';
  late int _MODE = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Row(
              children: [
                // Buttons for selecting game modes...
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              '$_currentPlayer\'s Turn',
              style: TextStyle(
                color: _currentPlayer == 'X' ? Colors.red : Colors.green,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.8,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    return TextButton(
                      onPressed: () {
                        setState(() {
                          _removeExtraSymbol();
                          _playerMove(index);
                        });
                      },
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                        ),
                        child: Center(
                          child: Text(
                            _board[index ~/ 3][index % 3],
                            style: TextStyle(
                              fontSize: 40,
                              color: _board[index ~/ 3][index % 3] == 'X'
                                  ? Colors.red
                                  : _board[index ~/ 3][index % 3] == 'O'
                                      ? Colors.green
                                      : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 9,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: _resetGame,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(273),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.green,
                    Colors.black,
                    Colors.red,
                  ],
                ),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Center(
                  child: Text(
                    'RELOAD',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _playerMove(int index) {
    if (_board[index ~/ 3][index % 3].isEmpty && _winner.isEmpty) {
      setState(() {
        _board[index ~/ 3][index % 3] = _currentPlayer;
        _checkWinner(context);
        _currentPlayer = 'O'; // Computer's turn after player move
        _computerMove();
        _removeExtraSymbol(); // Call _removeExtraSymbol after player move
      });
    }
  }

  void _computerMove() {
    if (_winner.isEmpty) {
      // Check for potential winning moves
      if (!_checkPotentialWinMove('O')) {
        // Check for potential blocking moves
        if (!_checkPotentialWinMove('X')) {
          // If no winning or blocking moves, make a random move
          _makeRandomMove();
          _removeExtraSymbol();
        }
      }
    }
  }

  bool _checkPotentialWinMove(String symbol) {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (_board[i].where((cell) => cell == symbol).length == 2 &&
          _board[i].contains('')) {
        int colIndex = _board[i].indexOf('');
        setState(() {
          _board[i][colIndex] = 'O';
          _checkWinner(context);
          _currentPlayer = 'X'; // Player's turn after computer move
        });
        return true;
      }
    }
    // Check columns
    for (int i = 0; i < 3; i++) {
      List<String> column = [_board[0][i], _board[1][i], _board[2][i]];
      if (column.where((cell) => cell == symbol).length == 2 &&
          column.contains('')) {
        int rowIndex = column.indexOf('');
        setState(() {
          _board[rowIndex][i] = 'O';
          _checkWinner(context);
          _currentPlayer = 'X'; // Player's turn after computer move
        });
        return true;
      }
    }
    // Check diagonals
    if ((_board[0][0] == symbol &&
            _board[1][1] == symbol &&
            _board[2][2] == '') ||
        (_board[0][2] == symbol &&
            _board[1][1] == symbol &&
            _board[2][0] == '') ||
        (_board[0][0] == '' &&
            _board[1][1] == symbol &&
            _board[2][2] == symbol) ||
        (_board[0][2] == '' &&
            _board[1][1] == symbol &&
            _board[2][0] == symbol)) {
      int rowIndex, colIndex;
      if (_board[0][0] == '' &&
          _board[1][1] == symbol &&
          _board[2][2] == symbol) {
        rowIndex = 0;
        colIndex = 0;
      } else if (_board[0][2] == '' &&
          _board[1][1] == symbol &&
          _board[2][0] == symbol) {
        rowIndex = 0;
        colIndex = 2;
      } else if (_board[0][0] == symbol &&
          _board[1][1] == symbol &&
          _board[2][2] == '') {
        rowIndex = 2;
        colIndex = 2;
      } else {
        rowIndex = 2;
        colIndex = 0;
      }
      setState(() {
        _board[rowIndex][colIndex] = 'O';
        _checkWinner(context);
        _removeExtraSymbol();
        _currentPlayer = 'X'; // Player's turn after computer move
      });
      return true;
    }
    return false;
  }

  void _makeRandomMove() {
    // Find available empty cells
    List<int> emptyCells = [];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_board[i][j].isEmpty) {
          emptyCells.add(i * 3 + j);
        }
      }
    }
    // Select a random empty cell for the computer's move
    if (emptyCells.isNotEmpty) {
      int randomIndex = Random().nextInt(emptyCells.length);
      int rowIndex = emptyCells[randomIndex] ~/ 3;
      int colIndex = emptyCells[randomIndex] % 3;
      setState(() {
        _board[rowIndex][colIndex] = 'O';
        _checkWinner(context);
        _currentPlayer = 'X'; // Player's turn after computer move
      });
    }
  }

  void _removeExtraSymbol() {
    int xCount = 0;
    int oCount = 0;

    // Count X's and O's on the board
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_board[i][j] == 'X') {
          xCount++;
        } else if (_board[i][j] == 'O') {
          oCount++;
        }
      }
    }

    // Check if count of X's or O's exceeds the mode and no winner yet
    if ((xCount >= _MODE || oCount >= _MODE) && _winner.isEmpty) {
      // Collect the indices of cells with the symbol to remove
      List<int> indicesToRemove = [];
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (_board[i][j] == 'X' || _board[i][j] == 'O') {
            indicesToRemove.add(i * 3 + j);
          }
        }
      }

      // Remove symbols until the count is within the mode limit
      while (xCount > _MODE || oCount > _MODE) {
        int randomIndex = Random().nextInt(indicesToRemove.length);
        int rowIndex = indicesToRemove[randomIndex] ~/ 3;
        int colIndex = indicesToRemove[randomIndex] % 3;

        if (_board[rowIndex][colIndex] == 'X') {
          xCount--;
        } else {
          oCount--;
        }

        setState(() {
          _board[rowIndex][colIndex] = '';
        });
      }
    }
  }

  void _resetGame() {
    setState(() {
      _board = List.generate(3, (_) => List.filled(3, ''));
      _currentPlayer = 'X';
      _winner = '';
    });
  }

  void _checkWinner(BuildContext context) {
    _winner = ''; // Clear winner

    // Check rows, columns, and diagonals for winner
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (_board[i][0] != '' &&
          _board[i][0] == _board[i][1] &&
          _board[i][1] == _board[i][2]) {
        _winner = _board[i][0];
      }
    }
    // Check columns
    for (int i = 0; i < 3; i++) {
      if (_board[0][i] != '' &&
          _board[0][i] == _board[1][i] &&
          _board[1][i] == _board[2][i]) {
        _winner = _board[0][i];
      }
    }
    // Check diagonals
    if (_board[0][0] != '' &&
        _board[0][0] == _board[1][1] &&
        _board[1][1] == _board[2][2]) {
      _winner = _board[0][0];
    }
    if (_board[0][2] != '' &&
        _board[0][2] == _board[1][1] &&
        _board[1][1] == _board[2][0]) {
      _winner = _board[0][2];
    }
    // Check for draw
    if (!_board.any((row) => row.any((cell) => cell.isEmpty)) &&
        _winner.isEmpty) {
      _winner = 'Draw';
    }

    // Show the winner or draw dialog if there's a winner or draw
    if (_winner.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Game Over'),
            content:
                Text(_winner == 'Draw' ? 'It\'s a Draw!' : 'Winner: $_winner'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }
}
