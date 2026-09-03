import 'package:flutter_test/flutter_test.dart';
import 'package:game_sudoku/sudoku/hint_candidates.dart';

List<List<int>> emptyGrid() =>
    List.generate(9, (_) => List<int>.filled(9, 0));

void main() {
  test('row hints exclude digits already in the row', () {
    final grid = emptyGrid();
    grid[0][1] = 1;
    grid[0][8] = 9;
    final hints = HintCandidates.forCell(grid, 0, 0);
    expect(hints.row, equals({2, 3, 4, 5, 6, 7, 8}));
  });

  test('column hints exclude digits already in the column', () {
    final grid = emptyGrid();
    grid[2][4] = 3;
    grid[8][4] = 7;
    final hints = HintCandidates.forCell(grid, 0, 4);
    expect(hints.column, equals({1, 2, 4, 5, 6, 8, 9}));
  });

  test('box hints exclude digits already in the 3x3 box', () {
    final grid = emptyGrid();
    grid[0][0] = 5;
    grid[1][1] = 6;
    grid[2][2] = 7;
    final hints = HintCandidates.forCell(grid, 0, 1);
    expect(hints.box, equals({1, 2, 3, 4, 8, 9}));
  });

  test('selected cell value does not block its own candidates', () {
    final grid = emptyGrid();
    grid[4][4] = 2;
    final hints = HintCandidates.forCell(grid, 4, 4);
    expect(hints.row.contains(2), isTrue);
    expect(hints.column.contains(2), isTrue);
    expect(hints.box.contains(2), isTrue);
  });

  test('hint flags combine enabled sets per digit', () {
    final flags = NumberHintFlags.fromSets(
      number: 4,
      box: const {1, 4},
      column: const {4, 5},
      row: const {8},
    );
    expect(flags.box, isTrue);
    expect(flags.column, isTrue);
    expect(flags.row, isFalse);
    expect(flags.any, isTrue);
  });
}
