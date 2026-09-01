import 'package:flutter/material.dart';

List<Color> cajuHeroGradientColors(
  ColorScheme colorScheme,
  Brightness brightness,
) {
  final primary = colorScheme.primary;
  if (brightness == Brightness.dark) {
    return [
      Color.alphaBlend(primary.withValues(alpha: 0.32), const Color(0xFF121110)),
      Color.alphaBlend(primary.withValues(alpha: 0.20), colorScheme.surface),
      Color.alphaBlend(
        primary.withValues(alpha: 0.12),
        colorScheme.surfaceContainerLow,
      ),
    ];
  }
  return [
    Color.alphaBlend(Colors.black.withValues(alpha: 0.14), primary),
    Color.lerp(primary, Colors.white, 0.08)!,
    Color.alphaBlend(Colors.white.withValues(alpha: 0.28), primary),
  ];
}

BoxDecoration cajuHeroDecoration(BuildContext context) {
  final theme = Theme.of(context);
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: cajuHeroGradientColors(theme.colorScheme, theme.brightness),
    ),
  );
}

Color cajuOnHeroForeground(BuildContext context) {
  final theme = Theme.of(context);
  if (theme.brightness == Brightness.dark) {
    return Color.lerp(theme.colorScheme.onSurface, Colors.white, 0.18)!;
  }
  return Color.lerp(theme.colorScheme.primary, Colors.white, 0.88)!;
}

Color cajuHeroMutedForeground(BuildContext context) {
  return cajuOnHeroForeground(context).withValues(alpha: 0.72);
}
