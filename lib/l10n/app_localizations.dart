import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app_localizations_ar.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_th.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

/// 全球前18名语言（按使用人数）
const List<String> _supportedLanguageCodes = [
  'en', 'zh', 'hi', 'es', 'ar', 'fr', 'bn', 'pt', 'ru', 'id',
  'ur', 'de', 'ja', 'vi', 'tr', 'ko', 'it', 'th',
];

abstract class AppLocalizations {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, AppLocalizations> _localizations = {
    'en': AppLocalizationsEn(),
    'zh': AppLocalizationsZh(),
    'hi': AppLocalizationsHi(),
    'es': AppLocalizationsEs(),
    'ar': AppLocalizationsAr(),
    'fr': AppLocalizationsFr(),
    'bn': AppLocalizationsBn(),
    'pt': AppLocalizationsPt(),
    'ru': AppLocalizationsRu(),
    'id': AppLocalizationsId(),
    'ur': AppLocalizationsUr(),
    'de': AppLocalizationsDe(),
    'ja': AppLocalizationsJa(),
    'vi': AppLocalizationsVi(),
    'tr': AppLocalizationsTr(),
    'ko': AppLocalizationsKo(),
    'it': AppLocalizationsIt(),
    'th': AppLocalizationsTh(),
  };

  static AppLocalizations get(String locale) {
    final code = locale.split('-').first.toLowerCase();
    if (code == 'zh') return _localizations['zh']!;
    return _localizations[code] ?? _localizations['en']!;
  }

  // 通用
  String get appTitle;
  String get sudoku;
  String get loading;

  // 首页
  String get slogan;
  String get freeMode;
  String get campaignMode;
  String get rulesTitle;

  // 规则说明
  String get rulesGoal;
  String get rulesGoalDesc;
  String get rulesBasic;
  String get rulesBasicItems;
  String get rulesOps;
  String get rulesOpsItems;
  String get rulesGotIt;

  // 游戏（带参数）
  String level(int n) => levelFormat.replaceAll('%s', n.toString());
  String errors(int count, int max) =>
      errorsFormat.replaceFirst('%s', count.toString()).replaceFirst('%s', max.toString());
  String gameOverDescFormatted(int max, String time) =>
      gameOverDesc.replaceFirst('%s', max.toString()).replaceFirst('%s', time);
  String congratsDescFormatted(String time) =>
      congratsDesc.replaceFirst('%s', time);
  String startLevelFormatted(int n) => startLevel.replaceAll('%s', n.toString());
  String unlockedToFormatted(int n) => unlockedTo.replaceFirst('%s', n.toString());
  String unlockedToClickToStartFormatted(int n) =>
      unlockedToClickToStart.replaceFirst('%s', n.toString());

  String get levelFormat;
  String get errorsFormat;
  String get gameOver;
  String get gameOverDesc;
  String get startLevel;
  String get unlockedTo;
  String get back;
  String get retry;
  String get congrats;
  String get congratsDesc;
  String get confirm;
  String get nextLevel;
  String get newGame;
  String get selectDifficulty;
  String get difficultyEasy;
  String get difficultyMedium;
  String get difficultyHard;
  String get replayLevel;
  String get difficulty;

  // 闯关
  String get campaignTitle;
  String get campaignSubtitle;
  String get modeEasy;
  String get modeMedium;
  String get modeHard;
  String get modeLevels;
  String get clickToStart;
  String get unlockedToClickToStart;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      _supportedLanguageCodes.contains(locale.languageCode.toLowerCase());

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      SynchronousFuture<AppLocalizations>(AppLocalizations.get(locale.languageCode));

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
