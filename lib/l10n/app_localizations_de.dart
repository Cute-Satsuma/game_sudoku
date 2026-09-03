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
  String get unlockedToClickToStart =>
      'Freigeschaltet bis Level %s. Tippen zum Starten';

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
  String get hintModesTitle => 'Hinweise';
  @override
  String get hintModesHint =>
      'Nach dem Auswählen eines Feldes markieren Farben auf den Zahlenfeldern noch freie Ziffern in diesem Bereich.';
  @override
  String get hintBox => 'Block-Hinweise';
  @override
  String get hintBoxHint =>
      'Zeigt Ziffern, die im 3×3-Block des gewählten Feldes noch frei sind.';
  @override
  String get hintColumn => 'Spalten-Hinweise';
  @override
  String get hintColumnHint =>
      'Zeigt Ziffern, die in der Spalte des gewählten Feldes noch frei sind.';
  @override
  String get hintRow => 'Zeilen-Hinweise';
  @override
  String get hintRowHint =>
      'Zeigt Ziffern, die in der Zeile des gewählten Feldes noch frei sind.';
  @override
  String get hintLegendBox => 'Block';
  @override
  String get hintLegendColumn => 'Spalte';
  @override
  String get hintLegendRow => 'Zeile';
  @override
  String get themeTitle => 'Design';
  @override
  String get themeAppearance => 'Darstellung';
  @override
  String get themeSystem => 'System';
  @override
  String get themeLight => 'Hell';
  @override
  String get themeDark => 'Dunkel';
  @override
  String get themeColor => 'Farbe';
  @override
  String get themeOrange => 'Orange';
  @override
  String get themeGreen => 'Grün';
  @override
  String get themeTeal => 'Petrol';
  @override
  String get themeBlue => 'Blau';
  @override
  String get themeSlate => 'Schiefer';
  @override
  String get themePaper => 'Papier';
  @override
  String get themePaperFilter => 'Papiertextur';
  @override
  String get themePaperGrain => 'Rauheit';
  @override
  String get themePaperGrainFine => 'Glatt';
  @override
  String get themePaperGrainCoarse => 'Rau';
  @override
  String get themeFont => 'Schrift';
  @override
  String get themeIconStyle => 'Symbole';
  @override
  String get iconStyleAnime => 'Verspielt';
  @override
  String get iconStyleBusiness => 'Business';
  @override
  String get fontRounded => 'Rund';
  @override
  String get fontMaru => 'Maru';
  @override
  String get fontXiaoWei => 'XiaoWei';
  @override
  String get fontNunito => 'Nunito';
  @override
  String get fontSystem => 'System';
  @override
  String get themeGuideTitle => 'Erscheinungsbild ändern';
  @override
  String get themeGuideBody =>
      'Tippe hier, um Farben, Erscheinungsbild und Schriften zu ändern.';
  @override
  String get themePickerTitle => 'Wähle eine Farbe';
  @override
  String get themePickerBody =>
      'Tippe eine Farbe zum Vorschau. Später kannst du sie in den Einstellungen ändern.';
  @override
  String get themePickerContinue => 'Diese wählen';
  @override
  String get themePickerPaperBody =>
      'Legt eine leichte Papiertextur über den Bildschirm.';
}
