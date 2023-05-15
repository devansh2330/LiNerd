import 'package:flutter/material.dart';
import 'package:puzzler/components/update_constants.dart';

class MyTile extends StatefulWidget {
  final String word;
  final String hint;
  final String direction;
  final int column;
  final int row;

  //final bool hintLeft;

  const MyTile({
    Key? key,
    required this.word,
    required this.hint,
    required this.direction,
    required this.column,
    required this.row,
    //required this.hintLeft,
  }) : super(key: key);

  @override
  State<MyTile> createState() => _MyTileState();
}

class _MyTileState extends State<MyTile> {
  var answer = '';

  @override
  Widget build(BuildContext context) {
    var icon = widget.direction == "ACROSS"
        ? const Icon(
            Icons.keyboard_double_arrow_right_rounded,
            size: 40,
          )
        : const Icon(
            Icons.keyboard_double_arrow_down_rounded,
            size: 40,
          );

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
                      " ${widget.hint}",
                      overflow: TextOverflow.visible,
                      softWrap: true,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Column ${widget.column + 1}, Row ${widget.row + 1}  $answer",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (wordhintused == 0) {
                            setState(() {
                              answer = widget.word;
                            });
                          }
                          wordhintused++;
                          print('hint executed $answer');
                        },
                        child: Container(
                          alignment: Alignment.topLeft,
                          //decoration: BoxDecoration(color: Colors.green),
                          child: Icon(
                            Icons.question_mark,
                            color: wordhintused == 0
                                ? Colors.green
                                : Colors.grey[200],
                            size: 15,
                          ),
                        ),
                      )
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
