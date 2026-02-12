import 'app_localizations.dart';

class AppLocalizationsEs extends AppLocalizations {
  @override
  String get appTitle => 'CS Sudoku';

  @override
  String get sudoku => 'Sudoku';

  @override
  String get loading => 'Cargando...';

  @override
  String get slogan => 'Juego clásico de lógica numérica';

  @override
  String get freeMode => 'Juego libre';

  @override
  String get campaignMode => 'Campaña';

  @override
  String get rulesTitle => 'Reglas del Sudoku';

  @override
  String get rulesGoal => 'Objetivo';

  @override
  String get rulesGoalDesc =>
      'Completa la cuadrícula 9×9 con dígitos del 1 al 9 de modo que cada fila, '
      'columna y caja 3×3 contenga cada número exactamente una vez.';

  @override
  String get rulesBasic => 'Reglas';

  @override
  String get rulesBasicItems =>
      '• Sin repeticiones en cada fila\n'
      '• Sin repeticiones en cada columna\n'
      '• Sin repeticiones en cada caja 3×3\n'
      '• Los números dados no se pueden cambiar';

  @override
  String get rulesOps => 'Cómo jugar';

  @override
  String get rulesOpsItems =>
      '• Toca una celda para seleccionar, luego toca un número para rellenar\n'
      '• Retroalimentación instantánea: verde = correcto, rojo = incorrecto\n'
      '• El modo campaña tiene un límite de 10 errores';

  @override
  String get rulesGotIt => 'Entendido';

  @override
  String get levelFormat => 'Nivel %s';

  @override
  String get errorsFormat => 'Errores: %s/%s';

  @override
  String get gameOver => 'Fin del juego';

  @override
  String get gameOverDesc => 'Alcanzaste %s errores. Tiempo: %s';

  @override
  String get back => 'Atrás';

  @override
  String get retry => 'Reintentar';

  @override
  String get congrats => '¡Felicitaciones!';

  @override
  String get congratsDesc => '¡Completado en %s!';

  @override
  String get confirm => 'OK';

  @override
  String get nextLevel => 'Siguiente';

  @override
  String get newGame => 'Nueva partida';

  @override
  String get selectDifficulty => 'Seleccionar dificultad';

  @override
  String get difficultyEasy => 'Fácil';

  @override
  String get difficultyMedium => 'Medio';

  @override
  String get difficultyHard => 'Difícil';

  @override
  String get replayLevel => 'Repetir';

  @override
  String get difficulty => 'Dificultad';

  @override
  String get campaignTitle => 'Campaña';

  @override
  String get campaignSubtitle => '999 niveles, la dificultad aumenta cada 9 niveles';

  @override
  String get modeEasy => 'Fácil';

  @override
  String get modeMedium => 'Medio';

  @override
  String get modeHard => 'Difícil';

  @override
  String get modeLevels => '999 niveles';

  @override
  String get startLevel => 'Iniciar nivel %s';

  @override
  String get unlockedTo => 'Desbloqueado hasta el nivel %s';

  @override
  String get clickToStart => 'Toca para comenzar';

  @override
  String get unlockedToClickToStart => 'Desbloqueado hasta el nivel %s. Toca para comenzar';
}
