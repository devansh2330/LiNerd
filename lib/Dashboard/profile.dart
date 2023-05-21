import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:puzzler/Dashboard/dashboard.dart';
import 'package:puzzler/components/my_button.dart';
import 'package:puzzler/components/my_textfield.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // text editing controllers
  final nameController = TextEditingController();
  final rollNumberController = TextEditingController();

  void updateCredentials(String name, String rollNumber) async {
    await FirebaseFirestore.instance.collection('user_profile_data').add({
      'Name': name,
      'Roll Number': rollNumber,
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
                  Icons.verified_user,
                  size: 50,
                ),

                const SizedBox(height: 50),

                // welcome back, you've been missed!
                Text(
                  'Hey! Let\'s know more about you',
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
                    controller: nameController,
                    hintText: 'Name',
                    obscureText: false,
                  ),
                ),

                const SizedBox(height: 10),

                // password textfield
                SizedBox(
                  width: 400,
                  child: MyTextField(
                    controller: rollNumberController,
                    hintText: 'Roll Number',
                    obscureText: false,
                  ),
                ),

                const SizedBox(height: 10),

                const SizedBox(height: 25),

                // sign in button
                MyButton(
                  text: "Submit",
                  onTap: () {
                    updateCredentials(
                      nameController.text.trim(),
                      rollNumberController.text.trim(),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dashboard(),
                      ),
                    );
                  },
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
