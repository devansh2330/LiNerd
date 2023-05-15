import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:puzzler/Authentication/login_or_register.dart';
import 'package:puzzler/Dashboard/dashboard.dart';
import 'package:puzzler/game/home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Dashboard(); //user logged in
              }
              return LoginOrRegisterPage(); //user not logged in
            }));
  }
}
