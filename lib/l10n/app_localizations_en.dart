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
  String get campaignSubtitle => '999 levels, difficulty increases every 9 levels';

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
}
