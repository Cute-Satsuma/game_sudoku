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
  String get campaignSubtitle => '999 уровней, сложность растёт каждые 9 уровней';

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
  String get unlockedToClickToStart => 'Разблокировано до уровня %s. Нажмите для начала';
}
