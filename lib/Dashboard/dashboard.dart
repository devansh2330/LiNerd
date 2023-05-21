import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:puzzler/Authentication/auth_page.dart';
import 'package:puzzler/Dashboard/about.dart';
import 'package:puzzler/Dashboard/profile.dart';
import 'package:puzzler/components/my_button.dart';
import 'package:puzzler/components/my_level_button.dart';
import 'package:puzzler/components/update_constants.dart';
import 'package:puzzler/game/game_page.dart';
import 'package:puzzler/game/game_page_easy.dart';
import 'package:puzzler/game/game_page_med.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  int level = 0;

  // sign user in method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                //myDrawer,
                // logo
                const Icon(
                  Icons.dashboard,
                  size: 100,
                ),

                const SizedBox(height: 50),

                // welcome back, you've been missed!
                Text(
                  '',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                const SizedBox(height: 25),

                Column(
                  children: [
                    MyButton(
                      onTap: () {
                        userBoard =
                            List.generate(10, (_) => List.filled(10, ""));
                        generatorBoard =
                            List.generate(10, (_) => List.filled(10, " "));
                        score = 0;
                        hintsUsed = 0;
                        timeFinal = "";
                        wordhintused = 0;
                        hintList.clear();
                        if (level == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GameModeEasy(),
                            ),
                          );
                        } else if (level == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GameModeMedium(),
                            ),
                          );
                        } else if (level == 2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DesktopScaffold(),
                            ),
                          );
                        }
                      },
                      text: "Start",
                    ),
                    const SizedBox(height: 25),
                    IncrementDecrementButton(
                      onDecrement: () {
                        setState(() {
                          if (level > 0) {
                            level--;
                          } else {
                            level = 2;
                          }
                        });
                        print('$level');
                      },
                      onIncrement: () {
                        setState(() {
                          if (level < 2) {
                            level++;
                          } else {
                            level = 0;
                          }
                        });
                        print('$level');
                      },
                    ),
                    const SizedBox(height: 25),
                    MyButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Profile(),
                          ),
                        );
                      },
                      text: "Profile",
                    ),
                    const SizedBox(height: 25),
                    MyButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Profile(),
                          ),
                        );
                      },
                      text: "Scoreboard",
                    ),
                    const SizedBox(height: 25),
                    MyButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => About(),
                          ),
                        );
                      },
                      text: "About",
                    ),
                    const SizedBox(height: 25),
                    MyButton(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AuthPage(),
                          ),
                        );
                      },
                      text: "Logout",
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                const SizedBox(height: 50),

                //or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // google + apple sign in buttons
              ],
            ),
          ),
        ),
      ),
    );
  }
}
