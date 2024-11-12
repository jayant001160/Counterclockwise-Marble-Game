class GameLogic {
  // Move marbles counterclockwise
  void moveMarblesCounterclockwise(List<List<String?>> board) {
    if (board.isEmpty || board.length != 4 || board[0].length != 4) return;

    // Step 1: Rotate the outer layer counterclockwise
    String? temp = board[0][0];
    
    // Move top row (left to right)
    board[0][0] = board[0][1];
    board[0][1] = board[0][2];
    board[0][2] = board[0][3];
    
    // Move right column (top to bottom)
    board[0][3] = board[1][3];
    board[1][3] = board[2][3];
    board[2][3] = board[3][3];
    
    // Move bottom row (right to left)
    board[3][3] = board[3][2];
    board[3][2] = board[3][1];
    board[3][1] = board[3][0];
    
    // Move left column (bottom to top)
    board[3][0] = board[2][0];
    board[2][0] = board[1][0];
    board[1][0] = temp;

    // Step 2: Rotate the inner layer counterclockwise
    temp = board[1][1];
    
    // Move inner top row (left to right)
    board[1][1] = board[1][2];
    
    // Move inner right column (top to bottom)
    board[1][2] = board[2][2];
    
    // Move inner bottom row (right to left)
    board[2][2] = board[2][1];
    
    // Move inner left column (bottom to top)
    board[2][1] = temp;
  }

  // Check if a player has won the game by having four consecutive marbles
  List<List<int>>? checkWinningCondition(List<List<String?>> board, String player) {
    // Check rows
    for (int i = 0; i < 4; i++) {
      if (board[i][0] == player && board[i][1] == player &&
          board[i][2] == player && board[i][3] == player) {
        return [[i, 0], [i, 1], [i, 2], [i, 3]];
      }
    }

    // Check columns
    for (int j = 0; j < 4; j++) {
      if (board[0][j] == player && board[1][j] == player &&
          board[2][j] == player && board[3][j] == player) {
        return [[0, j], [1, j], [2, j], [3, j]];
      }
    }

    // Check diagonals (top-left to bottom-right)
    if (board[0][0] == player && board[1][1] == player &&
        board[2][2] == player && board[3][3] == player) {
      return [[0, 0], [1, 1], [2, 2], [3, 3]];
    }

    // Check diagonals (top-right to bottom-left)
    if (board[0][3] == player && board[1][2] == player &&
        board[2][1] == player && board[3][0] == player) {
      return [[0, 3], [1, 2], [2, 1], [3, 0]];
    }

    return null;
  }
}
