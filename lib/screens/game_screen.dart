import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/player.dart';
import '../widgets/game_board.dart';
import '../utils/game_logic.dart';
import '../widgets/gradient_button.dart';
import '../widgets/timer_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<List<int>>? winningCells; // Store coordinates of winning cells
  late List<List<String?>> board;
  Player currentPlayer = Player.player1;
  bool gameEnded = false;
  String winner = '';
  GameLogic gameLogic = GameLogic();
  Timer? timer;
  int timeRemaining = 10; // Set your time limit (in seconds)
  final List<String> gameTips = [
    "Try to control the center of the board!",
    "Watch for your opponent’s moves.",
    "Plan a few moves ahead.",
    "Use the timer wisely.",
    "Align four marbles to win!",
    "Remember, marbles move counterclockwise after each turn.",
    "Focus on blocking your opponent's alignment.",
    "Don’t rush, consider each move carefully.",
    "Corner positions can be advantageous.",
    "Stay calm under pressure, manage your time.",
    "Look for diagonal alignment opportunities.",
    "Adapt your strategy as the game progresses.",
    "Keep an eye on both horizontal and vertical lines.",
    "Use the edges strategically to set up your marbles.",
    "Sometimes, defense is the best offense!",
    "Think one step ahead of your opponent."
];

  String currentTip = '';

  @override
  void initState() {
    super.initState();
    resetGame(); // Initialize the game with a fresh board
    _updateGameTip();
  }

  void startTimer() {
    timer?.cancel(); // Cancel any existing timer
    timeRemaining = 10; // Reset timer to initial time for each turn

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeRemaining > 0) {
          timeRemaining--;
        } else {
          timer.cancel();
          handleTimeout(); // Handle timeout when time runs out
        }
      });
    });
  }

  void handleTimeout() {
    setState(() {
      gameEnded = true;
      winner = currentPlayer == Player.player1 ? 'Player 2' : 'Player 1';
      timer?.cancel();
    });
  }

  void onCellTap(int row, int col) {
    if (board[row][col] == null && !gameEnded) {
      setState(() {
        board[row][col] = currentPlayer == Player.player1 ? 'P1' : 'P2';
        final currentPlayerSymbol = board[row][col]!;

        // Check for a win condition after placing a marble
        winningCells = gameLogic.checkWinningCondition(board, currentPlayerSymbol);

        if (winningCells != null) {
          gameEnded = true;
          winner = currentPlayerSymbol;
          timer?.cancel(); // Stop the timer if there’s a winner
        } else if (_isBoardFull()) {
          gameEnded = true;
          winner = "No one";
          timer?.cancel(); // Stop the timer if there’s a draw
        } else {
          // Introduce a 300ms delay before moving the marbles
          Future.delayed(const Duration(milliseconds: 300), () {
            setState(() {
              // Move the marbles counterclockwise after the delay
              gameLogic.moveMarblesCounterclockwise(board);

              // Check for a win condition again after the marble move
              winningCells = gameLogic.checkWinningCondition(board, currentPlayerSymbol);
              if (winningCells != null) {
                gameEnded = true;
                winner = currentPlayerSymbol;
                timer?.cancel(); // Stop the timer if there’s a winner
              } else {
                // Toggle to the next player after moving marbles
                togglePlayer();
              }
            });
          });
        }
      });
    }
  }

  bool _isBoardFull() {
    for (var row in board) {
      if (row.contains(null)) {
        return false;
      }
    }
    return true;
  }

  void togglePlayer() {
    currentPlayer = currentPlayer == Player.player1 ? Player.player2 : Player.player1;
    startTimer(); // Reset timer for the next player
    _updateGameTip(); // Update the game tip
  }

  void resetGame() {
    setState(() {
      // Clear the game board
      board = List.generate(4, (_) => List.filled(4, null));

      // Reset the player turn to the initial player
      currentPlayer = Player.player1;

      // Reset game state variables
      gameEnded = false;
      winner = '';

      // Clear the winning cells
      winningCells = null;

      startTimer(); // Start the timer for the new game
      _updateGameTip(); // Show a new tip at the beginning of the game
    });
  }

  void _updateGameTip() {
    final random = Random();
    setState(() {
      currentTip = gameTips[random.nextInt(gameTips.length)];
    });
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel timer when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counterclockwise Marble Game'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            gameEnded
                ? 'Game Over! ${winner == "No one" ? "It\'s a Draw!" : 'Player $winner Wins!'}'
                : 'Current Turn: ${currentPlayer == Player.player1 ? 'Player 1' : 'Player 2'}',
            style: const TextStyle(fontSize: 24),
          ),
          if (!gameEnded)
            TimerWidget(
              timeLimit: timeRemaining,
              onTimeUp: handleTimeout,
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GameBoard(
                board: board,
                onCellTap: onCellTap,
                winningCells: winningCells,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
            child: Text(
              gameEnded ? 'Game Over' : currentTip,
              style: const TextStyle(fontSize: 36, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GradientButton(
              text: "Restart Game",
              onPressed: resetGame,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
