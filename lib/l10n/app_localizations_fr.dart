import 'app_localizations.dart';

class AppLocalizationsFr extends AppLocalizations {
  @override
  String get appTitle => 'CS Sudoku';

  @override
  String get sudoku => 'Sudoku';

  @override
  String get loading => 'Chargement...';

  @override
  String get slogan => 'Jeu classique de logique numérique';

  @override
  String get freeMode => 'Partie libre';

  @override
  String get campaignMode => 'Campagne';

  @override
  String get rulesTitle => 'Règles du Sudoku';

  @override
  String get rulesGoal => 'Objectif';

  @override
  String get rulesGoalDesc =>
      'Remplissez la grille 9×9 avec les chiffres de 1 à 9 pour que chaque ligne, '
      'colonne et bloc 3×3 contienne chaque nombre exactement une fois.';

  @override
  String get rulesBasic => 'Règles';

  @override
  String get rulesBasicItems =>
      '• Pas de répétition dans chaque ligne\n'
      '• Pas de répétition dans chaque colonne\n'
      '• Pas de répétition dans chaque bloc 3×3\n'
      '• Les chiffres donnés ne peuvent pas être modifiés';

  @override
  String get rulesOps => 'Comment jouer';

  @override
  String get rulesOpsItems =>
      '• Appuyez sur une cellule pour sélectionner, puis sur un chiffre pour remplir\n'
      '• Retour instantané : vert = correct, rouge = incorrect\n'
      '• Le mode campagne a une limite de 10 erreurs';

  @override
  String get rulesGotIt => 'Compris';

  @override
  String get levelFormat => 'Niveau %s';

  @override
  String get errorsFormat => 'Erreurs : %s/%s';

  @override
  String get gameOver => 'Fin de partie';

  @override
  String get gameOverDesc => 'Vous avez atteint %s erreurs. Temps : %s';

  @override
  String get back => 'Retour';

  @override
  String get retry => 'Réessayer';

  @override
  String get congrats => 'Félicitations !';

  @override
  String get congratsDesc => 'Terminé en %s !';

  @override
  String get confirm => 'OK';

  @override
  String get nextLevel => 'Suivant';

  @override
  String get newGame => 'Nouvelle partie';

  @override
  String get selectDifficulty => 'Choisir la difficulté';

  @override
  String get difficultyEasy => 'Facile';

  @override
  String get difficultyMedium => 'Moyen';

  @override
  String get difficultyHard => 'Difficile';

  @override
  String get replayLevel => 'Rejouer';

  @override
  String get difficulty => 'Difficulté';

  @override
  String get campaignTitle => 'Campagne';

  @override
  String get campaignSubtitle =>
      '999 niveaux, difficulté croissante tous les 9 niveaux';

  @override
  String get modeEasy => 'Facile';

  @override
  String get modeMedium => 'Moyen';

  @override
  String get modeHard => 'Difficile';

  @override
  String get modeLevels => '999 niveaux';

  @override
  String get startLevel => 'Commencer le niveau %s';

  @override
  String get unlockedTo => 'Débloqué jusqu\'au niveau %s';

  @override
  String get clickToStart => 'Appuyez pour commencer';

  @override
  String get unlockedToClickToStart =>
      'Débloqué jusqu\'au niveau %s. Appuyez pour commencer';

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
  String get hintModesTitle => 'Indices';
  @override
  String get hintModesHint =>
      'Après avoir choisi une case, des couleurs sur le pavé indiquent les chiffres encore libres dans cette zone.';
  @override
  String get hintBox => 'Indices de carré';
  @override
  String get hintBoxHint =>
      'Indique les chiffres encore libres dans le carré 3×3 de la case choisie.';
  @override
  String get hintColumn => 'Indices de colonne';
  @override
  String get hintColumnHint =>
      'Indique les chiffres encore libres dans la colonne de la case choisie.';
  @override
  String get hintRow => 'Indices de ligne';
  @override
  String get hintRowHint =>
      'Indique les chiffres encore libres dans la ligne de la case choisie.';
  @override
  String get hintLegendBox => 'Carré';
  @override
  String get hintLegendColumn => 'Col.';
  @override
  String get hintLegendRow => 'Ligne';
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
  String get themeGuideTitle => "Changez l'apparence";
  @override
  String get themeGuideBody =>
      "Appuyez ici pour changer les couleurs, l'apparence et les polices.";
  @override
  String get themePickerTitle => 'Choisissez une couleur';
  @override
  String get themePickerBody =>
      'Touchez une couleur pour prévisualiser. Vous pourrez la changer plus tard dans Réglages.';
  @override
  String get themePickerContinue => 'Choisir celle-ci';
  @override
  String get themePickerPaperBody =>
      "Ajoute un léger grain de papier à l'écran.";
}
