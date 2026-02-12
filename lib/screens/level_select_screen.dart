import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/campaign_progress.dart';
import 'game_screen.dart';

/// Level select - shows levels 1-999, can jump to a specific level
class LevelSelectScreen extends StatefulWidget {
  const LevelSelectScreen({
    super.key,
    required this.mode,
    required this.modeName,
  });

  final int mode;
  final String modeName;

  @override
  State<LevelSelectScreen> createState() => _LevelSelectScreenState();
}

class _LevelSelectScreenState extends State<LevelSelectScreen> {
  int _currentLevel = 1;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final level = await CampaignProgress.getCurrentLevelAsync(widget.mode);
    setState(() => _currentLevel = level);
  }

  void _playLevel(int level) {
    if (level > _currentLevel) return;
    if (!mounted) return;

    _navigateAndPlay(level);
  }

  Future<void> _navigateAndPlay(int level) async {
    if (!mounted) return;

    final navigator = Navigator.of(context);
    final result = await navigator.push<Object>(
      MaterialPageRoute(
        builder: (context) => GameScreen(
          campaignMode: widget.mode,
          campaignLevel: level,
        ),
      ),
    );

    if (!mounted) return;
    if (result != null) {
      await _loadProgress();
      if (result is int && result <= 999) {
        _playLevel(result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1B5E20),
              Color(0xFF2E7D32),
              Color(0xFF388E3C),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                title: Text(
                  '${widget.modeName} · ${l10n.level(_currentLevel)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  l10n.unlockedToClickToStartFormatted(_currentLevel),
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton.icon(
                    onPressed: () => _playLevel(_currentLevel),
                    icon: const Icon(Icons.play_arrow, size: 24),
                    label: Text(l10n.startLevelFormatted(_currentLevel)),
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF2E7D32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: 167,
                      itemBuilder: (context, rowIndex) {
                        final startLevel = rowIndex * 6 + 1;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: List.generate(6, (colIndex) {
                              final level = startLevel + colIndex;
                              if (level > 999) return const SizedBox.shrink();
                              final isCurrent = level == _currentLevel;
                              final isUnlocked = level <= _currentLevel;
                              return Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: colIndex < 5 ? 8 : 0,
                                  ),
                                  child: _LevelTile(
                                    level: level,
                                    isUnlocked: isUnlocked,
                                    isCurrent: isCurrent,
                                    onTap: () => _playLevel(level),
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LevelTile extends StatelessWidget {
  const _LevelTile({
    required this.level,
    required this.isUnlocked,
    required this.isCurrent,
    required this.onTap,
  });

  final int level;
  final bool isUnlocked;
  final bool isCurrent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Material(
        color: isUnlocked
            ? (isCurrent ? const Color(0xFF2E7D32) : Colors.green.shade50)
            : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: isUnlocked ? onTap : null,
          borderRadius: BorderRadius.circular(8),
          child: Center(
            child: Text(
              '$level',
              style: TextStyle(
                fontSize: 16,
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                color: isUnlocked
                    ? (isCurrent ? Colors.white : Colors.green.shade800)
                    : Colors.grey.shade500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
