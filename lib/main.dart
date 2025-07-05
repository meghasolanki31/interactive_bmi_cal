import 'package:flutter/material.dart';

import 'constant.dart';
import 'home_screen.dart';

void main() {
  runApp(InterActiveBMI());
}

class InterActiveBMI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var titleText = RichText(
      text: TextSpan(
        style: titleTextStyle,
        // TextStyle(fontSize: 25.0, color: Colors.blue[400]),
        children: <TextSpan>[
          TextSpan(
            text: 'BMI',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue[400],
            ),
          ),
          TextSpan(
            text: ' Calculator',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.pinkAccent,
            ),
          ),
        ],
      ),
    );
    return MaterialApp(debugShowCheckedModeBanner: false,
        home: HomeScreen(titleText: titleText,)
    );
  }
}
