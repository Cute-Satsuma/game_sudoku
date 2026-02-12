import 'app_localizations.dart';

class AppLocalizationsId extends AppLocalizations {
  @override
  String get appTitle => 'CS Sudoku';

  @override
  String get sudoku => 'Sudoku';

  @override
  String get loading => 'Memuat...';

  @override
  String get slogan => 'Permainan logika angka klasik';

  @override
  String get freeMode => 'Main bebas';

  @override
  String get campaignMode => 'Kampanye';

  @override
  String get rulesTitle => 'Aturan Sudoku';

  @override
  String get rulesGoal => 'Tujuan';

  @override
  String get rulesGoalDesc =>
      'Isi grid 9×9 dengan angka 1–9 sehingga setiap baris, kolom, '
      'dan kotak 3×3 berisi setiap angka tepat satu kali.';

  @override
  String get rulesBasic => 'Aturan';

  @override
  String get rulesBasicItems =>
      '• Tidak ada pengulangan di setiap baris\n'
      '• Tidak ada pengulangan di setiap kolom\n'
      '• Tidak ada pengulangan di setiap kotak 3×3\n'
      '• Angka yang diberikan tidak dapat diubah';

  @override
  String get rulesOps => 'Cara bermain';

  @override
  String get rulesOpsItems =>
      '• Ketuk sel untuk memilih, lalu ketuk angka untuk mengisi\n'
      '• Umpan balik instan: hijau = benar, merah = salah\n'
      '• Mode kampanye memiliki batas 10 kesalahan';

  @override
  String get rulesGotIt => 'Mengerti';

  @override
  String get levelFormat => 'Level %s';

  @override
  String get errorsFormat => 'Kesalahan: %s/%s';

  @override
  String get gameOver => 'Game over';

  @override
  String get gameOverDesc => 'Anda mencapai %s kesalahan. Waktu: %s';

  @override
  String get back => 'Kembali';

  @override
  String get retry => 'Coba lagi';

  @override
  String get congrats => 'Selamat!';

  @override
  String get congratsDesc => 'Selesai dalam %s!';

  @override
  String get confirm => 'OK';

  @override
  String get nextLevel => 'Berikutnya';

  @override
  String get newGame => 'Permainan baru';

  @override
  String get selectDifficulty => 'Pilih kesulitan';

  @override
  String get difficultyEasy => 'Mudah';

  @override
  String get difficultyMedium => 'Sedang';

  @override
  String get difficultyHard => 'Sulit';

  @override
  String get replayLevel => 'Main ulang';

  @override
  String get difficulty => 'Kesulitan';

  @override
  String get campaignTitle => 'Kampanye';

  @override
  String get campaignSubtitle => '999 level, kesulitan meningkat setiap 9 level';

  @override
  String get modeEasy => 'Mudah';

  @override
  String get modeMedium => 'Sedang';

  @override
  String get modeHard => 'Sulit';

  @override
  String get modeLevels => '999 level';

  @override
  String get startLevel => 'Mulai level %s';

  @override
  String get unlockedTo => 'Terbuka hingga level %s';

  @override
  String get clickToStart => 'Ketuk untuk memulai';

  @override
  String get unlockedToClickToStart => 'Terbuka hingga level %s. Ketuk untuk memulai';
}
