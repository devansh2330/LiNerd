import 'package:flutter/material.dart';

class CrosswordPuzzle extends StatefulWidget {
  const CrosswordPuzzle({Key? key}) : super(key: key);

  @override
  _CrosswordPuzzleState createState() => _CrosswordPuzzleState();
}

class _CrosswordPuzzleState extends State<CrosswordPuzzle> {
  // The current selected tile
  int _selectedTile = -1;

  // The user's answers
  Map<int, String> _userAnswers = {};

  // The correct answers
  Map<int, String> _correctAnswers = {
    0: 'puzzle',
    1: 'game',
    2: 'fun',
    7: 'puzzling',
    14: 'gaming',
    21: 'funner',
  };

  // Whether the user has completed the puzzle
  bool _puzzleCompleted = false;

  // Check the user's answers
  void _checkAnswers() {
    bool allCorrect = true;
    _correctAnswers.forEach((index, answer) {
      if (_userAnswers[index]?.toLowerCase() != answer.toLowerCase()) {
        allCorrect = false;
      }
    });
    setState(() {
      _puzzleCompleted = allCorrect;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crossword Puzzle'),
      ),
      body: Column(
        children: <Widget>[
          // Game board
          Expanded(
            child: GridView.count(
              crossAxisCount: 7,
              children: List.generate(49, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTile = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: _selectedTile == index ? Colors.yellow : null,
                    ),
                    child: Center(
                      child: Text(
                        _userAnswers[index] ?? '',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          // Clues
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Across',
                        style: TextStyle(fontSize: 20),
                      ),
                      const Divider(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTile = -1;
                          });
                        },
                        child: Text(
                          '1. Puzzle',
                          style: TextStyle(
                            fontSize: 16,
                            color: _selectedTile == 0 ? Colors.yellow : null,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTile = -1;
                          });
                        },
                        child: Text(
                          '2. Game',
                          style: TextStyle(
                            fontSize: 16,
                            color: _selectedTile == 1 ? Colors.yellow : null,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTile = -1;
                          });
                        },
                        child: Text(
                          '3. Fun',
                          style: TextStyle(
                            fontSize: 16,
                            color: _selectedTile == 2 ? Colors.yellow : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      const Text('Down', style: TextStyle(fontSize: 20)),
                      const Divider(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTile = -1;
                          });
                        },
                        child: Text(
                          '1. Puzzling',
                          style: TextStyle(
                            fontSize: 16,
                            color: _selectedTile == 7 ? Colors.yellow : null,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTile = -1;
                          });
                        },
                        child: Text(
                          '2. Gaming',
                          style: TextStyle(
                            fontSize: 16,
                            color: _selectedTile == 14 ? Colors.yellow : null,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTile = -1;
                          });
                        },
                        child: Text(
                          '3. Funner',
                          style: TextStyle(
                            fontSize: 16,
                            color: _selectedTile == 21 ? Colors.yellow : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Submit button
          ElevatedButton(
            onPressed: _puzzleCompleted ? null : _checkAnswers,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
