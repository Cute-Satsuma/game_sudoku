import 'package:flutter/foundation.dart';
import 'package:game_sudoku/theme/app_palette.dart';

/// Sudoku does not switch launcher icons yet; keep API aligned with QR Scan Caju.
Future<void> syncLauncherIcon(AppIconStyle style) async {
  if (kIsWeb) return;
}
