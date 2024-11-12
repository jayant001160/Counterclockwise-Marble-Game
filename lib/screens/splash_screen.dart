import 'package:flutter/material.dart';
import '../widgets/splash_content.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentIndex = 0;

  final List<Map<String, dynamic>> splashData = [
    {
      "title": "Welcome to Marble Game",
      "description": "Place marbles and align four in a row to win!",
      "gridLayout": [
        [null, null, null, null],
        [null, 'P1', 'P2', null],
        [null, 'P2', 'P1', null],
        [null, null, null, null],
      ],
    },
    {
      "title": "Objective",
      "description": "Align four marbles in a row, column, or diagonal to win!",
      "gridLayout": [
        ['P1', 'P1', 'P1', 'P1'],
        [null, null, null, null],
        [null, null, null, null],
        [null, null, null, null],
      ],
    },
    {
      "title": "Gameplay Mechanics",
      "description": "Marbles move counterclockwise after each turn.",
      "gridLayout": [
        ['P1', 'P2', 'P1', 'P2'],
        ['P2', null, null, 'P1'],
        ['P1', null, null, 'P2'],
        ['P2', 'P1', 'P2', 'P1'],
      ],
    },
    {
      "title": "Winning Condition",
      "description": "Align four marbles to win! Here's an example win!",
      "gridLayout": [
        ['P1', null, null, null],
        [null, 'P1', null, null],
        [null, null, 'P1', null],
        [null, null, null, 'P1'],
      ],
    },
    {
      "title": "Turn Timer",
      "description": "Each turn is timed. If time runs out, the other player wins.",
      "gridLayout": [
        [null, null, null, null],
        [null, 'P1', 'P2', null],
        [null, 'P2', 'P1', null],
        [null, null, null, null],
      ],
    },
  ];

  void nextPage() {
    if (currentIndex < splashData.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      Navigator.pushReplacementNamed(context, '/gameScreen'); // Navigate to game
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashContent(
        title: splashData[currentIndex]["title"],
        description: splashData[currentIndex]["description"],
        gridLayout: splashData[currentIndex]["gridLayout"],
        onNextPressed: nextPage,
      ),
    );
  }
}
