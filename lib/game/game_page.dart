import 'dart:async';
import 'package:flutter/material.dart';
import 'package:puzzler/components/constants.dart';
import 'package:puzzler/components/my_gpt_tile.dart';
import 'package:puzzler/components/my_tile.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  int selectedTile = -1;
  //
  //bool _puzzleCompleted = false;
  //
  bool checked = false;
  bool validSquare = true;
  //
  late TextEditingController populate;
  //user board data
  List<List<String>> userBoard = List.generate(10, (_) => List.filled(10, ""));

  //generator board data
  List<List<String>> generatorBoard =
      List.generate(10, (_) => List.filled(10, "_"));
  //list to display hints
  final hintList = List<dynamic>.filled(0, [], growable: true);

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

  // Future<int> try_down(int i, int j, String word) async {
  //   try {
  //     if (i + words.length > 10) {
  //       return -1;
  //     }
  //     int common = 0;
  //     for (int x = 0; x < word.length; x++) {
  //       if (generatorBoard[i + x][j] != word[x] &&
  //           generatorBoard[i + x][j] != "") {
  //         return -1;
  //       }
  //       if (generatorBoard[i + x][j] == word[x] &&
  //           generatorBoard[i + x][j] != "") {
  //         common++;
  //       }
  //     }
  //     return common;
  //   } catch (e) {
  //     // print('');
  //     //print('down $word ${e}');
  //     return -1;
  //   }
  // }

  // Future<int> try_across(int i, int j, String word) async {
  //   try {
  //     if (j + words.length > 10) {
  //       return -1;
  //     }
  //     int common = 0;
  //     for (int x = 0; x < word.length; x++) {
  //       // if (generatorBoard[i][j + x] != word[x] &&
  //       //     generatorBoard[i][j + x] != "") {
  //       //   return -1;
  //       // }
  //       // if (generatorBoard[i][j + x] == word[x] &&
  //       //     generatorBoard[i][j + x] != "") {
  //       //   common++;
  //       // }
  //     }
  //     return common;
  //   } catch (e) {
  //     //print('across $word ${e.toString()}');
  //     return -1;
  //   }
  // }

  // void generate() async {
  //   for (int j = 0; j < words[0].length; j++) //for i=0
  //   {
  //     double item = (10 - words[0].length) / 2;

  //     set_square((words[0])[j], 5, item.toInt() + j);
  //     //direction[0] = "ACROSS";
  //   }
  //   int location_row = 5;
  //   double location_col = (10 - words[0].length) / 2;

  //   var item = {
  //     words[0],
  //     database[words[0]],
  //     "ACROSS",
  //     location_row,
  //     location_col.toInt()
  //   };
  //   hintList[0] = item;
  //   item.clear();

  //   int i = 0;
  //   words.removeAt(0);

  //   while (words.isNotEmpty) {
  //     int max_common = -1;
  //     int max_row = -1;
  //     int max_col = -1;
  //     i = 0;
  //     // print('length word ${words.length}');
  //     //print('i $i word: ${words[i]}\n');
  //     String max_direction = "";
  //     for (int j = 0; j < 10; j++) {
  //       for (int k = 0; k < 10; k++) {
  //         int temp = -1;

  //         // print('down started');
  //         temp = await try_down(j, k, words[i]);
  //         //print('down completed');
  //         if (temp > max_common) {
  //           max_common = temp;
  //           max_row = j;
  //           max_col = k;
  //           max_direction = "DOWN";
  //         }
  //         //print('across started');
  //         temp = await try_across(j, k, words[i]);
  //         //print('across completed');
  //         if (temp > max_common) {
  //           max_common = temp;
  //           max_row = j;
  //           max_col = k;
  //           max_direction = "ACROSS";
  //         }
  //       }
  //     }
  //     if (max_common == -1) {
  //       print('word not placed');
  //     } else if (max_direction == "ACROSS") {
  //       print('word placed across');
  //       for (int j = 0; j < words[i].length; j++) {
  //         set_square(words[i][j], max_row, max_col + j);
  //       }
  //       item = {words[i], database[words[i]], "ACROSS", max_row, max_col};
  //       print(item);
  //     } else if (max_direction == "DOWN") {
  //       print('word placed down');
  //       for (int j = 0; j < words[i].length; j++) {
  //         set_square(words[i][j], max_row + j, max_col);
  //       }
  //       item = {words[i], database[words[i]], "DOWN", max_row, max_col};
  //       print(item);
  //     } else {
  //       print('else accessed');
  //     }
  //     hintList.add(item);
  //     item.clear();
  //     words.removeAt(i);
  //   }
  //   print('generator board\n\n');
  //   print(generatorBoard);
  //   print('\n\nhintlist');
  //   print(hintList);
  // }
  int trydown(int i, int j, String word) {
    if ((i + word.length) > 10) {
      return -1;
    }
    int common = 0;
    for (int x = 0; x < word.length; x++) {
      if (generatorBoard[i + x][j] != word[x] &&
          generatorBoard[i + x][j] != "_") {
        //print('ola down');
        return -1;
      }
      if (generatorBoard[i + x][j] == word[x] &&
          generatorBoard[i + x][j] != "_") {
        common++;
      }
    }
    return common;
  }

  int tryacross(int i, int j, String word) {
    if ((j + word.length) > 10) {
      return -1;
    }
    int common = 0;
    for (int x = 0; x < word.length; x++) {
      if (generatorBoard[i][j + x] != word[x] &&
          generatorBoard[i][j + x] != "_") {
        //print('ola across');
        return -1;
      }
      if (generatorBoard[i][j + x] == word[x] &&
          generatorBoard[i][j + x] != "_") {
        common++;
      }
    }
    return common;
  }

  void generate() {
    int size = words.length;
    int rowPos;
    int colPos;
    for (int j = 0; j < words[0].length; j++) //for i=0
    {
      setsquare((words[0])[j], 5, ((10 - words[0].length) / 2).floor() + j);
    }
    rowPos = 5;
    colPos = ((10 - words[0].length) / 2).floor();

    var item = [words[0], database[words[0]], "ACROSS", rowPos, colPos];
    acrossCount++;
    hintList.add(item);
    print(hintList.elementAt(0));

    for (int i = 1; i < size; i++) {
      int maxCommon = -1;
      int maxRowPos = -1;
      int maxColPos = -1;
      String maxDirection = "";
      for (int j = 0; j < 10; j++) {
        for (int k = 0; k < 10; k++) {
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
  int score = 0;
  void scoreCalculate() {
    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 10; j++) {
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
            myDrawer,

            //
            Expanded(
              child: Column(
                children: [
                  Expanded(
                      flex: 9,
                      child: GridView.builder(
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
                                      color: generatorBoard[row][col] == "_"
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
                                        enabled: generatorBoard[row][col] == "_"
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
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.keyboard_double_arrow_right_rounded,
                                  ),
                                  Text(
                                    "0$_minute : ${_seconds.toString().padLeft(2, '0')}",
                                    //style: TextStyle(fontSize: 30),
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
                            _isRunning == true ? _stopTimer() : _startTimer();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.redAccent),
                              child: Center(
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.keyboard_double_arrow_right_rounded,
                                    ),
                                    Text(
                                      "start/stop button",
                                      //style: TextStyle(fontSize: 30),
                                    )
                                  ],
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
                                      "HARD!",
                                      style: TextStyle(fontSize: 30),
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

                        return MyGPTile(
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
