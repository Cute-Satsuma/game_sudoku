import 'app_localizations.dart';

class AppLocalizationsTr extends AppLocalizations {
  @override
  String get appTitle => 'CS Sudoku';

  @override
  String get sudoku => 'Sudoku';

  @override
  String get loading => 'Yükleniyor...';

  @override
  String get slogan => 'Klasik sayı mantık oyunu';

  @override
  String get freeMode => 'Serbest oyun';

  @override
  String get campaignMode => 'Kampanya';

  @override
  String get rulesTitle => 'Sudoku kuralları';

  @override
  String get rulesGoal => 'Hedef';

  @override
  String get rulesGoalDesc =>
      '9×9 ızgarayı 1–9 rakamlarıyla doldurun; her satır, sütun ve '
      '3×3 kutuda her sayı tam olarak bir kez geçsin.';

  @override
  String get rulesBasic => 'Kurallar';

  @override
  String get rulesBasicItems =>
      '• Her satırda tekrar yok\n'
      '• Her sütunda tekrar yok\n'
      '• Her 3×3 kutuda tekrar yok\n'
      '• Verilen sayılar değiştirilemez';

  @override
  String get rulesOps => 'Nasıl oynanır';

  @override
  String get rulesOpsItems =>
      '• Seçmek için bir hücreye dokunun, sonra doldurmak için bir sayıya dokunun\n'
      '• Anında geri bildirim: yeşil = doğru, kırmızı = yanlış\n'
      '• Kampanya modunda 10 hata limiti var';

  @override
  String get rulesGotIt => 'Anladım';

  @override
  String get levelFormat => 'Seviye %s';

  @override
  String get errorsFormat => 'Hatalar: %s/%s';

  @override
  String get gameOver => 'Oyun bitti';

  @override
  String get gameOverDesc => '%s hataya ulaştınız. Süre: %s';

  @override
  String get back => 'Geri';

  @override
  String get retry => 'Tekrar dene';

  @override
  String get congrats => 'Tebrikler!';

  @override
  String get congratsDesc => '%s içinde tamamlandı!';

  @override
  String get confirm => 'Tamam';

  @override
  String get nextLevel => 'İleri';

  @override
  String get newGame => 'Yeni oyun';

  @override
  String get selectDifficulty => 'Zorluk seçin';

  @override
  String get difficultyEasy => 'Kolay';

  @override
  String get difficultyMedium => 'Orta';

  @override
  String get difficultyHard => 'Zor';

  @override
  String get replayLevel => 'Tekrar oyna';

  @override
  String get difficulty => 'Zorluk';

  @override
  String get campaignTitle => 'Kampanya';

  @override
  String get campaignSubtitle => '999 seviye, her 9 seviyede zorluk artar';

  @override
  String get modeEasy => 'Kolay';

  @override
  String get modeMedium => 'Orta';

  @override
  String get modeHard => 'Zor';

  @override
  String get modeLevels => '999 seviye';

  @override
  String get startLevel => 'Seviye %s başlat';

  @override
  String get unlockedTo => 'Seviye %s\'e kadar açıldı';

  @override
  String get clickToStart => 'Başlamak için dokunun';

  @override
  String get unlockedToClickToStart => 'Seviye %s\'e kadar açıldı. Başlamak için dokunun';
}
