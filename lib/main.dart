import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/game_screen.dart';

void main() {
  runApp(MarbleGameApp());
}

class MarbleGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marble Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/gameScreen': (context) => GameScreen(),
      },
    );
  }
}
