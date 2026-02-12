// Basic Sudoku app test

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:game_sudoku/main.dart';

void main() {
  testWidgets('App launches and shows home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const SudokuApp(localeOverride: Locale('en')));
    await tester.pumpAndSettle();

    expect(find.text('Sudoku'), findsWidgets);
    expect(find.text('Free Play'), findsOneWidget);
  });
}
