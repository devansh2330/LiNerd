import 'package:flutter/material.dart';

class MyGPTile extends StatelessWidget {
  final String hint;
  final String direction;
  final int column;
  final int row;

  const MyGPTile({
    Key? key,
    required this.hint,
    required this.direction,
    required this.column,
    required this.row,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var icon = direction == "ACROSS"
        ? const Icon(Icons.keyboard_double_arrow_right_rounded)
        : const Icon(Icons.keyboard_double_arrow_down_rounded);
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
                      hint,
                      overflow: TextOverflow.visible,
                      softWrap: true,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Text("Column $column, Row $row",
                      style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
