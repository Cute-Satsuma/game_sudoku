import 'app_localizations.dart';

class AppLocalizationsEn extends AppLocalizations {
  @override
  String get appTitle => 'CS Sudoku';

  @override
  String get sudoku => 'Sudoku';

  @override
  String get loading => 'Loading...';

  @override
  String get slogan => 'Classic Number Logic Game';

  @override
  String get freeMode => 'Free Play';

  @override
  String get campaignMode => 'Campaign';

  @override
  String get rulesTitle => 'Sudoku Rules';

  @override
  String get rulesGoal => 'Goal';

  @override
  String get rulesGoalDesc =>
      'Fill the 9×9 grid with digits 1–9 so that each row, column, '
      'and 3×3 box contains each number exactly once.';

  @override
  String get rulesBasic => 'Rules';

  @override
  String get rulesBasicItems =>
      '• No repeats in each row\n'
      '• No repeats in each column\n'
      '• No repeats in each 3×3 box\n'
      '• Given numbers cannot be changed';

  @override
  String get rulesOps => 'How to Play';

  @override
  String get rulesOpsItems =>
      '• Tap a cell to select, then tap a number to fill\n'
      '• Instant feedback: green = correct, red = wrong\n'
      '• Campaign mode has a 10-error limit';

  @override
  String get rulesGotIt => 'Got it';

  @override
  String get levelFormat => 'Level %s';

  @override
  String get errorsFormat => 'Errors: %s/%s';

  @override
  String get gameOver => 'Game Over';

  @override
  String get gameOverDesc => 'You reached %s errors. Time: %s';

  @override
  String get back => 'Back';

  @override
  String get retry => 'Retry';

  @override
  String get congrats => 'Congratulations!';

  @override
  String get congratsDesc => 'Completed in %s!';

  @override
  String get confirm => 'OK';

  @override
  String get nextLevel => 'Next';

  @override
  String get newGame => 'New Game';

  @override
  String get selectDifficulty => 'Select Difficulty';

  @override
  String get difficultyEasy => 'Easy';

  @override
  String get difficultyMedium => 'Medium';

  @override
  String get difficultyHard => 'Hard';

  @override
  String get replayLevel => 'Replay';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get campaignTitle => 'Campaign';

  @override
  String get campaignSubtitle =>
      '999 levels, difficulty increases every 9 levels';

  @override
  String get modeEasy => 'Easy';

  @override
  String get modeMedium => 'Medium';

  @override
  String get modeHard => 'Hard';

  @override
  String get modeLevels => '999 levels';

  @override
  String get startLevel => 'Start Level %s';

  @override
  String get unlockedTo => 'Unlocked to Level %s';

  @override
  String get clickToStart => 'Tap to start';

  @override
  String get unlockedToClickToStart => 'Unlocked to Level %s. Tap to start';

  // Settings & theme
  @override
  String get settingsTitle => 'Settings';
  @override
  String get aboutContent => '''Classic Sudoku puzzles.

• No ads and no account
• Progress stays on this device
• Works fully offline''';
  @override
  String get gameplayTitle => 'Gameplay';
  @override
  String get quickNumberPad => 'Quick number pad';
  @override
  String get quickNumberPadHint =>
      'Tap a selected cell again to open a compact number pad on the board.';
  @override
  String get hintModesTitle => 'Hints';
  @override
  String get hintModesHint =>
      'When a cell is selected, color marks on the number pads show digits still available in that unit.';
  @override
  String get hintBox => 'Box hints';
  @override
  String get hintBoxHint =>
      'Mark digits still free in the selected cell’s 3×3 box.';
  @override
  String get hintColumn => 'Column hints';
  @override
  String get hintColumnHint =>
      'Mark digits still free in the selected cell’s column.';
  @override
  String get hintRow => 'Row hints';
  @override
  String get hintRowHint =>
      'Mark digits still free in the selected cell’s row.';
  @override
  String get hintLegendBox => 'Box';
  @override
  String get hintLegendColumn => 'Col';
  @override
  String get hintLegendRow => 'Row';
  @override
  String get themeTitle => 'Theme';
  @override
  String get themeAppearance => 'Appearance';
  @override
  String get themeSystem => 'System';
  @override
  String get themeLight => 'Light';
  @override
  String get themeDark => 'Dark';
  @override
  String get themeColor => 'Color';
  @override
  String get themeOrange => 'Orange';
  @override
  String get themeGreen => 'Green';
  @override
  String get themeTeal => 'Teal';
  @override
  String get themeBlue => 'Blue';
  @override
  String get themeSlate => 'Slate';
  @override
  String get themePaper => 'Paper';
  @override
  String get themePaperFilter => 'Paper texture';
  @override
  String get themePaperGrain => 'Roughness';
  @override
  String get themePaperGrainFine => 'Smooth';
  @override
  String get themePaperGrainCoarse => 'Rough';
  @override
  String get themeFont => 'Font';
  @override
  String get themeIconStyle => 'Icons';
  @override
  String get iconStyleAnime => 'Playful';
  @override
  String get iconStyleBusiness => 'Business';
  @override
  String get fontRounded => 'Rounded';
  @override
  String get fontMaru => 'Maru';
  @override
  String get fontXiaoWei => 'XiaoWei';
  @override
  String get fontNunito => 'Nunito';
  @override
  String get fontSystem => 'System';
  @override
  String get themeGuideTitle => 'Change the look';
  @override
  String get themeGuideBody =>
      'Tap here to switch colors, appearance, and fonts.';
  @override
  String get themePickerTitle => 'Pick a color you like';
  @override
  String get themePickerBody =>
      'Tap a color to preview. You can change this later in Settings.';
  @override
  String get themePickerContinue => 'Choose this';
  @override
  String get themePickerPaperBody => 'Adds a light paper grain to the screen.';
}
