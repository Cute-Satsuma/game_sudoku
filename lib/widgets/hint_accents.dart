import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/game_settings_controller.dart';
import '../sudoku/hint_candidates.dart';

/// Fixed colors so box / column / row stay recognizable across palettes.
class HintAccentColors {
  HintAccentColors._();

  static Color boxOf(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFFD8902E)
        : const Color(0xFFB45F0E);
  }

  static Color columnOf(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF3E8FD0)
        : const Color(0xFF1F5F96);
  }

  static Color rowOf(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF4AA85A)
        : const Color(0xFF2D6F38);
  }
}

/// Short capsule marks on a number key: top = box, right = column, bottom = row.
class HintAccentBars extends StatelessWidget {
  const HintAccentBars({super.key, required this.flags});

  final NumberHintFlags flags;

  static const _thickness = 1.5;
  static const _inset = 4.0;
  static const _lengthFactor = 0.21;

  @override
  Widget build(BuildContext context) {
    if (!flags.any) return const SizedBox.shrink();

    final box = HintAccentColors.boxOf(context);
    final column = HintAccentColors.columnOf(context);
    final row = HintAccentColors.rowOf(context);

    return IgnorePointer(
      child: SizedBox.expand(
        child: Stack(
          children: [
            if (flags.box)
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: _inset),
                  child: FractionallySizedBox(
                    widthFactor: _lengthFactor,
                    child: SizedBox(
                      height: _thickness,
                      child: _HintCapsule(color: box),
                    ),
                  ),
                ),
              ),
            if (flags.column)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: _inset),
                  child: FractionallySizedBox(
                    heightFactor: _lengthFactor,
                    child: SizedBox(
                      width: _thickness,
                      child: _HintCapsule(color: column),
                    ),
                  ),
                ),
              ),
            if (flags.row)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: _inset),
                  child: FractionallySizedBox(
                    widthFactor: _lengthFactor,
                    child: SizedBox(
                      height: _thickness,
                      child: _HintCapsule(color: row),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _HintCapsule extends StatelessWidget {
  const _HintCapsule({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}

class HintLegend extends StatelessWidget {
  const HintLegend({
    super.key,
    required this.boxEnabled,
    required this.columnEnabled,
    required this.rowEnabled,
    required this.boxLabel,
    required this.columnLabel,
    required this.rowLabel,
    this.onTap,
  });

  final bool boxEnabled;
  final bool columnEnabled;
  final bool rowEnabled;
  final String boxLabel;
  final String columnLabel;
  final String rowLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _LegendItem(
                  color: HintAccentColors.boxOf(context),
                  label: boxLabel,
                  enabled: boxEnabled,
                  vertical: false,
                ),
                const SizedBox(width: 12),
                _LegendItem(
                  color: HintAccentColors.columnOf(context),
                  label: columnLabel,
                  enabled: columnEnabled,
                  vertical: true,
                ),
                const SizedBox(width: 12),
                _LegendItem(
                  color: HintAccentColors.rowOf(context),
                  label: rowLabel,
                  enabled: rowEnabled,
                  vertical: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HintColorChip extends StatelessWidget {
  const HintColorChip({super.key, required this.color, this.size = 10});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.color,
    required this.label,
    required this.enabled,
    required this.vertical,
  });

  final Color color;
  final String label;
  final bool enabled;
  final bool vertical;

  static const _barThickness = 1.5;
  static const _barLength = 10.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final barColor = enabled
        ? color.withValues(alpha: 0.72)
        : colorScheme.onSurface.withValues(alpha: 0.16);
    return Semantics(
      label: label,
      child: SizedBox(
        width: vertical ? _barThickness : _barLength,
        height: vertical ? _barLength : _barThickness,
        child: _HintCapsule(color: barColor),
      ),
    );
  }
}

class HintModeSwitchRow extends StatelessWidget {
  const HintModeSwitchRow({
    super.key,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final Color color;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            HintColorChip(color: color),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
            ),
            Switch(value: value, onChanged: onChanged),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              height: 1.4,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}

Future<void> showHintModesDialog(BuildContext context) {
  final l10n = AppLocalizations.of(context);
  return showDialog<void>(
    context: context,
    builder: (ctx) {
      final settings = GameSettingsScope.of(ctx);
      return AlertDialog(
        title: Text(l10n.hintModesTitle),
        content: ListenableBuilder(
          listenable: settings,
          builder: (context, _) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.hintModesHint,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      height: 1.4,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),
                  HintModeSwitchRow(
                    color: HintAccentColors.boxOf(context),
                    title: l10n.hintBox,
                    subtitle: l10n.hintBoxHint,
                    value: settings.hintBoxEnabled,
                    onChanged: settings.setHintBoxEnabled,
                  ),
                  const SizedBox(height: 10),
                  HintModeSwitchRow(
                    color: HintAccentColors.columnOf(context),
                    title: l10n.hintColumn,
                    subtitle: l10n.hintColumnHint,
                    value: settings.hintColumnEnabled,
                    onChanged: settings.setHintColumnEnabled,
                  ),
                  const SizedBox(height: 10),
                  HintModeSwitchRow(
                    color: HintAccentColors.rowOf(context),
                    title: l10n.hintRow,
                    subtitle: l10n.hintRowHint,
                    value: settings.hintRowEnabled,
                    onChanged: settings.setHintRowEnabled,
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.confirm),
          ),
        ],
      );
    },
  );
}
