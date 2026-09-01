import 'app_localizations.dart';

class AppLocalizationsRu extends AppLocalizations {
  @override
  String get appTitle => 'CS Судоку';

  @override
  String get sudoku => 'Судоку';

  @override
  String get loading => 'Загрузка...';

  @override
  String get slogan => 'Классическая числовая логическая игра';

  @override
  String get freeMode => 'Свободная игра';

  @override
  String get campaignMode => 'Кампания';

  @override
  String get rulesTitle => 'Правила судоку';

  @override
  String get rulesGoal => 'Цель';

  @override
  String get rulesGoalDesc =>
      'Заполните сетку 9×9 цифрами от 1 до 9 так, чтобы каждая строка, '
      'столбец и блок 3×3 содержали каждую цифру ровно один раз.';

  @override
  String get rulesBasic => 'Правила';

  @override
  String get rulesBasicItems =>
      '• Без повторов в каждой строке\n'
      '• Без повторов в каждом столбце\n'
      '• Без повторов в каждом блоке 3×3\n'
      '• Исходные цифры нельзя менять';

  @override
  String get rulesOps => 'Как играть';

  @override
  String get rulesOpsItems =>
      '• Нажмите на ячейку для выбора, затем на цифру для ввода\n'
      '• Мгновенная обратная связь: зелёный = верно, красный = неверно\n'
      '• В режиме кампании лимит 10 ошибок';

  @override
  String get rulesGotIt => 'Понятно';

  @override
  String get levelFormat => 'Уровень %s';

  @override
  String get errorsFormat => 'Ошибки: %s/%s';

  @override
  String get gameOver => 'Конец игры';

  @override
  String get gameOverDesc => 'Вы допустили %s ошибок. Время: %s';

  @override
  String get back => 'Назад';

  @override
  String get retry => 'Повторить';

  @override
  String get congrats => 'Поздравляем!';

  @override
  String get congratsDesc => 'Завершено за %s!';

  @override
  String get confirm => 'OK';

  @override
  String get nextLevel => 'Далее';

  @override
  String get newGame => 'Новая игра';

  @override
  String get selectDifficulty => 'Выбрать сложность';

  @override
  String get difficultyEasy => 'Лёгкий';

  @override
  String get difficultyMedium => 'Средний';

  @override
  String get difficultyHard => 'Сложный';

  @override
  String get replayLevel => 'Повторить';

  @override
  String get difficulty => 'Сложность';

  @override
  String get campaignTitle => 'Кампания';

  @override
  String get campaignSubtitle =>
      '999 уровней, сложность растёт каждые 9 уровней';

  @override
  String get modeEasy => 'Лёгкий';

  @override
  String get modeMedium => 'Средний';

  @override
  String get modeHard => 'Сложный';

  @override
  String get modeLevels => '999 уровней';

  @override
  String get startLevel => 'Начать уровень %s';

  @override
  String get unlockedTo => 'Разблокировано до уровня %s';

  @override
  String get clickToStart => 'Нажмите для начала';

  @override
  String get unlockedToClickToStart =>
      'Разблокировано до уровня %s. Нажмите для начала';

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
  String get themeTitle => 'Тема';
  @override
  String get themeAppearance => 'Оформление';
  @override
  String get themeSystem => 'Система';
  @override
  String get themeLight => 'Светлая';
  @override
  String get themeDark => 'Тёмная';
  @override
  String get themeColor => 'Цвет';
  @override
  String get themeOrange => 'Оранжевый';
  @override
  String get themeGreen => 'Зелёный';
  @override
  String get themeTeal => 'Бирюза';
  @override
  String get themeBlue => 'Синий';
  @override
  String get themeSlate => 'Графит';
  @override
  String get themePaper => 'Бумага';
  @override
  String get themePaperFilter => 'Бумажная текстура';
  @override
  String get themePaperGrain => 'Шероховатость';
  @override
  String get themePaperGrainFine => 'Гладкая';
  @override
  String get themePaperGrainCoarse => 'Шершавая';
  @override
  String get themeFont => 'Шрифт';
  @override
  String get themeIconStyle => 'Значки';
  @override
  String get iconStyleAnime => 'Мульт';
  @override
  String get iconStyleBusiness => 'Деловой';
  @override
  String get fontRounded => 'Скруглённый';
  @override
  String get fontMaru => 'Maru';
  @override
  String get fontXiaoWei => 'XiaoWei';
  @override
  String get fontNunito => 'Nunito';
  @override
  String get fontSystem => 'Система';
  @override
  String get themeGuideTitle => 'Смените оформление';
  @override
  String get themeGuideBody =>
      'Нажмите здесь, чтобы сменить цвета, вид и шрифты.';
  @override
  String get themePickerTitle => 'Выберите цвет';
  @override
  String get themePickerBody =>
      'Нажмите цвет для предпросмотра. Позже его можно сменить в настройках.';
  @override
  String get themePickerContinue => 'Выбрать этот';
  @override
  String get themePickerPaperBody =>
      'Добавляет лёгкую бумажную текстуру на экран.';
}
