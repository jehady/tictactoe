import 'dart:math';

class TicTacToe {
  static const int SIZE = 3;
  static const String EMPTY = '';
  static const String PLAYER = 'X';
  static const String AI = 'O';

  // Function to determine the optimal move for the AI
  int findBestMove(List<List<String>> board) {
    int bestScore = -1000;
    int bestMove = -1;

    for (int i = 0; i < SIZE; i++) {
      for (int j = 0; j < SIZE; j++) {
        if (board[i][j] == EMPTY) {
          board[i][j] = AI;
          int moveScore = minimax(board, 0, false, -1000, 1000);
          board[i][j] = EMPTY;

          if (moveScore > bestScore) {
            bestScore = moveScore;
            bestMove = i * SIZE + j;
          }
        }
      }
    }
    return bestMove;
  }

  // Minimax algorithm with alpha-beta pruning
  int minimax(List<List<String>> board, int depth, bool isMaximizing, int alpha,
      int beta) {
    int score = evaluate(board);

    if (score == 10) return score; // AI wins
    if (score == -10) return score; // Player wins
    if (!isMovesLeft(board)) return 0; // Draw

    if (isMaximizing) {
      int best = -1000;
      for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++) {
          if (board[i][j] == EMPTY) {
            board[i][j] = AI;
            best = max(
                best, minimax(board, depth + 1, !isMaximizing, alpha, beta));
            alpha = max(alpha, best);
            board[i][j] = EMPTY;
            if (beta <= alpha) break;
          }
        }
      }
      return best;
    } else {
      int best = 1000;
      for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++) {
          if (board[i][j] == EMPTY) {
            board[i][j] = PLAYER;
            best = min(
                best, minimax(board, depth + 1, !isMaximizing, alpha, beta));
            beta = min(beta, best);
            board[i][j] = EMPTY;
            if (beta <= alpha) break;
          }
        }
      }
      return best;
    }
  }

  int evaluate(List<List<String>> board) {
    // Check rows for winning positions
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == board[i][1] && board[i][1] == board[i][2]) {
        if (board[i][0] == AI) return 10; // AI wins
        if (board[i][0] == PLAYER) return -10; // Player wins
      }
    }

    // Check columns for winning positions
    for (int i = 0; i < 3; i++) {
      if (board[0][i] == board[1][i] && board[1][i] == board[2][i]) {
        if (board[0][i] == AI) return 10; // AI wins
        if (board[0][i] == PLAYER) return -10; // Player wins
      }
    }

    // Check diagonals for winning positions
    if ((board[0][0] == board[1][1] && board[1][1] == board[2][2]) ||
        (board[0][2] == board[1][1] && board[1][1] == board[2][0])) {
      if (board[1][1] == AI) return 10; // AI wins
      if (board[1][1] == PLAYER) return -10; // Player wins
    }

    // If no winning positions found, return 0 for draw or undecided
    return 0;
  }

  bool isMovesLeft(List<List<String>> board) {
    for (int i = 0; i < SIZE; i++) {
      for (int j = 0; j < SIZE; j++) {
        if (board[i][j] == EMPTY) {
          return true;
        }
      }
    }
    return false;
  }
}
