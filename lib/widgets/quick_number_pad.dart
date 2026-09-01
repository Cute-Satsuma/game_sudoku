import 'package:flutter/material.dart';

/// Compact 3×3 number picker shown near a selected board cell.
class QuickNumberPad extends StatelessWidget {
  const QuickNumberPad({
    super.key,
    required this.onNumberTap,
    this.highlightedNumbers = const {},
  });

  final void Function(int number) onNumberTap;
  final Set<int> highlightedNumbers;

  static const double buttonSize = 40.0;
  static const double gap = 4.0;
  static const double padding = 8.0;

  static double get extent =>
      padding * 2 + buttonSize * 3 + gap * 2;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      elevation: 8,
      shadowColor: colorScheme.shadow.withValues(alpha: isDark ? 0.5 : 0.28),
      borderRadius: BorderRadius.circular(14),
      color: isDark
          ? colorScheme.surfaceContainerHighest
          : colorScheme.surface,
      child: Container(
        padding: const EdgeInsets.all(padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.55),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var row = 0; row < 3; row++) ...[
              if (row > 0) const SizedBox(height: gap),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var col = 0; col < 3; col++) ...[
                    if (col > 0) const SizedBox(width: gap),
                    _QuickPadButton(
                      number: row * 3 + col + 1,
                      size: buttonSize,
                      isHighlighted:
                          highlightedNumbers.contains(row * 3 + col + 1),
                      onTap: () => onNumberTap(row * 3 + col + 1),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _QuickPadButton extends StatelessWidget {
  const _QuickPadButton({
    required this.number,
    required this.size,
    required this.onTap,
    this.isHighlighted = false,
  });

  final int number;
  final double size;
  final VoidCallback onTap;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final fill = colorScheme.primaryContainer.withValues(alpha: 0.26);
    final fillActive = colorScheme.primaryContainer.withValues(alpha: 0.52);
    final border = colorScheme.outlineVariant;
    final borderActive = colorScheme.primary;
    final text = colorScheme.onPrimaryContainer;

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(
        color: isHighlighted ? borderActive : border,
        width: isHighlighted ? 1.5 : 1,
      ),
    );

    return Material(
      color: isHighlighted ? fillActive : fill,
      clipBehavior: Clip.antiAlias,
      shape: shape,
      child: InkWell(
        onTap: onTap,
        customBorder: shape,
        splashColor: colorScheme.primary.withValues(alpha: 0.12),
        highlightColor: colorScheme.primary.withValues(alpha: 0.06),
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: Text(
              '$number',
              overflow: TextOverflow.visible,
              style: TextStyle(
                fontSize: size * 0.42,
                fontWeight: FontWeight.w600,
                color: text,
                height: 1.0,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
