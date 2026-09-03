/// Candidates for a selected cell, computed independently per Sudoku unit.
class CellHintCandidates {
  const CellHintCandidates({
    required this.box,
    required this.column,
    required this.row,
  });

  final Set<int> box;
  final Set<int> column;
  final Set<int> row;

  static const empty = CellHintCandidates(
    box: <int>{},
    column: <int>{},
    row: <int>{},
  );
}

class NumberHintFlags {
  const NumberHintFlags({
    this.box = false,
    this.column = false,
    this.row = false,
  });

  final bool box;
  final bool column;
  final bool row;

  bool get any => box || column || row;

  static const none = NumberHintFlags();

  factory NumberHintFlags.fromSets({
    required int number,
    required Set<int> box,
    required Set<int> column,
    required Set<int> row,
  }) {
    return NumberHintFlags(
      box: box.contains(number),
      column: column.contains(number),
      row: row.contains(number),
    );
  }
}

class HintCandidates {
  HintCandidates._();

  static const _all = {1, 2, 3, 4, 5, 6, 7, 8, 9};

  static CellHintCandidates forCell(
    List<List<int>> grid,
    int row,
    int col,
  ) {
    return CellHintCandidates(
      box: _availableInBox(grid, row, col),
      column: _availableInColumn(grid, row, col),
      row: _availableInRow(grid, row, col),
    );
  }

  static Set<int> _availableInRow(List<List<int>> grid, int row, int col) {
    final used = <int>{};
    for (var c = 0; c < 9; c++) {
      if (c == col) continue;
      final value = grid[row][c];
      if (value != 0) used.add(value);
    }
    return _all.difference(used);
  }

  static Set<int> _availableInColumn(List<List<int>> grid, int row, int col) {
    final used = <int>{};
    for (var r = 0; r < 9; r++) {
      if (r == row) continue;
      final value = grid[r][col];
      if (value != 0) used.add(value);
    }
    return _all.difference(used);
  }

  static Set<int> _availableInBox(List<List<int>> grid, int row, int col) {
    final used = <int>{};
    final startRow = row - row % 3;
    final startCol = col - col % 3;
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        final r = startRow + i;
        final c = startCol + j;
        if (r == row && c == col) continue;
        final value = grid[r][c];
        if (value != 0) used.add(value);
      }
    }
    return _all.difference(used);
  }
}
