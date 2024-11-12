import 'package:flutter/material.dart';

import 'game_cell.dart';

class GameBoard extends StatelessWidget {
  final List<List<String?>> board;
  final Function(int, int) onCellTap;
  final List<List<int>>? winningCells;

  GameBoard({required this.board, required this.onCellTap, this.winningCells});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 16,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (context, index) {
          int row = index ~/ 4;
          int col = index % 4;
          bool isWinningCell = winningCells != null && winningCells!.any((cell) => cell[0] == row && cell[1] == col);
          return GameCell(
            row: row,
            col: col,
            value: board[row][col],
            onTap: () => onCellTap(row, col),
            isWinningCell: isWinningCell,
          );
        },
      ),
    );
  }
}
