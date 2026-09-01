import 'package:flutter/material.dart';

/// Sudoku grid layout constants
abstract final class _GridConstants {
  static const double maxCellSize = 42.0;
  static const double minFontSize = 14.0;
  static const double maxFontSize = 22.0;
  static const double minHintFontSize = 7.0;
  static const double maxHintFontSize = 11.0;
  static const double outerPadding = 8.0;
  static const double cellMargin = 1.0;
  static const double separatorThickness = 2.0;
  static const double separatorPadding = 2.0;
  static const double borderWidth = 1.0;
  static const int gridSize = 9;
  static const int blockSize = 3;
  static const int blockGaps = 2;

  static double cellSizeFor(double maxWidth) {
    const extras =
        outerPadding * 2 +
        borderWidth * 2 +
        cellMargin * 2 * gridSize +
        blockGaps * (separatorThickness + separatorPadding * 2) +
        1;
    final fitted = (maxWidth - extras) / gridSize;
    return fitted.clamp(0.0, maxCellSize);
  }
}

class SudokuGrid extends StatelessWidget {
  const SudokuGrid({
    super.key,
    required this.grid,
    required this.initialPuzzle,
    required this.selectedCell,
    required this.onCellTap,
    this.errorCells = const {},
    this.notes,
    this.selectedCellKey,
  });

  final List<List<int>> grid;
  final List<List<int>> initialPuzzle;
  final ({int row, int col})? selectedCell;
  final void Function(int row, int col) onCellTap;
  final Set<({int row, int col})> errorCells;
  final List<List<Set<int>>>? notes;
  /// Attached to the currently selected cell for overlay positioning.
  final Key? selectedCellKey;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxW = constraints.maxWidth.isInfinite
            ? 400.0
            : constraints.maxWidth;
        final cellSize = _GridConstants.cellSizeFor(maxW);
        final fontSize = (cellSize * 0.5).clamp(
          _GridConstants.minFontSize,
          _GridConstants.maxFontSize,
        );
        final hintFontSize = (cellSize * 0.22).clamp(
          _GridConstants.minHintFontSize,
          _GridConstants.maxHintFontSize,
        );

        final colorScheme = Theme.of(context).colorScheme;
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          padding: const EdgeInsets.all(_GridConstants.outerPadding),
          decoration: BoxDecoration(
            color: isDark
                ? colorScheme.surfaceContainerHigh
                : colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.outlineVariant.withValues(alpha: 0.45),
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withValues(
                  alpha: isDark ? 0.28 : 0.1,
                ),
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
                          key: selectedCell?.row == row &&
                                  selectedCell?.col == col &&
                                  selectedCellKey != null
                              ? selectedCellKey
                              : ValueKey('cell-$row-$col'),
                          value: grid[row][col],
                          fontSize: fontSize,
                          hintFontSize: hintFontSize,
                          cellSize: cellSize,
                          isFixed: initialPuzzle[row][col] != 0,
                          isSelected:
                              selectedCell?.row == row &&
                              selectedCell?.col == col,
                          hasError: errorCells.contains((row: row, col: col)),
                          notes: notes?[row][col] ?? const {},
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
  const _GridSeparator({required this.isHorizontal, this.height});

  final bool isHorizontal;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isHorizontal ? _GridConstants.separatorPadding : 0,
        horizontal: isHorizontal ? 0 : _GridConstants.separatorPadding,
      ),
      child: Container(
        width: isHorizontal ? null : _GridConstants.separatorThickness,
        height: isHorizontal ? _GridConstants.separatorThickness : height,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.22),
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
    this.notes = const {},
    required this.onTap,
  });

  final int value;
  final double fontSize;
  final double hintFontSize;
  final double cellSize;
  final bool isFixed;
  final bool isSelected;
  final bool hasError;
  final Set<int> notes;
  final VoidCallback onTap;

  static const _animationDuration = Duration(milliseconds: 150);
  static const _borderRadius = 4.0;

  bool get _isHighlighted => isSelected;

  Color _errorInk(Brightness brightness) {
    return brightness == Brightness.dark
        ? const Color(0xFFFF5C5C)
        : const Color(0xFFE12626);
  }

  (Color fill, Color border, Color text) _colors(
    ColorScheme colorScheme,
    Brightness brightness,
  ) {
    final text = hasError
        ? _errorInk(brightness)
        : (isSelected ? colorScheme.primary : colorScheme.onSurface);
    if (isSelected) {
      return (
        colorScheme.primary.withValues(alpha: 0.22),
        colorScheme.primary,
        text,
      );
    }
    return (
      Colors.transparent,
      colorScheme.outlineVariant.withValues(alpha: 0.55),
      text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final (fill, border, text) = _colors(colorScheme, theme.brightness);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: _animationDuration,
        width: cellSize,
        height: cellSize,
        margin: const EdgeInsets.all(_GridConstants.cellMargin),
        decoration: BoxDecoration(
          color: fill,
          border: Border.all(color: border, width: _isHighlighted ? 2 : 0.5),
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: value > 0
            ? Center(
                child: Text(
                  value.toString(),
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: fontSize,
                    height: 1.0,
                    leadingDistribution: TextLeadingDistribution.even,
                    fontWeight: hasError
                        ? FontWeight.w800
                        : (isFixed ? FontWeight.bold : FontWeight.w500),
                    color: isFixed && !hasError ? colorScheme.onSurface : text,
                  ),
                ),
              )
            : (notes.isNotEmpty
                  ? _CellNotes(
                      notes: notes,
                      fontSize: hintFontSize,
                      color: colorScheme.onSurfaceVariant,
                    )
                  : null),
      ),
    );
  }
}

class _CellNotes extends StatelessWidget {
  const _CellNotes({
    required this.notes,
    required this.fontSize,
    required this.color,
  });

  final Set<int> notes;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.5),
      child: Column(
        children: [
          for (var row = 0; row < 3; row++)
            Expanded(
              child: Row(
                children: [
                  for (var col = 0; col < 3; col++)
                    Expanded(
                      child: Center(
                        child: Text(
                          '${row * 3 + col + 1}',
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            fontSize: fontSize,
                            height: 1.0,
                            leadingDistribution: TextLeadingDistribution.even,
                            fontWeight: FontWeight.w600,
                            color: notes.contains(row * 3 + col + 1)
                                ? color
                                : color.withValues(alpha: 0),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
