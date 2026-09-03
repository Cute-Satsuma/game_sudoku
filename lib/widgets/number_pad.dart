import 'package:flutter/material.dart';

import '../sudoku/hint_candidates.dart';
import 'hint_accents.dart';

class NumberPad extends StatelessWidget {
  const NumberPad({
    super.key,
    required this.onNumberTap,
    required this.onClear,
    required this.onNotes,
    required this.onAutoFill,
    this.onAutoFillLongPress,
    this.isNotesMode = false,
    this.isAutoFillMode = false,
    this.notedNumbers = const {},
    this.hintBoxNumbers = const {},
    this.hintColumnNumbers = const {},
    this.hintRowNumbers = const {},
    this.enabled = true,
  });

  final void Function(int number) onNumberTap;
  final VoidCallback onClear;
  final VoidCallback onNotes;
  final VoidCallback onAutoFill;
  final VoidCallback? onAutoFillLongPress;
  final bool isNotesMode;
  final bool isAutoFillMode;
  final Set<int> notedNumbers;
  final Set<int> hintBoxNumbers;
  final Set<int> hintColumnNumbers;
  final Set<int> hintRowNumbers;
  final bool enabled;

  static const _gap = 6.0;

  NumberHintFlags _flagsFor(int number) {
    return NumberHintFlags.fromSets(
      number: number,
      box: hintBoxNumbers,
      column: hintColumnNumbers,
      row: hintRowNumbers,
    );
  }

  Widget _numberRow(List<int> numbers, double buttonSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < numbers.length; i++) ...[
          if (i > 0) const SizedBox(width: _gap),
          _PadButton(
            label: numbers[i].toString(),
            size: buttonSize,
            onTap: enabled ? () => onNumberTap(numbers[i]) : null,
            isHighlighted: notedNumbers.contains(numbers[i]),
            hintFlags: _flagsFor(numbers[i]),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth - 32;
        final buttonSize =
            ((availableWidth - _gap * 4) / 5).clamp(36.0, 56.0);
        final actionButtonSize = (buttonSize * 1.12).clamp(40.0, 64.0);

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _numberRow(const [1, 2, 3, 4, 5], buttonSize),
              const SizedBox(height: _gap),
              _numberRow(const [6, 7, 8, 9], buttonSize),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _PadButton(
                    icon: Icons.auto_fix_high_rounded,
                    size: actionButtonSize,
                    onTap: enabled ? onAutoFill : null,
                    onLongPress: enabled ? onAutoFillLongPress : null,
                    isHighlighted: isAutoFillMode,
                  ),
                  const SizedBox(width: 16),
                  _PadButton(
                    label: '✎',
                    size: actionButtonSize,
                    onTap: enabled ? onNotes : null,
                    isHighlighted: isNotesMode,
                  ),
                  const SizedBox(width: 16),
                  _PadButton(
                    label: '⌫',
                    size: actionButtonSize,
                    onTap: enabled ? onClear : null,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PadButton extends StatelessWidget {
  const _PadButton({
    this.label,
    this.icon,
    required this.size,
    required this.onTap,
    this.onLongPress,
    this.isHighlighted = false,
    this.hintFlags = NumberHintFlags.none,
  }) : assert(label != null || icon != null);

  final String? label;
  final IconData? icon;
  final double size;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool isHighlighted;
  final NumberHintFlags hintFlags;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final fill = colorScheme.primaryContainer.withValues(alpha: 0.26);
    final fillActive = colorScheme.primaryContainer.withValues(alpha: 0.52);
    final border = colorScheme.outlineVariant;
    final borderActive = colorScheme.primary;
    final text = colorScheme.onPrimaryContainer;

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: isHighlighted ? borderActive : border,
        width: isHighlighted ? 1.5 : 1,
      ),
    );
    return Opacity(
      opacity: onTap != null ? 1 : 0.5,
      child: Material(
        color: isHighlighted ? fillActive : fill,
        clipBehavior: Clip.antiAlias,
        shape: shape,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          customBorder: shape,
          splashColor: colorScheme.primary.withValues(alpha: 0.12),
          highlightColor: colorScheme.primary.withValues(alpha: 0.06),
          child: SizedBox(
            width: size,
            height: size,
            child: Stack(
              children: [
                Center(
                  child: icon != null
                      ? Icon(icon, size: size * 0.42, color: text)
                      : Text(
                          label!,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            fontSize: size * 0.4,
                            fontWeight: FontWeight.w600,
                            color: text,
                            height: 1.0,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                ),
                Positioned.fill(child: HintAccentBars(flags: hintFlags)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
