import 'app_localizations.dart';

class AppLocalizationsJa extends AppLocalizations {
  @override
  String get appTitle => 'CS 数独';

  @override
  String get sudoku => '数独';

  @override
  String get loading => '読み込み中...';

  @override
  String get slogan => 'クラシック数字ロジックゲーム';

  @override
  String get freeMode => 'フリープレイ';

  @override
  String get campaignMode => 'キャンペーン';

  @override
  String get rulesTitle => '数独のルール';

  @override
  String get rulesGoal => '目標';

  @override
  String get rulesGoalDesc =>
      '9×9のグリッドに1〜9の数字を入れ、各行・各列・各3×3のブロックに '
      '各数字が1回ずつ入るようにします。';

  @override
  String get rulesBasic => 'ルール';

  @override
  String get rulesBasicItems =>
      '• 各行に重複なし\n'
      '• 各列に重複なし\n'
      '• 各3×3ブロックに重複なし\n'
      '• 最初から入っている数字は変更不可';

  @override
  String get rulesOps => '遊び方';

  @override
  String get rulesOpsItems =>
      '• セルをタップして選択し、数字をタップして入力\n'
      '• 即時フィードバック：緑＝正解、赤＝不正解\n'
      '• キャンペーンモードは10回までミス可能';

  @override
  String get rulesGotIt => 'わかりました';

  @override
  String get levelFormat => 'レベル %s';

  @override
  String get errorsFormat => 'ミス: %s/%s';

  @override
  String get gameOver => 'ゲームオーバー';

  @override
  String get gameOverDesc => '%s回ミスしました。タイム: %s';

  @override
  String get back => '戻る';

  @override
  String get retry => 'リトライ';

  @override
  String get congrats => 'おめでとうございます！';

  @override
  String get congratsDesc => '%sでクリア！';

  @override
  String get confirm => 'OK';

  @override
  String get nextLevel => '次へ';

  @override
  String get newGame => '新しいゲーム';

  @override
  String get selectDifficulty => '難易度を選択';

  @override
  String get difficultyEasy => '簡単';

  @override
  String get difficultyMedium => '普通';

  @override
  String get difficultyHard => '難しい';

  @override
  String get replayLevel => 'リプレイ';

  @override
  String get difficulty => '難易度';

  @override
  String get campaignTitle => 'キャンペーン';

  @override
  String get campaignSubtitle => '999レベル、9レベルごとに難易度上昇';

  @override
  String get modeEasy => '簡単';

  @override
  String get modeMedium => '普通';

  @override
  String get modeHard => '難しい';

  @override
  String get modeLevels => '999レベル';

  @override
  String get startLevel => 'レベル %s を開始';

  @override
  String get unlockedTo => 'レベル %s まで解放';

  @override
  String get clickToStart => 'タップして開始';

  @override
  String get unlockedToClickToStart => 'レベル %s まで解放。タップして開始';
}
