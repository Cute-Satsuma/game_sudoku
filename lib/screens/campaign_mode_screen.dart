import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../theme/hero_background.dart';
import 'level_select_screen.dart';

/// Campaign mode - select difficulty (Easy/Medium/Hard)
class CampaignModeScreen extends StatelessWidget {
  const CampaignModeScreen({super.key});

  static const _modes = [
    (id: 1, icon: Icons.sentiment_satisfied, color: Color(0xFF4CAF50)),
    (id: 2, icon: Icons.sentiment_neutral, color: Color(0xFF2196F3)),
    (id: 3, icon: Icons.sentiment_dissatisfied, color: Color(0xFFE53935)),
  ];

  String _modeName(AppLocalizations l10n, int id) {
    switch (id) {
      case 1:
        return l10n.modeEasy;
      case 2:
        return l10n.modeMedium;
      case 3:
        return l10n.modeHard;
      default:
        return '$id';
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final onHero = cajuOnHeroForeground(context);
    final onHeroMuted = cajuHeroMutedForeground(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: cajuHeroDecoration(context),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                title: Text(
                  l10n.campaignTitle,
                  style: TextStyle(color: onHero, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: onHero),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Text(
                  l10n.campaignSubtitle,
                  style: TextStyle(color: onHeroMuted, fontSize: 14),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(24),
                  itemCount: _modes.length,
                  itemBuilder: (context, index) {
                    final mode = _modes[index];
                    final name = _modeName(l10n, mode.id);
                    return _ModeCard(
                      name: name,
                      modeLevels: l10n.modeLevels,
                      icon: mode.icon,
                      color: mode.color,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LevelSelectScreen(
                              mode: mode.id,
                              modeName: name,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  const _ModeCard({
    required this.name,
    required this.modeLevels,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String name;
  final String modeLevels;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: isDark ? colorScheme.surfaceContainerHigh : colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outlineVariant.withValues(alpha: 0.45),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 36, color: color),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 1.15,
                        leadingDistribution: TextLeadingDistribution.even,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      modeLevels,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
