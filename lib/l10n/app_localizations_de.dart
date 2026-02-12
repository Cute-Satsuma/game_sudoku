import 'app_localizations.dart';

class AppLocalizationsDe extends AppLocalizations {
  @override
  String get appTitle => 'CS Sudoku';

  @override
  String get sudoku => 'Sudoku';

  @override
  String get loading => 'Laden...';

  @override
  String get slogan => 'Klassisches Zahlenlogik-Spiel';

  @override
  String get freeMode => 'Freies Spiel';

  @override
  String get campaignMode => 'Kampagne';

  @override
  String get rulesTitle => 'Sudoku-Regeln';

  @override
  String get rulesGoal => 'Ziel';

  @override
  String get rulesGoalDesc =>
      'Füllen Sie das 9×9-Raster mit den Ziffern 1–9, sodass jede Zeile, '
      'Spalte und jedes 3×3-Feld jede Zahl genau einmal enthält.';

  @override
  String get rulesBasic => 'Regeln';

  @override
  String get rulesBasicItems =>
      '• Keine Wiederholungen in jeder Zeile\n'
      '• Keine Wiederholungen in jeder Spalte\n'
      '• Keine Wiederholungen in jedem 3×3-Feld\n'
      '• Vorgegebene Zahlen können nicht geändert werden';

  @override
  String get rulesOps => 'Spielanleitung';

  @override
  String get rulesOpsItems =>
      '• Tippen Sie auf eine Zelle zur Auswahl, dann auf eine Zahl zum Ausfüllen\n'
      '• Sofortiges Feedback: Grün = richtig, Rot = falsch\n'
      '• Kampagnenmodus hat ein Limit von 10 Fehlern';

  @override
  String get rulesGotIt => 'Verstanden';

  @override
  String get levelFormat => 'Level %s';

  @override
  String get errorsFormat => 'Fehler: %s/%s';

  @override
  String get gameOver => 'Spiel vorbei';

  @override
  String get gameOverDesc => 'Sie haben %s Fehler erreicht. Zeit: %s';

  @override
  String get back => 'Zurück';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get congrats => 'Herzlichen Glückwunsch!';

  @override
  String get congratsDesc => 'Abgeschlossen in %s!';

  @override
  String get confirm => 'OK';

  @override
  String get nextLevel => 'Weiter';

  @override
  String get newGame => 'Neues Spiel';

  @override
  String get selectDifficulty => 'Schwierigkeit wählen';

  @override
  String get difficultyEasy => 'Einfach';

  @override
  String get difficultyMedium => 'Mittel';

  @override
  String get difficultyHard => 'Schwer';

  @override
  String get replayLevel => 'Wiederholen';

  @override
  String get difficulty => 'Schwierigkeit';

  @override
  String get campaignTitle => 'Kampagne';

  @override
  String get campaignSubtitle => '999 Level, Schwierigkeit steigt alle 9 Level';

  @override
  String get modeEasy => 'Einfach';

  @override
  String get modeMedium => 'Mittel';

  @override
  String get modeHard => 'Schwer';

  @override
  String get modeLevels => '999 Level';

  @override
  String get startLevel => 'Level %s starten';

  @override
  String get unlockedTo => 'Freigeschaltet bis Level %s';

  @override
  String get clickToStart => 'Tippen zum Starten';

  @override
  String get unlockedToClickToStart => 'Freigeschaltet bis Level %s. Tippen zum Starten';
}
