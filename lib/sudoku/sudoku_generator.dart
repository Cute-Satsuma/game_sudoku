import 'dart:math';

/// Sudoku generator - generates solvable sudoku puzzles
class SudokuGenerator {
  final Random _random = Random();

  /// Generate a complete valid sudoku solution
  List<List<int>> generateSolution() {
    final grid = List.generate(9, (_) => List.filled(9, 0));

    _fillDiagonalBoxes(grid);
    _solve(grid);

    return grid;
  }

  /// Fill diagonal 3x3 boxes first (they are independent)
  void _fillDiagonalBoxes(List<List<int>> grid) {
    for (int box = 0; box < 9; box += 3) {
      _fillBox(grid, box, box);
    }
  }

  void _fillBox(List<List<int>> grid, int row, int col) {
    final numbers = List.generate(9, (i) => i + 1)..shuffle(_random);

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        grid[row + i][col + j] = numbers[i * 3 + j];
      }
    }
  }

  /// Solve sudoku using backtracking
  bool _solve(List<List<int>> grid) {
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        if (grid[row][col] == 0) {
          final numbers = List.generate(9, (i) => i + 1)..shuffle(_random);

          for (final num in numbers) {
            if (_isValid(grid, row, col, num)) {
              grid[row][col] = num;

              if (_solve(grid)) {
                return true;
              }

              grid[row][col] = 0;
            }
          }
          return false;
        }
      }
    }
    return true;
  }

  bool _isValid(List<List<int>> grid, int row, int col, int num) {
    // Check row
    for (int x = 0; x < 9; x++) {
      if (grid[row][x] == num) return false;
    }

    // Check column
    for (int x = 0; x < 9; x++) {
      if (grid[x][col] == num) return false;
    }

    // Check 3x3 box
    final startRow = row - row % 3;
    final startCol = col - col % 3;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (grid[startRow + i][startCol + j] == num) return false;
      }
    }

    return true;
  }

  /// Generate sudoku puzzle and solution
  /// difficulty: 1=Easy, 2=Medium, 3=Hard (for Free Play)
  /// cellsToRemove: directly specify cells to remove (for Campaign)
  /// More cells removed = harder puzzle (max 80, keep at least 1)
  ({List<List<int>> puzzle, List<List<int>> solution}) generatePuzzleWithSolution({
    int? difficulty,
    int? cellsToRemove,
  }) {
    final solution = generateSolution();
    final puzzle = solution.map((row) => List<int>.from(row)).toList();

    final toRemove = (cellsToRemove ??
        (switch (difficulty ?? 2) {
          1 => 32 + _random.nextInt(7), // Easy: remove 32-38 cells
          3 => 55 + _random.nextInt(8), // Hard: remove 55-62 cells
          _ => 45 + _random.nextInt(8), // Medium: remove 45-52 cells
        }))
        .clamp(20, 80);

    int removed = 0;
    int attempts = 0;
    final maxAttempts = (toRemove * 5).clamp(200, 800);

    while (removed < toRemove && attempts < maxAttempts) {
      final row = _random.nextInt(9);
      final col = _random.nextInt(9);

      if (puzzle[row][col] != 0) {
        final backup = puzzle[row][col];
        puzzle[row][col] = 0;

        // Ensure puzzle still has unique solution (simplified: only check solvable)
        if (_hasUniqueSolution(puzzle)) {
          removed++;
        } else {
          puzzle[row][col] = backup;
        }
      }
      attempts++;
    }

    return (puzzle: puzzle, solution: solution);
  }

  /// Campaign mode: generate puzzle by mode and level
  /// mode: 1=Easy, 2=Medium, 3=Hard
  /// level: 1-999, difficulty increases every 9 levels
  ({List<List<int>> puzzle, List<List<int>> solution}) generateForLevel({
    required int mode,
    required int level,
  }) {
    // Every 9 levels form a tier, 111 tiers total (tier 0~110)
    final tier = (level - 1) ~/ 9;
    final tierFactor = tier / 111; // 0.0 ~ 0.99

    // Base and max cells to remove per mode (level 1 vs level 999)
    final (base, maxRemoved) = switch (mode) {
      1 => (28, 42), // Easy
      3 => (54, 70), // Hard
      _ => (42, 58), // Medium
    };

    final cellsToRemove = (base +
            (tierFactor * (maxRemoved - base)).round() +
            _random.nextInt(4))
        .clamp(20, 80);

    return generatePuzzleWithSolution(cellsToRemove: cellsToRemove);
  }

  /// Generate puzzle (legacy API)
  List<List<int>> generatePuzzle({int difficulty = 2}) {
    return generatePuzzleWithSolution(difficulty: difficulty).puzzle;
  }

  /// Check if puzzle has unique solution (simplified: only check solvable)
  bool _hasUniqueSolution(List<List<int>> grid) {
    final copy = grid.map((row) => List<int>.from(row)).toList();
    return _solve(copy);
  }
}
