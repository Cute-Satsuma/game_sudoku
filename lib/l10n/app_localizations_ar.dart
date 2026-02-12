import 'app_localizations.dart';

class AppLocalizationsAr extends AppLocalizations {
  @override
  String get appTitle => 'CS سودوكو';

  @override
  String get sudoku => 'سودوكو';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get slogan => 'لعبة المنطق الرقمية الكلاسيكية';

  @override
  String get freeMode => 'اللعب الحر';

  @override
  String get campaignMode => 'الحملة';

  @override
  String get rulesTitle => 'قواعد السودوكو';

  @override
  String get rulesGoal => 'الهدف';

  @override
  String get rulesGoalDesc =>
      'املأ شبكة 9×9 بالأرقام من 1 إلى 9 بحيث يحتوي كل صف وعمود ومربع 3×3 '
      'على كل رقم مرة واحدة بالضبط.';

  @override
  String get rulesBasic => 'القواعد';

  @override
  String get rulesBasicItems =>
      '• لا تكرار في كل صف\n'
      '• لا تكرار في كل عمود\n'
      '• لا تكرار في كل مربع 3×3\n'
      '• الأرقام المعطاة لا يمكن تغييرها';

  @override
  String get rulesOps => 'كيفية اللعب';

  @override
  String get rulesOpsItems =>
      '• انقر على خلية للتحديد، ثم انقر على رقم للتعبئة\n'
      '• ردود فعل فورية: أخضر = صحيح، أحمر = خطأ\n'
      '• وضع الحملة له حد 10 أخطاء';

  @override
  String get rulesGotIt => 'فهمت';

  @override
  String get levelFormat => 'المستوى %s';

  @override
  String get errorsFormat => 'الأخطاء: %s/%s';

  @override
  String get gameOver => 'انتهت اللعبة';

  @override
  String get gameOverDesc => 'وصلت إلى %s أخطاء. الوقت: %s';

  @override
  String get back => 'رجوع';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get congrats => 'تهانينا!';

  @override
  String get congratsDesc => 'أكملت في %s!';

  @override
  String get confirm => 'موافق';

  @override
  String get nextLevel => 'التالي';

  @override
  String get newGame => 'لعبة جديدة';

  @override
  String get selectDifficulty => 'اختر الصعوبة';

  @override
  String get difficultyEasy => 'سهل';

  @override
  String get difficultyMedium => 'متوسط';

  @override
  String get difficultyHard => 'صعب';

  @override
  String get replayLevel => 'إعادة اللعب';

  @override
  String get difficulty => 'الصعوبة';

  @override
  String get campaignTitle => 'الحملة';

  @override
  String get campaignSubtitle => '999 مستوى، تزداد الصعوبة كل 9 مستويات';

  @override
  String get modeEasy => 'سهل';

  @override
  String get modeMedium => 'متوسط';

  @override
  String get modeHard => 'صعب';

  @override
  String get modeLevels => '999 مستوى';

  @override
  String get startLevel => 'بدء المستوى %s';

  @override
  String get unlockedTo => 'مفتوح حتى المستوى %s';

  @override
  String get clickToStart => 'انقر للبدء';

  @override
  String get unlockedToClickToStart => 'مفتوح حتى المستوى %s. انقر للبدء';
}
