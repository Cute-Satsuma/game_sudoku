import 'app_localizations.dart';

class AppLocalizationsPt extends AppLocalizations {
  @override
  String get appTitle => 'CS Sudoku';

  @override
  String get sudoku => 'Sudoku';

  @override
  String get loading => 'Carregando...';

  @override
  String get slogan => 'Jogo clássico de lógica numérica';

  @override
  String get freeMode => 'Jogo livre';

  @override
  String get campaignMode => 'Campanha';

  @override
  String get rulesTitle => 'Regras do Sudoku';

  @override
  String get rulesGoal => 'Objetivo';

  @override
  String get rulesGoalDesc =>
      'Preencha a grade 9×9 com dígitos de 1 a 9 para que cada linha, '
      'coluna e caixa 3×3 contenha cada número exatamente uma vez.';

  @override
  String get rulesBasic => 'Regras';

  @override
  String get rulesBasicItems =>
      '• Sem repetições em cada linha\n'
      '• Sem repetições em cada coluna\n'
      '• Sem repetições em cada caixa 3×3\n'
      '• Os números dados não podem ser alterados';

  @override
  String get rulesOps => 'Como jogar';

  @override
  String get rulesOpsItems =>
      '• Toque em uma célula para selecionar, depois toque em um número para preencher\n'
      '• Feedback instantâneo: verde = correto, vermelho = errado\n'
      '• O modo campanha tem limite de 10 erros';

  @override
  String get rulesGotIt => 'Entendi';

  @override
  String get levelFormat => 'Nível %s';

  @override
  String get errorsFormat => 'Erros: %s/%s';

  @override
  String get gameOver => 'Fim de jogo';

  @override
  String get gameOverDesc => 'Você atingiu %s erros. Tempo: %s';

  @override
  String get back => 'Voltar';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get congrats => 'Parabéns!';

  @override
  String get congratsDesc => 'Concluído em %s!';

  @override
  String get confirm => 'OK';

  @override
  String get nextLevel => 'Próximo';

  @override
  String get newGame => 'Novo jogo';

  @override
  String get selectDifficulty => 'Selecionar dificuldade';

  @override
  String get difficultyEasy => 'Fácil';

  @override
  String get difficultyMedium => 'Médio';

  @override
  String get difficultyHard => 'Difícil';

  @override
  String get replayLevel => 'Repetir';

  @override
  String get difficulty => 'Dificuldade';

  @override
  String get campaignTitle => 'Campanha';

  @override
  String get campaignSubtitle =>
      '999 níveis, dificuldade aumenta a cada 9 níveis';

  @override
  String get modeEasy => 'Fácil';

  @override
  String get modeMedium => 'Médio';

  @override
  String get modeHard => 'Difícil';

  @override
  String get modeLevels => '999 níveis';

  @override
  String get startLevel => 'Iniciar nível %s';

  @override
  String get unlockedTo => 'Desbloqueado até o nível %s';

  @override
  String get clickToStart => 'Toque para começar';

  @override
  String get unlockedToClickToStart =>
      'Desbloqueado até o nível %s. Toque para começar';

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
  String get themeTitle => 'Tema';
  @override
  String get themeAppearance => 'Aparência';
  @override
  String get themeSystem => 'Sistema';
  @override
  String get themeLight => 'Claro';
  @override
  String get themeDark => 'Escuro';
  @override
  String get themeColor => 'Cor';
  @override
  String get themeOrange => 'Laranja';
  @override
  String get themeGreen => 'Verde';
  @override
  String get themeTeal => 'Teal';
  @override
  String get themeBlue => 'Azul';
  @override
  String get themeSlate => 'Ardósia';
  @override
  String get themePaper => 'Papel';
  @override
  String get themePaperFilter => 'Textura de papel';
  @override
  String get themePaperGrain => 'Rugosidade';
  @override
  String get themePaperGrainFine => 'Liso';
  @override
  String get themePaperGrainCoarse => 'Áspero';
  @override
  String get themeFont => 'Fonte';
  @override
  String get themeIconStyle => 'Ícones';
  @override
  String get iconStyleAnime => 'Ilustrado';
  @override
  String get iconStyleBusiness => 'Executivo';
  @override
  String get fontRounded => 'Arredondada';
  @override
  String get fontMaru => 'Maru';
  @override
  String get fontXiaoWei => 'XiaoWei';
  @override
  String get fontNunito => 'Nunito';
  @override
  String get fontSystem => 'Sistema';
  @override
  String get themeGuideTitle => 'Mude o visual';
  @override
  String get themeGuideBody =>
      'Toque aqui para alterar cores, aparência e fontes.';
  @override
  String get themePickerTitle => 'Escolha uma cor';
  @override
  String get themePickerBody =>
      'Toque numa cor para pré-visualizar. Depois pode mudar em Definições.';
  @override
  String get themePickerContinue => 'Escolher esta';
  @override
  String get themePickerPaperBody =>
      'Adiciona uma leve textura de papel à tela.';
}
