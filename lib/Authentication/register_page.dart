import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:puzzler/Authentication/auth_service.dart';
import 'package:puzzler/components/my_button.dart';
import 'package:puzzler/components/my_square_tile.dart';
import 'package:puzzler/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign user in method
  void signUserUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        //print('done');
      } else {
        passwordNotMatchedMessage();
      }
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    }
  }

  void wrongEmailMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Incorrect Email!'),
          );
        });
  }

  void passwordNotMatchedMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Password not Matching!'),
          );
        });
  }

  void wrongPasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Incorrect Password!'),
          );
        });
  }

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

                // logo
                const Icon(
                  Icons.lock,
                  size: 50,
                ),

                const SizedBox(height: 50),

                // welcome back, you've been missed!
                Text(
                  'Hey! Lets\'s get you started',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // email textfield
                SizedBox(
                  width: 400,
                  child: MyTextField(
                    controller: emailController,
                    hintText: 'Email Id',
                    obscureText: false,
                  ),
                ),

                const SizedBox(height: 10),

                // password textfield
                SizedBox(
                  width: 400,
                  child: MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                ),

                const SizedBox(height: 10),
                SizedBox(
                  width: 400,
                  child: MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),
                ),

                const SizedBox(height: 10),

                const SizedBox(height: 25),

                // sign in button
                MyButton(
                  text: "Sign Up",
                  onTap: signUserUp,
                ),

                const SizedBox(height: 50),

                // or continue with
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
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      //   child: Text(
                      //     'Or continue with',
                      //     style: TextStyle(color: Colors.grey[700]),
                      //   ),
                      // ),
                      // Expanded(
                      //   child: Divider(
                      //     thickness: 0.5,
                      //     color: Colors.grey[400],
                      //   ),
                      // ),
                    ],
                  ),
                ),

                //const SizedBox(height: 50),

                // google + apple sign in buttons
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     // google button
                //     SquareTile(
                //         onTap: () => AuthService().signInWithGoogle(),
                //         imagePath: 'lib/images/google.png'),

                //     // SizedBox(width: 25),

                //     // // apple button
                //     // SquareTile(imagePath: 'lib/images/apple.png')
                //   ],
                // ),

                //const SizedBox(height: 50),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
