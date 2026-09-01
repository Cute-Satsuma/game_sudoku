import 'package:flutter/material.dart';
import 'package:game_sudoku/theme/app_palette.dart';

/// Mini grid preview for anime vs business icon style in theme settings.
class SudokuIconPreview extends StatelessWidget {
  const SudokuIconPreview({
    super.key,
    required this.style,
    this.size = 72,
  });

  final AppIconStyle style;
  final double size;

  static const _sample = [
    [5, 0, 3],
    [0, 7, 0],
    [0, 0, 1],
  ];

  @override
  Widget build(BuildContext context) {
    final anime = style == AppIconStyle.anime;
    final colorScheme = Theme.of(context).colorScheme;
    final bg = anime ? const Color(0xFFFFF6E8) : const Color(0xFFF3EBDA);
    final ink = anime ? colorScheme.primary : const Color(0xFF3C3A36);
    final radius = anime ? 16.0 : 0.0;
    final cellRadius = anime ? 6.0 : 0.0;
    final gap = size * 0.06;
    final cell = (size - gap * 4) / 3;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: ink.withValues(alpha: 0.18)),
      ),
      padding: EdgeInsets.all(gap),
      child: Column(
        children: [
          for (var row = 0; row < 3; row++)
            Expanded(
              child: Row(
                children: [
                  for (var col = 0; col < 3; col++)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(gap * 0.35),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: _sample[row][col] == 0
                                ? ink.withValues(alpha: 0.06)
                                : ink.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(cellRadius),
                          ),
                          child: Center(
                            child: Text(
                              _sample[row][col] == 0
                                  ? ''
                                  : '${_sample[row][col]}',
                              style: TextStyle(
                                color: ink,
                                fontSize: cell * 0.42,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
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
