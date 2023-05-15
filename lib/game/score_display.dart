import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:puzzler/Dashboard/about.dart';
import 'package:puzzler/components/constants.dart';
import 'package:puzzler/components/my_gpt_tile.dart';
import 'package:puzzler/components/my_score_tile.dart';
import 'package:puzzler/components/update_constants.dart';

import '../Authentication/auth_page.dart';

class ScoreDisplay extends StatefulWidget {
  final int level;

  ScoreDisplay({
    Key? key,
    required this.level,
  }) : super(key: key);

  @override
  State<ScoreDisplay> createState() => _ScoreDisplayState();
}

class _ScoreDisplayState extends State<ScoreDisplay> {
  int selectedTile = -1;
  //
  //bool _puzzleCompleted = false;
  //
  bool checked = false;
  bool validSquare = true;
  var levelName = ["EASY", "MEDIUM", "HARD"];
  var levelScore = [36, 64, 100];
  //
  late TextEditingController populate;

  //counter
  int acrossCount = 0;
  int downCount = 0;
  //functionality for generation

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
                          //padding: const EdgeInsets.fromLTRB(500, 50, 500, 100),
                          itemCount: 100,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 10),
                          itemBuilder: (context, index) {
                            int row = index ~/ 10;
                            int col = index % 10;
                            populate = TextEditingController(
                                text: generatorBoard[row][col]);

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
                                      color: generatorBoard[row][col] !=
                                              userBoard[row][col]
                                          ? Colors.red
                                          : Colors.green,
                                    ),
                                    height: 4,
                                    width: 4,
                                    child: Center(
                                      child: TextField(
                                        controller: populate,
                                        textCapitalization:
                                            TextCapitalization.characters,
                                        enabled: false,
                                        style: const TextStyle(fontSize: 28),
                                        maxLength: 1,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          hintText: "",
                                          counterText: "",
                                        ),

                                        //controller: _alphabet_controller,
                                      ),
                                    ),
                                  ),
                                ));
                          })),

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
                                      Icons.scoreboard,
                                      size: 60,
                                    ),
                                    Text(
                                      "$score/${levelScore[widget.level]}",
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
                                      Icons.timer,
                                      size: 60,
                                    ),
                                    Text(
                                      " $timeFinal",
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
                                child: Center(
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.tips_and_updates_rounded,
                                        size: 60,
                                      ),
                                      SizedBox(
                                        width: 125,
                                        child: Center(
                                          child: Text(
                                            "$hintsUsed Hints used!",
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      )
                                    ],
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
                                  children: [
                                    const Icon(
                                      Icons.smart_toy_rounded,
                                      size: 60,
                                    ),
                                    Text(
                                      "${levelName[widget.level]}",
                                      style: const TextStyle(fontSize: 30),
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

                        return MySTile(
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
