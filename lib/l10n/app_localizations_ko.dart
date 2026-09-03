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
  String get hintModesTitle => '힌트';
  @override
  String get hintModesHint =>
      '칸을 선택하면 숫자판에 해당 범위에서 아직 쓸 수 있는 숫자가 색으로 표시됩니다.';
  @override
  String get hintBox => '박스 힌트';
  @override
  String get hintBoxHint => '선택한 칸이 속한 3×3 박스에서 아직 가능한 숫자를 표시합니다.';
  @override
  String get hintColumn => '열 힌트';
  @override
  String get hintColumnHint => '선택한 칸의 열에서 아직 가능한 숫자를 표시합니다.';
  @override
  String get hintRow => '행 힌트';
  @override
  String get hintRowHint => '선택한 칸의 행에서 아직 가능한 숫자를 표시합니다.';
  @override
  String get hintLegendBox => '박스';
  @override
  String get hintLegendColumn => '열';
  @override
  String get hintLegendRow => '행';
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
  String get themeGuideTitle => '테마 바꾸기';
  @override
  String get themeGuideBody => '색상, 모양, 글꼴을 바꾸려면 여기를 누르세요.';
  @override
  String get themePickerTitle => '마음에 드는 색 고르기';
  @override
  String get themePickerBody => '색을 눌러 미리 보세요. 나중에 설정에서 다시 바꿀 수 있습니다.';
  @override
  String get themePickerContinue => '이 색으로';
  @override
  String get themePickerPaperBody => '켜면 화면에 종이 질감이 더해집니다.';
}
