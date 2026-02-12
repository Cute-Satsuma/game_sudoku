import 'package:flutter/material.dart';

class NumberPad extends StatelessWidget {
  const NumberPad({
    super.key,
    required this.onNumberTap,
    required this.onClear,
    required this.onNotes,
    this.isNotesMode = false,
    this.enabled = true,
  });

  final void Function(int number) onNumberTap;
  final VoidCallback onClear;
  final VoidCallback onNotes;
  final bool isNotesMode;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate button size from available width to avoid overflow
        final availableWidth = constraints.maxWidth - 32; // minus padding
        final buttonSize = (availableWidth / 9).clamp(32.0, 56.0);
        final actionButtonSize = (buttonSize * 0.8).clamp(28.0, 48.0);

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 1; i <= 9; i++)
                    _PadButton(
                      label: i.toString(),
                      size: buttonSize,
                      onTap: enabled ? () => onNumberTap(i) : null,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
    required this.label,
    required this.size,
    required this.onTap,
    this.isHighlighted = false,
  });

  final String label;
  final double size;
  final VoidCallback? onTap;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onTap != null ? 1 : 0.5,
      child: Material(
        color: isHighlighted ? Colors.blue.shade100 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: size,
            height: size,
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: size * 0.4,
                  fontWeight: FontWeight.w600,
                  color: isHighlighted ? Colors.blue.shade700 : Colors.black87,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
