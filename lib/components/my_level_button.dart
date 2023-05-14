import 'package:flutter/material.dart';

class IncrementDecrementButton extends StatefulWidget {
  final Function()? onIncrement;
  final Function()? onDecrement;

  IncrementDecrementButton({Key? key, this.onIncrement, this.onDecrement})
      : super(key: key);

  @override
  _IncrementDecrementButtonState createState() =>
      _IncrementDecrementButtonState();
}

class _IncrementDecrementButtonState extends State<IncrementDecrementButton> {
  int _count = 0;
  var levelCounter = ["Beginner", "Novice", "Advanced"];

  void _incrementCounter() {
    setState(() {
      if (_count < 2) {
        _count++;
      } else {
        _count = 0;
      }
    });
    if (widget.onIncrement != null) {
      widget.onIncrement!();
    }
  }

  void _decrementCounter() {
    setState(() {
      if (_count > 0) {
        _count--;
      } else {
        _count = 2;
      }
    });
    if (widget.onDecrement != null) {
      widget.onDecrement!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: _decrementCounter,
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(40),
                  ),
                ),
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black,
              height: 70,
              child: Center(
                child: Text(
                  '${levelCounter[_count]}',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: _incrementCounter,
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(40),
                  ),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
