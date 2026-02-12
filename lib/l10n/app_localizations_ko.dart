import 'app_localizations.dart';

class AppLocalizationsKo extends AppLocalizations {
  @override
  String get appTitle => 'CS 스도쿠';

  @override
  String get sudoku => '스도쿠';

  @override
  String get loading => '로딩 중...';

  @override
  String get slogan => '클래식 숫자 논리 게임';

  @override
  String get freeMode => '자유 플레이';

  @override
  String get campaignMode => '캠페인';

  @override
  String get rulesTitle => '스도쿠 규칙';

  @override
  String get rulesGoal => '목표';

  @override
  String get rulesGoalDesc =>
      '9×9 그리드에 1~9 숫자를 채워 각 행, 열, 3×3 박스에 '
      '각 숫자가 정확히 한 번씩만 들어가도록 하세요.';

  @override
  String get rulesBasic => '규칙';

  @override
  String get rulesBasicItems =>
      '• 각 행에 중복 없음\n'
      '• 각 열에 중복 없음\n'
      '• 각 3×3 박스에 중복 없음\n'
      '• 주어진 숫자는 변경 불가';

  @override
  String get rulesOps => '플레이 방법';

  @override
  String get rulesOpsItems =>
      '• 셀을 탭하여 선택한 후 숫자를 탭하여 입력\n'
      '• 즉시 피드백: 초록 = 정답, 빨강 = 오답\n'
      '• 캠페인 모드는 오류 10회 제한';

  @override
  String get rulesGotIt => '알겠습니다';

  @override
  String get levelFormat => '레벨 %s';

  @override
  String get errorsFormat => '오류: %s/%s';

  @override
  String get gameOver => '게임 오버';

  @override
  String get gameOverDesc => '%s회 오류에 도달했습니다. 시간: %s';

  @override
  String get back => '뒤로';

  @override
  String get retry => '다시 시도';

  @override
  String get congrats => '축하합니다!';

  @override
  String get congratsDesc => '%s에 완료!';

  @override
  String get confirm => '확인';

  @override
  String get nextLevel => '다음';

  @override
  String get newGame => '새 게임';

  @override
  String get selectDifficulty => '난이도 선택';

  @override
  String get difficultyEasy => '쉬움';

  @override
  String get difficultyMedium => '보통';

  @override
  String get difficultyHard => '어려움';

  @override
  String get replayLevel => '다시 플레이';

  @override
  String get difficulty => '난이도';

  @override
  String get campaignTitle => '캠페인';

  @override
  String get campaignSubtitle => '999 레벨, 9레벨마다 난이도 상승';

  @override
  String get modeEasy => '쉬움';

  @override
  String get modeMedium => '보통';

  @override
  String get modeHard => '어려움';

  @override
  String get modeLevels => '999 레벨';

  @override
  String get startLevel => '레벨 %s 시작';

  @override
  String get unlockedTo => '레벨 %s까지 해금';

  @override
  String get clickToStart => '탭하여 시작';

  @override
  String get unlockedToClickToStart => '레벨 %s까지 해금. 탭하여 시작';
}
