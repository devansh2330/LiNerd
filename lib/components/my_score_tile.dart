import 'package:flutter/material.dart';

class MySTile extends StatefulWidget {
  final String word;
  final String hint;
  final String direction;
  final int column;
  final int row;
  //final bool hintLeft;

  const MySTile({
    Key? key,
    required this.word,
    required this.hint,
    required this.direction,
    required this.column,
    required this.row,
    //required this.hintLeft,
  }) : super(key: key);

  @override
  State<MySTile> createState() => _MySTileState();
}

class _MySTileState extends State<MySTile> {
  @override
  Widget build(BuildContext context) {
    var icon = widget.direction == "ACROSS"
        ? const Icon(Icons.keyboard_double_arrow_right_rounded)
        : const Icon(Icons.keyboard_double_arrow_down_rounded);
    var answer = "";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[200],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: icon,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.hint,
                      overflow: TextOverflow.visible,
                      softWrap: true,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                          "Column ${widget.column + 1}, Row ${widget.row + 1}  ${widget.word}",
                          style: TextStyle(
                              fontSize: 16, color: Colors.green[600])),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
