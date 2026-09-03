import 'app_localizations.dart';

class AppLocalizationsZh extends AppLocalizations {
  @override
  String get appTitle => '数独-可爱桔';

  @override
  String get sudoku => '数独';

  @override
  String get loading => '加载中...';

  @override
  String get slogan => '经典数字逻辑游戏';

  @override
  String get freeMode => '自由模式';

  @override
  String get campaignMode => '闯关模式';

  @override
  String get rulesTitle => '数独规则说明';

  @override
  String get rulesGoal => '游戏目标';

  @override
  String get rulesGoalDesc =>
      '在 9×9 的格子中填入数字 1～9，使每一行、每一列、每一个 3×3 宫格内，1～9 各出现一次。';

  @override
  String get rulesBasic => '基本规则';

  @override
  String get rulesBasicItems =>
      '• 每行 9 个数字不重复\n'
      '• 每列 9 个数字不重复\n'
      '• 每个 3×3 宫格内 9 个数字不重复\n'
      '• 题目给出的数字不可修改';

  @override
  String get rulesOps => '操作说明';

  @override
  String get rulesOpsItems =>
      '• 点击空白格选中，再点击数字键盘填入\n'
      '• 每填一个数字会立即显示对错（绿色=正确，红色=错误）\n'
      '• 闯关模式有错误次数限制（10 次）';

  @override
  String get rulesGotIt => '知道了';

  @override
  String get levelFormat => '第 %s 关';

  @override
  String get errorsFormat => '错误: %s/%s';

  @override
  String get gameOver => '游戏结束';

  @override
  String get gameOverDesc => '错误次数已达 %s 次，本关失败。\n用时：%s';

  @override
  String get back => '返回';

  @override
  String get retry => '重试';

  @override
  String get congrats => '恭喜完成！';

  @override
  String get congratsDesc => '你用了 %s 完成数独！';

  @override
  String get confirm => '确定';

  @override
  String get nextLevel => '下一关';

  @override
  String get newGame => '新游戏';

  @override
  String get selectDifficulty => '选择难度';

  @override
  String get difficultyEasy => '简单';

  @override
  String get difficultyMedium => '中等';

  @override
  String get difficultyHard => '困难';

  @override
  String get replayLevel => '重玩本关';

  @override
  String get difficulty => '难度';

  @override
  String get campaignTitle => '闯关模式';

  @override
  String get campaignSubtitle => '每9关难度逐渐增加，共999关';

  @override
  String get modeEasy => '简单';

  @override
  String get modeMedium => '中等';

  @override
  String get modeHard => '困难';

  @override
  String get modeLevels => '999关 · 每9关难度+1';

  @override
  String get startLevel => '开始第 %s 关';

  @override
  String get unlockedTo => '已解锁至第 %s 关';

  @override
  String get clickToStart => '点击关卡开始';

  @override
  String get unlockedToClickToStart => '已解锁至第 %s 关，点击关卡开始';

  // Settings & theme
  @override
  String get settingsTitle => '设置';
  @override
  String get aboutContent => '''经典数独解谜。

• 无广告、无需账号
• 进度只保存在本机
• 可完全离线游玩''';
  @override
  String get gameplayTitle => '玩法';
  @override
  String get quickNumberPad => '数字小键盘';
  @override
  String get quickNumberPadHint => '再次点击已选中的格子，可在棋盘上弹出快捷数字盘。';
  @override
  String get hintModesTitle => '提示';
  @override
  String get hintModesHint =>
      '选中格子后，数字盘会用颜色标出该范围里还可以填的数字。';
  @override
  String get hintBox => '宫格提示';
  @override
  String get hintBoxHint => '标出当前 3×3 宫格中，选中格还可填的数字。';
  @override
  String get hintColumn => '列提示';
  @override
  String get hintColumnHint => '标出当前列中，选中格还可填的数字。';
  @override
  String get hintRow => '行提示';
  @override
  String get hintRowHint => '标出当前行中，选中格还可填的数字。';
  @override
  String get hintLegendBox => '宫';
  @override
  String get hintLegendColumn => '列';
  @override
  String get hintLegendRow => '行';
  @override
  String get themeTitle => '主题';
  @override
  String get themeAppearance => '外观';
  @override
  String get themeSystem => '系统';
  @override
  String get themeLight => '浅色';
  @override
  String get themeDark => '深色';
  @override
  String get themeColor => '配色';
  @override
  String get themeOrange => '柑色';
  @override
  String get themeGreen => '绿色';
  @override
  String get themeTeal => '青绿';
  @override
  String get themeBlue => '蓝色';
  @override
  String get themeSlate => '岩灰';
  @override
  String get themePaper => '纸色';
  @override
  String get themePaperFilter => '纸质滤镜';
  @override
  String get themePaperGrain => '粗糙度';
  @override
  String get themePaperGrainFine => '细腻';
  @override
  String get themePaperGrainCoarse => '粗糙';
  @override
  String get themeFont => '字体';
  @override
  String get themeIconStyle => '图标风格';
  @override
  String get iconStyleAnime => '动画';
  @override
  String get iconStyleBusiness => '商务';
  @override
  String get fontRounded => '圆润';
  @override
  String get fontMaru => '圆体';
  @override
  String get fontXiaoWei => '小薇';
  @override
  String get fontNunito => '软圆';
  @override
  String get fontSystem => '系统';
  @override
  String get themeGuideTitle => '换个主题';
  @override
  String get themeGuideBody => '点这里就能改配色、外观和字体。';
  @override
  String get themePickerTitle => '选一个喜欢的颜色';
  @override
  String get themePickerBody => '点色块即可预览，之后仍可在设置里更改。';
  @override
  String get themePickerContinue => '选好了';
  @override
  String get themePickerPaperBody => '打开后会给界面加上纸张纹理。';
}
