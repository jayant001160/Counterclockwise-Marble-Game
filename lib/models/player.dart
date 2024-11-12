import 'package:flutter/material.dart';

enum Player { player1, player2 }

class PlayerInfo {
  final Player player;
  final Color color;

  PlayerInfo({required this.player, required this.color});

  String get identifier => player == Player.player1 ? 'P1' : 'P2';
}
