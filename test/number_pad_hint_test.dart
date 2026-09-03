import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_sudoku/widgets/hint_accents.dart';
import 'package:game_sudoku/widgets/number_pad.dart';

void main() {
  testWidgets('number pad keeps digits and paints hint bars', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NumberPad(
            onNumberTap: (_) {},
            onClear: () {},
            onNotes: () {},
            onAutoFill: () {},
            hintBoxNumbers: const {1},
            hintColumnNumbers: const {2},
            hintRowNumbers: const {3},
          ),
        ),
      ),
    );

    expect(find.text('1'), findsOneWidget);
    expect(find.text('9'), findsOneWidget);
    expect(find.byType(HintAccentBars), findsAtLeastNWidgets(9));
  });
}
