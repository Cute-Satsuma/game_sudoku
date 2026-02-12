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
  String get campaignSubtitle => '999 niveaux, difficulté croissante tous les 9 niveaux';

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
  String get unlockedToClickToStart => 'Débloqué jusqu\'au niveau %s. Appuyez pour commencer';
}
