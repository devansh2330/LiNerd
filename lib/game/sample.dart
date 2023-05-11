import 'package:flutter/material.dart';

class GridExample extends StatefulWidget {
  @override
  _GridExampleState createState() => _GridExampleState();
}

class _GridExampleState extends State<GridExample> {
  List<List<bool>> gridData = [
    [true, false, true],
    [false, true, false],
    [true, false, true],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid Example'),
      ),
      body: GridView.builder(
        itemCount: gridData.length * gridData[0].length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridData[0].length,
        ),
        itemBuilder: (context, index) {
          int row = index ~/ 3;
          int col = index % 3;
          Color color = gridData[row][col] ? Colors.green : Colors.grey;
          return Container(
            color: color,
            child: Center(
              child: Text(
                '$row, $col',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
