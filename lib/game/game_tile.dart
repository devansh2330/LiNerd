import 'package:flutter/material.dart';

class Gametile extends StatelessWidget {
  const Gametile({super.key});

  @override
  Widget build(BuildContext context) {
    var _alphabet_controller;
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
        ),
        height: 4,
        width: 4,
        child: Center(
          child: TextField(
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 28),
            maxLength: 1,
            decoration: const InputDecoration(hintText: "", counterText: ""),
            //controller: _alphabet_controller,
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
