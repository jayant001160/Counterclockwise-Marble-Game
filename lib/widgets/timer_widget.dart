import 'package:flutter/material.dart';
import 'dart:async';

class TimerWidget extends StatefulWidget {
  final int timeLimit;
  final VoidCallback onTimeUp;

  TimerWidget({required this.timeLimit, required this.onTimeUp});

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late int remainingTime;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.timeLimit;
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    remainingTime = widget.timeLimit;
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        widget.onTimeUp();
        t.cancel();
      }
    });
  }

  @override
  void didUpdateWidget(covariant TimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.timeLimit != widget.timeLimit) {
      startTimer();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Time Remaining: $remainingTime',
      style: TextStyle(fontSize: 20),
    );
  }
}
