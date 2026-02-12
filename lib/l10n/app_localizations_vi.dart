import 'app_localizations.dart';

class AppLocalizationsVi extends AppLocalizations {
  @override
  String get appTitle => 'CS Sudoku';

  @override
  String get sudoku => 'Sudoku';

  @override
  String get loading => 'Đang tải...';

  @override
  String get slogan => 'Trò chơi logic số cổ điển';

  @override
  String get freeMode => 'Chơi tự do';

  @override
  String get campaignMode => 'Chiến dịch';

  @override
  String get rulesTitle => 'Luật Sudoku';

  @override
  String get rulesGoal => 'Mục tiêu';

  @override
  String get rulesGoalDesc =>
      'Điền lưới 9×9 bằng các chữ số từ 1 đến 9 sao cho mỗi hàng, cột và '
      'ô 3×3 chứa mỗi số đúng một lần.';

  @override
  String get rulesBasic => 'Luật chơi';

  @override
  String get rulesBasicItems =>
      '• Không lặp lại trong mỗi hàng\n'
      '• Không lặp lại trong mỗi cột\n'
      '• Không lặp lại trong mỗi ô 3×3\n'
      '• Số cho sẵn không thể thay đổi';

  @override
  String get rulesOps => 'Cách chơi';

  @override
  String get rulesOpsItems =>
      '• Chạm vào ô để chọn, sau đó chạm vào số để điền\n'
      '• Phản hồi tức thì: xanh = đúng, đỏ = sai\n'
      '• Chế độ chiến dịch giới hạn 10 lỗi';

  @override
  String get rulesGotIt => 'Đã hiểu';

  @override
  String get levelFormat => 'Cấp %s';

  @override
  String get errorsFormat => 'Lỗi: %s/%s';

  @override
  String get gameOver => 'Hết game';

  @override
  String get gameOverDesc => 'Bạn đã đạt %s lỗi. Thời gian: %s';

  @override
  String get back => 'Quay lại';

  @override
  String get retry => 'Thử lại';

  @override
  String get congrats => 'Chúc mừng!';

  @override
  String get congratsDesc => 'Hoàn thành trong %s!';

  @override
  String get confirm => 'OK';

  @override
  String get nextLevel => 'Tiếp theo';

  @override
  String get newGame => 'Game mới';

  @override
  String get selectDifficulty => 'Chọn độ khó';

  @override
  String get difficultyEasy => 'Dễ';

  @override
  String get difficultyMedium => 'Trung bình';

  @override
  String get difficultyHard => 'Khó';

  @override
  String get replayLevel => 'Chơi lại';

  @override
  String get difficulty => 'Độ khó';

  @override
  String get campaignTitle => 'Chiến dịch';

  @override
  String get campaignSubtitle => '999 cấp, độ khó tăng mỗi 9 cấp';

  @override
  String get modeEasy => 'Dễ';

  @override
  String get modeMedium => 'Trung bình';

  @override
  String get modeHard => 'Khó';

  @override
  String get modeLevels => '999 cấp';

  @override
  String get startLevel => 'Bắt đầu cấp %s';

  @override
  String get unlockedTo => 'Mở khóa đến cấp %s';

  @override
  String get clickToStart => 'Chạm để bắt đầu';

  @override
  String get unlockedToClickToStart => 'Mở khóa đến cấp %s. Chạm để bắt đầu';
}
