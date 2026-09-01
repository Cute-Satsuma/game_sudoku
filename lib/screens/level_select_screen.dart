import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/campaign_progress.dart';
import '../theme/hero_background.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    final onHero = cajuOnHeroForeground(context);
    final onHeroMuted = cajuHeroMutedForeground(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final panelColor = isDark
        ? colorScheme.surfaceContainerHigh
        : colorScheme.surface;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: cajuHeroDecoration(context),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                title: Text(
                  '${widget.modeName} · ${l10n.level(_currentLevel)}',
                  style: TextStyle(
                    color: onHero,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: onHero),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  l10n.unlockedToClickToStartFormatted(_currentLevel),
                  style: TextStyle(color: onHeroMuted, fontSize: 14),
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
                      backgroundColor: isDark
                          ? colorScheme.surfaceContainerHighest
                          : colorScheme.surface,
                      foregroundColor: colorScheme.primary,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(
                        height: 1.15,
                        leadingDistribution: TextLeadingDistribution.even,
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
                    color: panelColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: colorScheme.outlineVariant.withValues(alpha: 0.4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.shadow.withValues(alpha: 0.16),
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
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 52,
      child: Material(
        color: isUnlocked
            ? (isCurrent
                ? colorScheme.primary
                : colorScheme.primaryContainer.withValues(alpha: 0.45))
            : colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: isUnlocked ? onTap : null,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              '$level',
              overflow: TextOverflow.visible,
              style: TextStyle(
                fontSize: 16,
                height: 1.0,
                leadingDistribution: TextLeadingDistribution.even,
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                color: isUnlocked
                    ? (isCurrent
                        ? colorScheme.onPrimary
                        : colorScheme.primary)
                    : colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
