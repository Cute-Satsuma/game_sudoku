import 'package:get_storage/get_storage.dart';

/// Campaign progress management
/// Uses get_storage for persistence; falls back to in-memory if plugin unavailable
/// 3 modes: Easy(1), Medium(2), Hard(3), 999 levels each
class CampaignProgress {
  static const _boxName = 'campaign_progress';
  static const _keyPrefix = 'campaign_level_';

  static GetStorage? _box;
  static bool _initialized = false;
  static bool _useMemoryFallback = false;
  static final Map<int, int> _memoryStore = {1: 1, 2: 1, 3: 1};

  static String _key(int mode) => '$_keyPrefix$mode';

  static Future<void> _tryInit() async {
    if (_initialized) return;
    try {
      await GetStorage.init(_boxName);
      _box = GetStorage(_boxName);
      _initialized = true;
    } catch (_) {
      _useMemoryFallback = true;
      _initialized = true;
    }
  }

  /// Initialize storage (non-blocking, fallback to memory on failure)
  static Future<void> ensureInitialized() async {
    await _tryInit();
  }

  static int _getFromMemory(int mode) => _memoryStore[mode] ?? 1;

  static void _setToMemory(int mode, int value) {
    _memoryStore[mode] = value;
  }

  /// Get current level for mode (1-999, default 1)
  static Future<int> getCurrentLevelAsync(int mode) async {
    await _tryInit();
    if (_useMemoryFallback) return _getFromMemory(mode);
    final v = _box!.read(_key(mode));
    return (v is int) ? v : 1;
  }

  /// Save progress (call after completing a level to unlock next)
  static Future<void> unlockNextLevel(int mode, int completedLevel) async {
    await _tryInit();
    final next = completedLevel + 1;
    if (next > 999) return;

    _setToMemory(mode, next);
    if (!_useMemoryFallback) {
      try {
        await _box!.write(_key(mode), next);
      } catch (_) {
        _useMemoryFallback = true;
      }
    }
  }

  /// Check if a level is unlocked
  static Future<bool> isLevelUnlocked(int mode, int level) async {
    final current = await getCurrentLevelAsync(mode);
    return level <= current;
  }
}
