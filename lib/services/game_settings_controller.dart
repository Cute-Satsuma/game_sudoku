import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Gameplay preferences (separate from theme).
class GameSettingsController extends ChangeNotifier {
  GameSettingsController({
    this.quickNumberPadEnabled = true,
    this.hintBoxEnabled = false,
    this.hintColumnEnabled = false,
    this.hintRowEnabled = false,
  });

  static const _quickNumberPadKey = 'sudoku_quick_number_pad_v1';
  static const _hintBoxKey = 'sudoku_hint_box_v1';
  static const _hintColumnKey = 'sudoku_hint_column_v1';
  static const _hintRowKey = 'sudoku_hint_row_v1';

  bool quickNumberPadEnabled;
  bool hintBoxEnabled;
  bool hintColumnEnabled;
  bool hintRowEnabled;

  bool get anyHintEnabled =>
      hintBoxEnabled || hintColumnEnabled || hintRowEnabled;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    var changed = false;

    changed |= _applyBool(prefs, _quickNumberPadKey, (v) {
      if (quickNumberPadEnabled == v) return false;
      quickNumberPadEnabled = v;
      return true;
    });
    changed |= _applyBool(prefs, _hintBoxKey, (v) {
      if (hintBoxEnabled == v) return false;
      hintBoxEnabled = v;
      return true;
    });
    changed |= _applyBool(prefs, _hintColumnKey, (v) {
      if (hintColumnEnabled == v) return false;
      hintColumnEnabled = v;
      return true;
    });
    changed |= _applyBool(prefs, _hintRowKey, (v) {
      if (hintRowEnabled == v) return false;
      hintRowEnabled = v;
      return true;
    });

    if (changed) notifyListeners();
  }

  bool _applyBool(
    SharedPreferences prefs,
    String key,
    bool Function(bool value) apply,
  ) {
    final stored = prefs.getBool(key);
    if (stored == null) return false;
    return apply(stored);
  }

  Future<void> setQuickNumberPadEnabled(bool value) async {
    if (quickNumberPadEnabled == value) return;
    quickNumberPadEnabled = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_quickNumberPadKey, value);
  }

  Future<void> setHintBoxEnabled(bool value) async {
    if (hintBoxEnabled == value) return;
    hintBoxEnabled = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hintBoxKey, value);
  }

  Future<void> setHintColumnEnabled(bool value) async {
    if (hintColumnEnabled == value) return;
    hintColumnEnabled = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hintColumnKey, value);
  }

  Future<void> setHintRowEnabled(bool value) async {
    if (hintRowEnabled == value) return;
    hintRowEnabled = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hintRowKey, value);
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
