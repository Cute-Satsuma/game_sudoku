import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:game_sudoku/l10n/app_localizations.dart';
import 'package:game_sudoku/theme/app_palette.dart';
import 'package:game_sudoku/theme/theme_controller.dart';

class ThemePickerDialog extends StatelessWidget {
  const ThemePickerDialog({super.key, this.quick = false});

  /// 首页标题等入口：可关闭、点选即保存。首次引导保持不可关闭。
  final bool quick;

  static String paletteLabel(AppLocalizations l10n, AppPalette palette) {
    switch (palette) {
      case AppPalette.orange:
        return l10n.themeOrange;
      case AppPalette.green:
        return l10n.themeGreen;
      case AppPalette.teal:
        return l10n.themeTeal;
      case AppPalette.blue:
        return l10n.themeBlue;
      case AppPalette.slate:
        return l10n.themeSlate;
      case AppPalette.paper:
        return l10n.themePaper;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final controller = ThemeScope.of(context);
    return PopScope(
      canPop: quick,
      child: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          final colorScheme = Theme.of(context).colorScheme;
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 24,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.themePickerTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (!quick) ...[
                    const SizedBox(height: 8),
                    Text(
                      l10n.themePickerBody,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        height: 1.45,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.78,
                    children: [
                      for (final palette in AppPalette.values)
                        _PickerSwatch(
                          palette: palette,
                          label: paletteLabel(l10n, palette),
                          selected: controller.palette == palette,
                          onTap: () => controller.setPalette(
                            palette,
                            persist: quick,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              width: 44,
                              height: 44,
                              child: CustomPaint(
                                painter: _PaperPreviewPainter(
                                  enabled: controller.paperFilter,
                                  tint: colorScheme.primary,
                                  dark:
                                      Theme.of(context).brightness ==
                                      Brightness.dark,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.themePaperFilter,
                                  style: Theme.of(context).textTheme.labelLarge
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  l10n.themePickerPaperBody,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        height: 1.35,
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: controller.paperFilter,
                            onChanged: (value) => controller.setPaperFilter(
                              value,
                              persist: quick,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton(
                      onPressed: () async {
                        await controller.setPalette(controller.palette);
                        await controller.setPaperFilter(controller.paperFilter);
                        if (context.mounted) Navigator.pop(context);
                      },
                      child: Text(l10n.themePickerContinue),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PickerSwatch extends StatelessWidget {
  const _PickerSwatch({
    required this.palette,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final AppPalette palette;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final spec = paletteSpecs[palette]!;
    final swatch = palette == AppPalette.paper
        ? const Color(0xFFE6D3B0)
        : spec.primary;
    final checkColor = palette == AppPalette.paper
        ? spec.primary
        : Colors.white;
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Material(
            type: MaterialType.transparency,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              customBorder: const CircleBorder(),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 52,
                height: 52,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected
                        ? spec.primary
                        : colorScheme.outline.withValues(alpha: 0.28),
                    width: selected ? 2.5 : 1,
                  ),
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: swatch,
                  ),
                  child: selected
                      ? Icon(Icons.check, size: 22, color: checkColor)
                      : const SizedBox.expand(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              height: 1.15,
              leadingDistribution: TextLeadingDistribution.even,
              color: selected ? spec.primary : colorScheme.onSurfaceVariant,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _PaperPreviewPainter extends CustomPainter {
  const _PaperPreviewPainter({
    required this.enabled,
    required this.tint,
    required this.dark,
  });

  final bool enabled;
  final Color tint;
  final bool dark;

  @override
  void paint(Canvas canvas, Size size) {
    final base = dark ? const Color(0xFF2A241C) : const Color(0xFFF6EFE4);
    canvas.drawRect(Offset.zero & size, Paint()..color = base);
    if (!enabled) return;
    final wash = Color.lerp(const Color(0xFFD4B896), tint, 0.28)!;
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = wash.withValues(alpha: dark ? 0.22 : 0.18),
    );
    final random = math.Random(11);
    final speckle = Paint()..style = PaintingStyle.fill;
    for (var i = 0; i < 70; i++) {
      speckle.color =
          (random.nextBool()
                  ? (dark ? const Color(0xFFE8D9C0) : const Color(0xFF5D4037))
                  : (dark ? const Color(0xFF1A140E) : const Color(0xFFFFF8E8)))
              .withValues(alpha: 0.28);
      canvas.drawCircle(
        Offset(
          random.nextDouble() * size.width,
          random.nextDouble() * size.height,
        ),
        0.4 + random.nextDouble() * 0.9,
        speckle,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _PaperPreviewPainter oldDelegate) {
    return oldDelegate.enabled != enabled ||
        oldDelegate.tint != tint ||
        oldDelegate.dark != dark;
  }
}
