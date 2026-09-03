import 'package:flutter/material.dart';
import 'package:game_sudoku/l10n/app_localizations.dart';
import 'package:game_sudoku/theme/caju_style.dart';
import 'package:game_sudoku/theme/hero_background.dart';
import 'package:game_sudoku/theme/theme_sheet.dart';
import 'package:game_sudoku/services/game_settings_controller.dart';
import 'package:game_sudoku/widgets/hint_accents.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final onHero = cajuOnHeroForeground(context);
    final gameSettings = GameSettingsScope.of(context);
    return Container(
      decoration: cajuHeroDecoration(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          foregroundColor: onHero,
          title: Text(l10n.settingsTitle),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            children: [
              DecoratedBox(
                decoration: cajuPanelDecoration(
                  colorScheme,
                  color: colorScheme.surfaceContainerLow,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.appTitle,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.aboutContent,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.45,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              DecoratedBox(
                decoration: cajuPanelDecoration(colorScheme),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
                  child: ListenableBuilder(
                    listenable: gameSettings,
                    builder: (context, _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            l10n.gameplayTitle,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: colorScheme.primary,
                                  letterSpacing: 0.3,
                                ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  l10n.quickNumberPad,
                                  style: Theme.of(context).textTheme.titleSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.2,
                                      ),
                                ),
                              ),
                              Switch(
                                value: gameSettings.quickNumberPadEnabled,
                                onChanged:
                                    gameSettings.setQuickNumberPadEnabled,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.quickNumberPadHint,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  height: 1.4,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Divider(
                            height: 1,
                            color: colorScheme.outlineVariant.withValues(
                              alpha: 0.7,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            l10n.hintModesTitle,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.2,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.hintModesHint,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  height: 1.4,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                          ),
                          const SizedBox(height: 12),
                          HintModeSwitchRow(
                            color: HintAccentColors.boxOf(context),
                            title: l10n.hintBox,
                            subtitle: l10n.hintBoxHint,
                            value: gameSettings.hintBoxEnabled,
                            onChanged: gameSettings.setHintBoxEnabled,
                          ),
                          const SizedBox(height: 10),
                          HintModeSwitchRow(
                            color: HintAccentColors.columnOf(context),
                            title: l10n.hintColumn,
                            subtitle: l10n.hintColumnHint,
                            value: gameSettings.hintColumnEnabled,
                            onChanged: gameSettings.setHintColumnEnabled,
                          ),
                          const SizedBox(height: 10),
                          HintModeSwitchRow(
                            color: HintAccentColors.rowOf(context),
                            title: l10n.hintRow,
                            subtitle: l10n.hintRowHint,
                            value: gameSettings.hintRowEnabled,
                            onChanged: gameSettings.setHintRowEnabled,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 28),
              DecoratedBox(
                decoration: cajuPanelDecoration(colorScheme),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 14),
                  child: ThemeSettingsPanel(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
