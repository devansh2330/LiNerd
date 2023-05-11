import 'package:flutter/material.dart';

class AryanBisht extends StatefulWidget {
  const AryanBisht({super.key});

  @override
  State<AryanBisht> createState() => _AryanBishtState();
}

class _AryanBishtState extends State<AryanBisht> {
  TextEditingController populate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          child: TextField(
            // textCapitalization: TextCapitalization.characters,
            controller: populate,
            enabled: true,
            style: const TextStyle(fontSize: 28),
            maxLength: 10,
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              hintText: "",
              counterText: "",
            ),

            //controller: _alphabet_controller,
            onChanged: (value) {
              populate.text = value.toUpperCase();
            },
          ),
        ),
      ])),
    );
  }
}
