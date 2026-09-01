import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Gameplay preferences (separate from theme).
class GameSettingsController extends ChangeNotifier {
  GameSettingsController({this.quickNumberPadEnabled = true});

  static const _quickNumberPadKey = 'sudoku_quick_number_pad_v1';

  bool quickNumberPadEnabled;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getBool(_quickNumberPadKey);
    if (stored != null && stored != quickNumberPadEnabled) {
      quickNumberPadEnabled = stored;
      notifyListeners();
    }
  }

  Future<void> setQuickNumberPadEnabled(bool value) async {
    if (quickNumberPadEnabled == value) return;
    quickNumberPadEnabled = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_quickNumberPadKey, value);
  }
}

class GameSettingsScope extends InheritedNotifier<GameSettingsController> {
  const GameSettingsScope({
    super.key,
    required GameSettingsController controller,
    required super.child,
  }) : super(notifier: controller);

  static GameSettingsController of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<GameSettingsScope>();
    assert(scope != null, 'GameSettingsScope not found');
    return scope!.notifier!;
  }
}
