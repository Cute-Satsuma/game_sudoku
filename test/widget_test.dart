// Basic Sudoku app test

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:game_sudoku/main.dart';
import 'package:game_sudoku/services/game_settings_controller.dart';
import 'package:game_sudoku/theme/theme_controller.dart';
import 'package:game_sudoku/widgets/sudoku_caju_logo.dart';

void main() {
  testWidgets('App launches and shows home screen', (WidgetTester tester) async {
    final themeController = ThemeController()
      ..themeGuideSeen = true
      ..themePickerSeen = true;
    await tester.pumpWidget(
      SudokuApp(
        themeController: themeController,
        gameSettings: GameSettingsController(),
        localeOverride: const Locale('en'),
      ),
    );
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.byType(SudokuCajuLogo), findsOneWidget);
    expect(find.text('Free Play'), findsOneWidget);
  });
}
