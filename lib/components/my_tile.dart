import 'package:flutter/material.dart';

class MyTile extends StatelessWidget {
  final String hint;
  final String direction;
  final int column;
  final int row;
  const MyTile(
      {Key? key,
      required this.hint,
      required this.direction,
      required this.column,
      required this.row})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var icon = direction == "ACROSS"
        ? const Icon(
            Icons.keyboard_double_arrow_right_rounded,
          )
        : const Icon(
            Icons.keyboard_double_arrow_down_rounded,
          );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 78,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.grey[200]),
        child: Row(
          children: [
            icon,
            Container(
              child: Column(
                children: [Text(column.toString()), Text(row.toString())],
              ),
            ),
            Container(
              child: Text(hint),
            ),
          ],
        ),
      ),
    );
  }
}
