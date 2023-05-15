import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:puzzler/Authentication/auth_page.dart';
import 'package:puzzler/components/constants.dart';
import 'package:puzzler/components/my_gpt_tile.dart';
import 'package:puzzler/components/my_tile.dart';
import 'package:puzzler/components/update_constants.dart';
import 'package:puzzler/game/score_display.dart';

import '../Dashboard/about.dart';

class GameModeMedium extends StatefulWidget {
  const GameModeMedium({Key? key}) : super(key: key);

  @override
  State<GameModeMedium> createState() => _GameModeMediumState();
}

class _GameModeMediumState extends State<GameModeMedium> {
  int selectedTile = -1;
  //
  //bool _puzzleCompleted = false;
  //
  bool checked = false;
  bool validSquare = true;
  //
  late TextEditingController populate;

  //list of words to be used
  List<String> words = database.keys.toList();
  //
  int error = 0;

  //counter
  int acrossCount = 0;
  int downCount = 0;
  //functionality for generation
  void setsquare(String c, int row, int col) {
    //('$row : $col');
    generatorBoard[row][col] = c;
  }

  void truncate() {}
  void hint() {
    for (int x = 0; x < 8; x++) {
      int i = Random().nextInt(8) + 1;
      int j = Random().nextInt(8) + 1;

      if (userBoard[i][j] == generatorBoard[i][j]) {
        continue;
      }
      userBoard[i][j] = generatorBoard[i][j];
      hintsUsed++;
    }
  }

  int trydown(int i, int j, String word) {
    if ((i + word.length) > 9) {
      return -1;
    }
    int common = 0;
    for (int x = 0; x < word.length; x++) {
      if (generatorBoard[i + x][j] != word[x] &&
          generatorBoard[i + x][j] != " ") {
        //print('ola down');
        return -1;
      }
      if (generatorBoard[i + x][j] == word[x] &&
          generatorBoard[i + x][j] != " ") {
        common++;
      }
    }
    return common;
  }

  int tryacross(int i, int j, String word) {
    if ((j + word.length) > 9) {
      return -1;
    }
    int common = 0;
    for (int x = 0; x < word.length; x++) {
      if (generatorBoard[i][j + x] != word[x] &&
          generatorBoard[i][j + x] != " ") {
        //print('ola across');
        return -1;
      }
      if (generatorBoard[i][j + x] == word[x] &&
          generatorBoard[i][j + x] != " ") {
        common++;
      }
    }
    return common;
  }

  void generate() {
    int size = words.length;
    int rowPos;
    int colPos;
    int rand = Random().nextInt(90);
    while (words[rand].length != 8) {
      rand = Random().nextInt(90);
    }
    print('$rand word ${words[rand]}');
    for (int j = 0; j < words[rand].length; j++) //for i=0
    {
      setsquare(
          (words[rand])[j], 5, ((10 - words[rand].length) / 2).floor() + j);
    }
    rowPos = 5;
    colPos = ((10 - words[rand].length) / 2).floor();

    var item = [words[rand], database[words[rand]], "ACROSS", rowPos, colPos];
    acrossCount++;
    hintList.add(item);
    print(hintList.elementAt(0));

    for (int i = rand + 1; i < size; i++) {
      int maxCommon = -1;
      int maxRowPos = -1;
      int maxColPos = -1;
      String maxDirection = "";
      for (int j = 1; j < 9; j++) {
        for (int k = 1; k < 9; k++) {
          int temp = -1;

          temp = trydown(j, k, words[i]);

          if (temp > maxCommon) {
            maxCommon = temp;
            maxRowPos = j;
            maxColPos = k;
            maxDirection = "DOWN";
          }
          temp = tryacross(j, k, words[i]);
          if (temp > maxCommon) {
            maxCommon = temp;
            maxRowPos = j;
            maxColPos = k;
            maxDirection = "ACROSS";
          }
          //print(maxCommon);
        }
      }
      if (maxCommon == -1) {
        print('failed to place the word ${words[i]} at pos $i');
      }

      if (maxDirection == "ACROSS") {
        for (int j = 0; j < words[i].length; j++) {
          setsquare(words[i][j], maxRowPos, maxColPos + j);
        }
        rowPos = maxRowPos;
        colPos = maxColPos;
        var item = [words[i], database[words[i]], "ACROSS", rowPos, colPos];
        hintList.add(item);
        acrossCount++;
        print('placed word ${words[i]} at $i');
      }
      if (maxDirection == "DOWN") {
        for (int j = 0; j < words[i].length; j++) {
          setsquare(words[i][j], maxRowPos + j, maxColPos);
        }
        rowPos = maxRowPos;
        colPos = maxColPos;
        var item = [words[i], database[words[i]], "DOWN", rowPos, colPos];
        hintList.add(item);
        downCount++;
        print('placed word ${words[i]} at $i');
      }
    }
    print(hintList);
    for (int i = 0; i < 10; i++) {
      print('${generatorBoard[i]} \n');
    }
  }

  //score analyser

  void scoreCalculate() {
    for (int i = 1; i < 9; i++) {
      for (int j = 1; j < 9; j++) {
        if (userBoard[i][j] == generatorBoard[i][j]) {
          score++;
        }
      }
    }
    print('Score: $score');
  }

  //timer functionality
  Timer? _timer;
  int _seconds = 0;
  int _minute = 0;
  bool _isRunning = false;

  void _startTimer() {
    generate();
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
        if (_seconds >= 60) {
          _minute++;
          _seconds = 0;
        }
      });
    });
  }

  void _stopTimer() {
    _isRunning = false;
    _timer?.cancel();
    setState(() {
      //_seconds = 0;
    });
    scoreCalculate();
    timeFinal =
        "${_minute.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')}";
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScoreDisplay(
          level: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: myAppBar,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // open drawer
            Drawer(
              backgroundColor: Colors.grey[300],
              elevation: 0,
              child: Column(
                children: [
                  const DrawerHeader(
                    child: Icon(
                      Icons.dock,
                      size: 64,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/dashboard');
                    },
                    child: Padding(
                      padding: tilePadding,
                      child: ListTile(
                        leading: const Icon(Icons.home),
                        title: Text(
                          'D A S H B O A R D',
                          style: drawerTextColor,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                    child: Padding(
                      padding: tilePadding,
                      child: ListTile(
                        leading: const Icon(Icons.settings),
                        title: Text(
                          'S E T T I N G S',
                          style: drawerTextColor,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => About(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: tilePadding,
                      child: ListTile(
                        leading: const Icon(Icons.info),
                        title: Text(
                          'A B O U T',
                          style: drawerTextColor,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AuthPage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: tilePadding,
                      child: ListTile(
                        leading: const Icon(Icons.logout),
                        title: Text(
                          'L O G O U T',
                          style: drawerTextColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //
            Expanded(
              child: Column(
                children: [
                  Expanded(
                      flex: 9,
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          //padding: const EdgeInsets.fromLTRB(500, 50, 500, 100),
                          itemCount: 100,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 10),
                          itemBuilder: (context, index) {
                            int row = index ~/ 10;
                            int col = index % 10;
                            populate = TextEditingController(
                                text: userBoard[row][col]);

                            return GestureDetector(
                                onTap: () {
                                  checked = index == selectedTile;
                                  setState(() {
                                    selectedTile = index;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: generatorBoard[row][col] == " "
                                          ? Colors.grey
                                          : Colors.blue,
                                    ),
                                    height: 4,
                                    width: 4,
                                    child: Center(
                                      child: TextField(
                                        controller: populate,
                                        textCapitalization:
                                            TextCapitalization.characters,
                                        enabled: generatorBoard[row][col] == " "
                                            ? false
                                            : true,
                                        style: const TextStyle(fontSize: 28),
                                        maxLength: 1,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          hintText: "",
                                          counterText: "",
                                        ),

                                        //controller: _alphabet_controller,
                                        onChanged: (value) {
                                          setState(() {
                                            populate.text = value.toUpperCase();
                                            userBoard[row][col] =
                                                value.toUpperCase();
                                            for (int i = 0; i < 10; i++) {
                                              print('${userBoard[i]} \n');
                                            }
                                            print('\n\n');
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ));
                          })),

                  Expanded(
                      child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[200]),
                            child: Center(
                                child: Text(
                              style: const TextStyle(
                                shadows: [
                                  Shadow(
                                    blurRadius: 5.0,
                                    color: Colors.black,
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                                fontSize: 22,
                                color: Colors.black,
                              ),
                              "${_minute.toString().padLeft(2, '0')} : ${_seconds.toString().padLeft(2, '0')}",
                              //style: TextStyle(fontSize: 30),
                            )),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _isRunning == true ? _stopTimer() : _startTimer();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.redAccent),
                              child: Center(
                                child: _isRunning == true
                                    ? const Text(
                                        style: TextStyle(
                                          shadows: [
                                            Shadow(
                                              blurRadius: 5.0,
                                              color: Colors.black,
                                              offset: Offset(2.0, 2.0),
                                            ),
                                          ],
                                          fontSize: 22,
                                          color: Colors.white,
                                        ),
                                        "Submit",
                                        //style: TextStyle(fontSize: 30),
                                      )
                                    : const Text(
                                        style: TextStyle(
                                          shadows: [
                                            Shadow(
                                              blurRadius: 5.0,
                                              color: Colors.black,
                                              offset: Offset(2.0, 2.0),
                                            ),
                                          ],
                                          fontSize: 22,
                                          color: Colors.white,
                                        ),
                                        "Start",
                                        //style: TextStyle(fontSize: 30),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
                  // list of stuff
                  // Expanded(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(8),
                  //         color: Colors.blue[200],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),

            // 3RD half of page
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  // first 4 boxes in grid
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 125,
                              width: 125,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[200]),
                              child: Center(
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.keyboard_double_arrow_right_rounded,
                                      size: 60,
                                    ),
                                    Text(
                                      "$acrossCount",
                                      style: const TextStyle(fontSize: 30),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 125,
                              width: 125,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[200]),
                              child: Center(
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.keyboard_double_arrow_down_rounded,
                                      size: 60,
                                    ),
                                    Text(
                                      " $downCount",
                                      style: const TextStyle(fontSize: 30),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              hint();
                              print('Hint used');
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 125,
                                width: 125,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey[200]),
                                child: const Center(
                                  child: Icon(
                                    Icons.tips_and_updates_rounded,
                                    size: 60,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 125,
                              width: 125,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[200]),
                              child: Center(
                                child: Column(
                                  children: const [
                                    Icon(
                                      Icons.smart_toy_rounded,
                                      size: 60,
                                    ),
                                    Text(
                                      "NOVICE",
                                      style: TextStyle(fontSize: 26),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // list of previous days
                  Expanded(
                    flex: 4,
                    child: ListView.builder(
                      itemCount: hintList.length,
                      itemBuilder: (context, index) {
                        //var hintElement = ["null", "ALL THE BEST", "!", 0, 0];
                        var hintElement = hintList[index];

                        return MyTile(
                          word: hintElement[0],
                          hint: hintElement[1],
                          direction: hintElement[2],
                          column: hintElement[3],
                          row: hintElement[hintElement.length - 1],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // second half of page
          ],
        ),
      ),
    );
  }
}
