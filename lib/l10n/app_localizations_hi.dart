import 'app_localizations.dart';

class AppLocalizationsHi extends AppLocalizations {
  @override
  String get appTitle => 'CS सुडोकू';

  @override
  String get sudoku => 'सुडोकू';

  @override
  String get loading => 'लोड हो रहा है...';

  @override
  String get slogan => 'क्लासिक नंबर लॉजिक गेम';

  @override
  String get freeMode => 'फ्री प्ले';

  @override
  String get campaignMode => 'कैंपेन';

  @override
  String get rulesTitle => 'सुडोकू नियम';

  @override
  String get rulesGoal => 'लक्ष्य';

  @override
  String get rulesGoalDesc =>
      '9×9 ग्रिड को 1-9 अंकों से भरें ताकि प्रत्येक पंक्ति, स्तंभ और '
      '3×3 बॉक्स में प्रत्येक संख्या बिल्कुल एक बार आए।';

  @override
  String get rulesBasic => 'नियम';

  @override
  String get rulesBasicItems =>
      '• प्रत्येक पंक्ति में दोहराव नहीं\n'
      '• प्रत्येक स्तंभ में दोहराव नहीं\n'
      '• प्रत्येक 3×3 बॉक्स में दोहराव नहीं\n'
      '• दिए गए अंक बदले नहीं जा सकते';

  @override
  String get rulesOps => 'कैसे खेलें';

  @override
  String get rulesOpsItems =>
      '• सेल चुनने के लिए टैप करें, फिर भरने के लिए अंक टैप करें\n'
      '• तुरंत फीडबैक: हरा = सही, लाल = गलत\n'
      '• कैंपेन मोड में 10 गलतियों की सीमा';

  @override
  String get rulesGotIt => 'समझ गया';

  @override
  String get levelFormat => 'स्तर %s';

  @override
  String get errorsFormat => 'गलतियाँ: %s/%s';

  @override
  String get gameOver => 'गेम ओवर';

  @override
  String get gameOverDesc => 'आपने %s गलतियाँ पूरी कीं। समय: %s';

  @override
  String get back => 'वापस';

  @override
  String get retry => 'पुनः प्रयास';

  @override
  String get congrats => 'बधाई हो!';

  @override
  String get congratsDesc => '%s में पूर्ण!';

  @override
  String get confirm => 'ठीक है';

  @override
  String get nextLevel => 'अगला';

  @override
  String get newGame => 'नया गेम';

  @override
  String get selectDifficulty => 'कठिनाई चुनें';

  @override
  String get difficultyEasy => 'आसान';

  @override
  String get difficultyMedium => 'मध्यम';

  @override
  String get difficultyHard => 'कठिन';

  @override
  String get replayLevel => 'दोबारा खेलें';

  @override
  String get difficulty => 'कठिनाई';

  @override
  String get campaignTitle => 'कैंपेन';

  @override
  String get campaignSubtitle => '999 स्तर, हर 9 स्तर पर कठिनाई बढ़ती है';

  @override
  String get modeEasy => 'आसान';

  @override
  String get modeMedium => 'मध्यम';

  @override
  String get modeHard => 'कठिन';

  @override
  String get modeLevels => '999 स्तर';

  @override
  String get startLevel => 'स्तर %s शुरू करें';

  @override
  String get unlockedTo => 'स्तर %s तक अनलॉक';

  @override
  String get clickToStart => 'शुरू करने के लिए टैप करें';

  @override
  String get unlockedToClickToStart => 'स्तर %s तक अनलॉक। शुरू करने के लिए टैप करें';
}
