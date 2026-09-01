import 'package:flutter/material.dart';

enum AppPalette { orange, green, teal, blue, slate, paper }

enum AppBrightnessMode { system, light, dark }

enum AppTypeface { rounded, maru, xiaowei, nunito, system }

enum AppIconStyle { anime, business }

class PaletteSpec {
  const PaletteSpec({
    required this.primary,
    required this.primarySoft,
    required this.seedLight,
    required this.seedDark,
  });

  final Color primary;
  final Color primarySoft;
  final Color seedLight;
  final Color seedDark;
}

const paletteSpecs = <AppPalette, PaletteSpec>{
  AppPalette.orange: PaletteSpec(
    primary: Color(0xFFC97A4A),
    primarySoft: Color(0xFFE8B995),
    seedLight: Color(0xFFD9956E),
    seedDark: Color(0xFFE0A882),
  ),
  AppPalette.green: PaletteSpec(
    primary: Color(0xFF5E8F6A),
    primarySoft: Color(0xFFA8C9AE),
    seedLight: Color(0xFF6F9E7A),
    seedDark: Color(0xFF8FB89A),
  ),
  AppPalette.teal: PaletteSpec(
    primary: Color(0xFF4F978D),
    primarySoft: Color(0xFF9FD0C9),
    seedLight: Color(0xFF5FA89E),
    seedDark: Color(0xFF7FBFB5),
  ),
  AppPalette.blue: PaletteSpec(
    primary: Color(0xFF5C84B3),
    primarySoft: Color(0xFFA8C4E3),
    seedLight: Color(0xFF6E94BE),
    seedDark: Color(0xFF8AADD0),
  ),
  AppPalette.slate: PaletteSpec(
    primary: Color(0xFF6E7F88),
    primarySoft: Color(0xFFB0BEC5),
    seedLight: Color(0xFF7A8C95),
    seedDark: Color(0xFF95A5AE),
  ),
  AppPalette.paper: PaletteSpec(
    primary: Color(0xFF8A7568),
    primarySoft: Color(0xFFD8C8B8),
    seedLight: Color(0xFF9A8576),
    seedDark: Color(0xFFB8A494),
  ),
};

class CajuThemeExtras extends ThemeExtension<CajuThemeExtras> {
  const CajuThemeExtras({
    required this.overlayAccent,
    required this.glyphColor,
    this.paperFilter = false,
  });

  final Color overlayAccent;
  final Color glyphColor;
  final bool paperFilter;

  @override
  CajuThemeExtras copyWith({
    Color? overlayAccent,
    Color? glyphColor,
    bool? paperFilter,
  }) {
    return CajuThemeExtras(
      overlayAccent: overlayAccent ?? this.overlayAccent,
      glyphColor: glyphColor ?? this.glyphColor,
      paperFilter: paperFilter ?? this.paperFilter,
    );
  }

  @override
  CajuThemeExtras lerp(ThemeExtension<CajuThemeExtras>? other, double t) {
    if (other is! CajuThemeExtras) return this;
    return CajuThemeExtras(
      overlayAccent: Color.lerp(overlayAccent, other.overlayAccent, t)!,
      glyphColor: Color.lerp(glyphColor, other.glyphColor, t)!,
      paperFilter: t < 0.5 ? paperFilter : other.paperFilter,
    );
  }

  static Color of(BuildContext context) {
    return Theme.of(context).extension<CajuThemeExtras>()?.overlayAccent ??
        Theme.of(context).colorScheme.primary;
  }

  static Color glyphOf(BuildContext context) {
    return Theme.of(context).extension<CajuThemeExtras>()?.glyphColor ??
        Theme.of(context).colorScheme.primary;
  }
}

ThemeMode themeModeOf(AppBrightnessMode mode) {
  switch (mode) {
    case AppBrightnessMode.system:
      return ThemeMode.system;
    case AppBrightnessMode.light:
      return ThemeMode.light;
    case AppBrightnessMode.dark:
      return ThemeMode.dark;
  }
}
