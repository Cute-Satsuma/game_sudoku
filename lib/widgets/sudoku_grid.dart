import 'package:flutter/material.dart';

/// Sudoku grid layout constants
abstract final class _GridConstants {
  static const double minCellSize = 28.0;
  static const double maxCellSize = 42.0;
  static const double minFontSize = 14.0;
  static const double maxFontSize = 22.0;
  static const double minHintFontSize = 10.0;
  static const double maxHintFontSize = 14.0;
  static const double gridPadding = 16.0;
  static const double separatorSpace = 30.0;
  static const int gridSize = 9;
  static const int blockSize = 3;
}

class SudokuGrid extends StatelessWidget {
  const SudokuGrid({
    super.key,
    required this.grid,
    required this.initialPuzzle,
    required this.selectedCell,
    required this.onCellTap,
    this.errorCells = const {},
    this.correctCells = const {},
  });

  final List<List<int>> grid;
  final List<List<int>> initialPuzzle;
  final ({int row, int col})? selectedCell;
  final void Function(int row, int col) onCellTap;
  final Set<({int row, int col})> errorCells;
  final Set<({int row, int col})> correctCells;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxW = constraints.maxWidth.isInfinite ? 400.0 : constraints.maxWidth;
        final availableWidth = maxW - _GridConstants.gridPadding;
        final cellSize = ((availableWidth - _GridConstants.separatorSpace) / _GridConstants.gridSize)
            .clamp(_GridConstants.minCellSize, _GridConstants.maxCellSize);
        final fontSize = (cellSize * 0.5).clamp(_GridConstants.minFontSize, _GridConstants.maxFontSize);
        final hintFontSize = (cellSize * 0.35).clamp(_GridConstants.minHintFontSize, _GridConstants.maxHintFontSize);

        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int row = 0; row < _GridConstants.gridSize; row++) ...[
                if (row > 0 && row % _GridConstants.blockSize == 0)
                  const _GridSeparator(isHorizontal: true),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int col = 0; col < _GridConstants.gridSize; col++) ...[
                      if (col > 0 && col % _GridConstants.blockSize == 0)
                        _GridSeparator(isHorizontal: false, height: cellSize),
                      RepaintBoundary(
                        child: _SudokuCell(
                          key: ValueKey('cell-$row-$col'),
                          value: grid[row][col],
                          fontSize: fontSize,
                          hintFontSize: hintFontSize,
                          cellSize: cellSize,
                          isFixed: initialPuzzle[row][col] != 0,
                          isSelected: selectedCell?.row == row && selectedCell?.col == col,
                          hasError: errorCells.contains((row: row, col: col)),
                          isCorrect: correctCells.contains((row: row, col: col)),
                          onTap: () => onCellTap(row, col),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _GridSeparator extends StatelessWidget {
  const _GridSeparator({
    required this.isHorizontal,
    this.height,
  });

  final bool isHorizontal;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isHorizontal ? 2 : 0,
        horizontal: isHorizontal ? 0 : 2,
      ),
      child: Container(
        width: isHorizontal ? null : 2,
        height: isHorizontal ? 2 : height,
        color: Colors.grey.shade400,
      ),
    );
  }
}

class _SudokuCell extends StatelessWidget {
  const _SudokuCell({
    super.key,
    required this.value,
    required this.fontSize,
    required this.hintFontSize,
    required this.cellSize,
    required this.isFixed,
    required this.isSelected,
    required this.hasError,
    required this.isCorrect,
    required this.onTap,
  });

  final int value;
  final double fontSize;
  final double hintFontSize;
  final double cellSize;
  final bool isFixed;
  final bool isSelected;
  final bool hasError;
  final bool isCorrect;
  final VoidCallback onTap;

  static const _animationDuration = Duration(milliseconds: 150);
  static const _cellMargin = EdgeInsets.all(1);
  static const _borderRadius = 4.0;

  bool get _isHighlighted => hasError || isCorrect || isSelected;

  (Color fill, Color border, Color text) get _colors {
    if (hasError) return (Colors.red.shade100, Colors.red, Colors.red.shade800);
    if (isCorrect) return (Colors.green.shade100, Colors.green, Colors.green.shade800);
    if (isSelected) return (Colors.blue.shade100, Colors.blue, Colors.blue.shade700);
    return (Colors.transparent, Colors.grey.shade300, Colors.black87);
  }

  @override
  Widget build(BuildContext context) {
    final (fill, border, text) = _colors;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: _animationDuration,
        width: cellSize,
        height: cellSize,
        margin: _cellMargin,
        decoration: BoxDecoration(
          color: fill,
          border: Border.all(
            color: border,
            width: _isHighlighted ? 2 : 0.5,
          ),
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: Center(
          child: value > 0
              ? Text(
                  value.toString(),
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: isFixed ? FontWeight.bold : FontWeight.w500,
                    color: isFixed ? Colors.black87 : text,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
