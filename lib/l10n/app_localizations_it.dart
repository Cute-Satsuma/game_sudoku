import 'app_localizations.dart';

class AppLocalizationsIt extends AppLocalizations {
  @override
  String get appTitle => 'CS Sudoku';

  @override
  String get sudoku => 'Sudoku';

  @override
  String get loading => 'Caricamento...';

  @override
  String get slogan => 'Gioco classico di logica numerica';

  @override
  String get freeMode => 'Gioco libero';

  @override
  String get campaignMode => 'Campagna';

  @override
  String get rulesTitle => 'Regole del Sudoku';

  @override
  String get rulesGoal => 'Obiettivo';

  @override
  String get rulesGoalDesc =>
      'Riempi la griglia 9×9 con le cifre da 1 a 9 in modo che ogni riga, '
      'colonna e riquadro 3×3 contenga ogni numero esattamente una volta.';

  @override
  String get rulesBasic => 'Regole';

  @override
  String get rulesBasicItems =>
      '• Nessuna ripetizione in ogni riga\n'
      '• Nessuna ripetizione in ogni colonna\n'
      '• Nessuna ripetizione in ogni riquadro 3×3\n'
      '• I numeri dati non possono essere modificati';

  @override
  String get rulesOps => 'Come giocare';

  @override
  String get rulesOpsItems =>
      '• Tocca una cella per selezionare, poi tocca un numero per riempire\n'
      '• Feedback immediato: verde = corretto, rosso = sbagliato\n'
      '• La modalità campagna ha un limite di 10 errori';

  @override
  String get rulesGotIt => 'Capito';

  @override
  String get levelFormat => 'Livello %s';

  @override
  String get errorsFormat => 'Errori: %s/%s';

  @override
  String get gameOver => 'Game over';

  @override
  String get gameOverDesc => 'Hai raggiunto %s errori. Tempo: %s';

  @override
  String get back => 'Indietro';

  @override
  String get retry => 'Riprova';

  @override
  String get congrats => 'Congratulazioni!';

  @override
  String get congratsDesc => 'Completato in %s!';

  @override
  String get confirm => 'OK';

  @override
  String get nextLevel => 'Avanti';

  @override
  String get newGame => 'Nuova partita';

  @override
  String get selectDifficulty => 'Seleziona difficoltà';

  @override
  String get difficultyEasy => 'Facile';

  @override
  String get difficultyMedium => 'Medio';

  @override
  String get difficultyHard => 'Difficile';

  @override
  String get replayLevel => 'Riprova';

  @override
  String get difficulty => 'Difficoltà';

  @override
  String get campaignTitle => 'Campagna';

  @override
  String get campaignSubtitle => '999 livelli, difficoltà aumenta ogni 9 livelli';

  @override
  String get modeEasy => 'Facile';

  @override
  String get modeMedium => 'Medio';

  @override
  String get modeHard => 'Difficile';

  @override
  String get modeLevels => '999 livelli';

  @override
  String get startLevel => 'Inizia livello %s';

  @override
  String get unlockedTo => 'Sbloccato fino al livello %s';

  @override
  String get clickToStart => 'Tocca per iniziare';

  @override
  String get unlockedToClickToStart => 'Sbloccato fino al livello %s. Tocca per iniziare';
}
