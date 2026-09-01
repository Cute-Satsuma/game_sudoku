/// Sudoku validator - checks if placement is valid
class SudokuValidator {
  /// Check if placing a number at the given position is valid
  static bool isValidPlacement(
    List<List<int>> grid,
    int row,
    int col,
    int num,
  ) {
    if (num < 1 || num > 9) return false;

    // Check row
    for (int x = 0; x < 9; x++) {
      if (x != col && grid[row][x] == num) return false;
    }

    // Check column
    for (int x = 0; x < 9; x++) {
      if (x != row && grid[x][col] == num) return false;
    }

    // Check 3x3 box
    final startRow = row - row % 3;
    final startCol = col - col % 3;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        final r = startRow + i;
        final c = startCol + j;
        if ((r != row || c != col) && grid[r][c] == num) return false;
      }
    }

    return true;
  }

  /// Check if the entire sudoku is correctly completed
  static bool isComplete(List<List<int>> grid) {
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        if (grid[row][col] == 0) return false;
        if (!isValidPlacement(grid, row, col, grid[row][col])) return false;
      }
    }
    return true;
  }
}
