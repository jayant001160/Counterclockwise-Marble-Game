import 'package:flutter/material.dart';

class GameCell extends StatelessWidget {
  final int row;
  final int col;
  final String? value; // 'P1' for player 1, 'P2' for player 2, or null for empty cell
  final VoidCallback onTap;
  final bool isWinningCell;

  GameCell({
    required this.row,
    required this.col,
    required this.value,
    required this.onTap,
    this.isWinningCell = false,
  });

  @override
  Widget build(BuildContext context) {
    Gradient marbleGradient;

    if (value == 'P1') {
      // Gradient for Player 1's marble
      marbleGradient = const LinearGradient(
        colors: [
          Color(0xFFFFA07A), // Light Salmon
          Color(0xFFFA8072), // Salmon
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (value == 'P2') {
      // Gradient for Player 2's marble
      marbleGradient = const LinearGradient(
        colors: [
          Color(0xFF87CEFA), // Light Sky Blue
          Color(0xFF4682B4), // Steel Blue
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      // Transparent for empty cells
      marbleGradient = const LinearGradient(
        colors: [Colors.transparent, Colors.transparent],
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isWinningCell ? Colors.yellow.withOpacity(0.5) : Colors.transparent, // Highlight winning cells
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: marbleGradient,
              border: Border.all(color: Colors.black, width: 1),
            ),
          ),
        ),
      ),
    );
  }
}
