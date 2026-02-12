import 'app_localizations.dart';

class AppLocalizationsTh extends AppLocalizations {
  @override
  String get appTitle => 'CS ซูโดกุ';

  @override
  String get sudoku => 'ซูโดกุ';

  @override
  String get loading => 'กำลังโหลด...';

  @override
  String get slogan => 'เกมตรรกะตัวเลขคลาสสิก';

  @override
  String get freeMode => 'เล่นฟรี';

  @override
  String get campaignMode => 'แคมเปญ';

  @override
  String get rulesTitle => 'กฎของซูโดกุ';

  @override
  String get rulesGoal => 'เป้าหมาย';

  @override
  String get rulesGoalDesc =>
      'เติมตาราง 9×9 ด้วยตัวเลข 1–9 ให้แต่ละแถว คอลัมน์ และ '
      'กล่อง 3×3 มีตัวเลขแต่ละตัวเพียงครั้งเดียว';

  @override
  String get rulesBasic => 'กฎ';

  @override
  String get rulesBasicItems =>
      '• ไม่ซ้ำในแต่ละแถว\n'
      '• ไม่ซ้ำในแต่ละคอลัมน์\n'
      '• ไม่ซ้ำในแต่ละกล่อง 3×3\n'
      '• ตัวเลขที่ให้มาไม่สามารถเปลี่ยนได้';

  @override
  String get rulesOps => 'วิธีเล่น';

  @override
  String get rulesOpsItems =>
      '• แตะเซลล์เพื่อเลือก จากนั้นแตะตัวเลขเพื่อเติม\n'
      '• ผลตอบกลับทันที: เขียว = ถูกต้อง แดง = ผิด\n'
      '• โหมดแคมเปญจำกัด 10 ข้อผิดพลาด';

  @override
  String get rulesGotIt => 'เข้าใจแล้ว';

  @override
  String get levelFormat => 'ระดับ %s';

  @override
  String get errorsFormat => 'ข้อผิดพลาด: %s/%s';

  @override
  String get gameOver => 'เกมจบ';

  @override
  String get gameOverDesc => 'คุณทำผิด %s ครั้ง เวลา: %s';

  @override
  String get back => 'กลับ';

  @override
  String get retry => 'ลองอีกครั้ง';

  @override
  String get congrats => 'ยินดีด้วย!';

  @override
  String get congratsDesc => 'สำเร็จใน %s!';

  @override
  String get confirm => 'ตกลง';

  @override
  String get nextLevel => 'ถัดไป';

  @override
  String get newGame => 'เกมใหม่';

  @override
  String get selectDifficulty => 'เลือกความยาก';

  @override
  String get difficultyEasy => 'ง่าย';

  @override
  String get difficultyMedium => 'ปานกลาง';

  @override
  String get difficultyHard => 'ยาก';

  @override
  String get replayLevel => 'เล่นซ้ำ';

  @override
  String get difficulty => 'ความยาก';

  @override
  String get campaignTitle => 'แคมเปญ';

  @override
  String get campaignSubtitle => '999 ระดับ ความยากเพิ่มทุก 9 ระดับ';

  @override
  String get modeEasy => 'ง่าย';

  @override
  String get modeMedium => 'ปานกลาง';

  @override
  String get modeHard => 'ยาก';

  @override
  String get modeLevels => '999 ระดับ';

  @override
  String get startLevel => 'เริ่มระดับ %s';

  @override
  String get unlockedTo => 'ปลดล็อกถึงระดับ %s';

  @override
  String get clickToStart => 'แตะเพื่อเริ่ม';

  @override
  String get unlockedToClickToStart => 'ปลดล็อกถึงระดับ %s แตะเพื่อเริ่ม';
}
