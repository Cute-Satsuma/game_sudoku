import 'dart:async';

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../theme/app_palette.dart';
import '../theme/hero_background.dart';
import '../theme/theme_controller.dart';
import '../widgets/theme_guide.dart';
import '../widgets/theme_picker_dialog.dart';
import '../widgets/sudoku_caju_logo.dart';
import 'campaign_mode_screen.dart';
import 'game_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _settingsButtonSize = 48.0;
  static const _settingsTop = 4.0;
  static const _settingsEnd = 8.0;

  var _showThemeGuide = false;
  var _guidePaletteIndex = 0;
  var _themePickerOpen = false;
  AppPalette? _paletteBeforeGuide;
  Timer? _paletteTour;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _maybeStartOnboarding();
    });
  }

  @override
  void dispose() {
    _paletteTour?.cancel();
    super.dispose();
  }

  Future<void> _maybeStartOnboarding() async {
    final controller = ThemeScope.of(context);
    if (controller.themeGuideSeen) {
      if (!controller.themePickerSeen) {
        await Future<void>.delayed(const Duration(milliseconds: 400));
        if (mounted && !ThemeScope.of(context).themePickerSeen) {
          await _showThemePicker();
        }
      }
      return;
    }
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!mounted || ThemeScope.of(context).themeGuideSeen) return;
    _startThemeGuide();
  }

  Future<void> _showThemePicker({bool quick = false}) async {
    if (_themePickerOpen || _showThemeGuide) return;
    _themePickerOpen = true;
    if (quick) {
      await ThemeScope.of(context).markThemePickerSeen();
    }
    try {
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        barrierDismissible: quick,
        builder: (context) => ThemePickerDialog(quick: quick),
      );
      if (!mounted) return;
      await ThemeScope.of(context).markThemePickerSeen();
    } finally {
      _themePickerOpen = false;
    }
  }

  void _openThemeQuickPick() {
    unawaited(_showThemePicker(quick: true));
  }

  void _startThemeGuide() {
    final controller = ThemeScope.of(context);
    _paletteBeforeGuide = controller.palette;
    _guidePaletteIndex = AppPalette.values.indexOf(controller.palette);
    if (_guidePaletteIndex < 0) _guidePaletteIndex = 0;
    setState(() => _showThemeGuide = true);
    _paletteTour = Timer.periodic(const Duration(milliseconds: 1100), (_) {
      if (!mounted) return;
      _guidePaletteIndex = (_guidePaletteIndex + 1) % AppPalette.values.length;
      controller.setPalette(
        AppPalette.values[_guidePaletteIndex],
        persist: false,
      );
      setState(() {});
    });
  }

  Future<void> _dismissThemeGuide({bool openSettings = false}) async {
    if (!_showThemeGuide) {
      if (openSettings && mounted) _openSettings();
      return;
    }
    _paletteTour?.cancel();
    _paletteTour = null;
    final controller = ThemeScope.of(context);
    final restore = _paletteBeforeGuide;
    if (restore != null) {
      await controller.setPalette(restore, persist: false);
    }
    await controller.markThemeGuideSeen();
    if (!mounted) return;
    setState(() => _showThemeGuide = false);
    await Future<void>.delayed(const Duration(milliseconds: 240));
    if (!mounted) return;
    if (!ThemeScope.of(context).themePickerSeen) {
      await _showThemePicker();
      return;
    }
    if (openSettings) _openSettings();
  }

  void _openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }

  Widget _cornerIconButton({
    required String tooltip,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: _settingsButtonSize,
      height: _settingsButtonSize,
      child: IconButton(
        tooltip: tooltip,
        style: IconButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.zero,
          minimumSize: const Size(_settingsButtonSize, _settingsButtonSize),
        ),
        onPressed: onPressed,
        icon: Icon(icon, color: color),
      ),
    );
  }

  Rect _settingsTarget(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final padding = MediaQuery.paddingOf(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final left = isRtl
        ? _settingsEnd
        : size.width - _settingsEnd - _settingsButtonSize;
    return Rect.fromLTWH(
      left,
      padding.top + _settingsTop,
      _settingsButtonSize,
      _settingsButtonSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final onHero = cajuOnHeroForeground(context);
    final onHeroMuted = cajuHeroMutedForeground(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final brand = paletteSpecs[ThemeScope.of(context).palette]!.primary;
    final freePlayFill = isDark
        ? Color.alphaBlend(
            brand.withValues(alpha: 0.22),
            Color.lerp(colorScheme.surface, Colors.white, 0.18)!,
          )
        : colorScheme.surface;
    final freePlayText = isDark ? colorScheme.onSurface : colorScheme.primary;
    final settingsTop = MediaQuery.paddingOf(context).top + _settingsTop;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: cajuHeroDecoration(context),
        child: Stack(
          fit: StackFit.expand,
          children: [
            SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Tooltip(
                        message: l10n.themeTitle,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: _openThemeQuickPick,
                            child: SudokuCajuLogo(
                              foregroundColor: onHero,
                              title: l10n.sudoku,
                              size: 210,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),
                      Text(
                        l10n.slogan,
                        style: TextStyle(
                          fontSize: 18,
                          color: onHeroMuted,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 48),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: FilledButton(
                          clipBehavior: Clip.antiAlias,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GameScreen(),
                              ),
                            );
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: freePlayFill,
                            foregroundColor: freePlayText,
                            surfaceTintColor: Colors.transparent,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 1.15,
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                          ),
                          child: Text(
                            l10n.freeMode,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: OutlinedButton(
                          clipBehavior: Clip.antiAlias,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CampaignModeScreen(),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: onHero,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            side: BorderSide(
                              color: onHero.withValues(alpha: 0.82),
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 1.15,
                              leadingDistribution: TextLeadingDistribution.even,
                            ),
                          ),
                          child: Text(
                            l10n.campaignMode,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextButton.icon(
                        onPressed: () => _showRulesDialog(context),
                        style: TextButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        icon: Icon(
                          Icons.help_outline,
                          color: onHeroMuted,
                          size: 20,
                        ),
                        label: Text(
                          l10n.rulesTitle,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            color: onHeroMuted,
                            fontSize: 16,
                            height: 1.15,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_showThemeGuide)
              Positioned.fill(
                child: ThemeGuideLayer(
                  target: _settingsTarget(context),
                  activePalette: AppPalette.values[_guidePaletteIndex],
                  onDismiss: () => _dismissThemeGuide(),
                ),
              ),
            Positioned.directional(
              textDirection: Directionality.of(context),
              top: settingsTop,
              end: _settingsEnd,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cornerIconButton(
                    tooltip: l10n.themeTitle,
                    icon: Icons.palette_outlined,
                    color: onHeroMuted,
                    onPressed: _openThemeQuickPick,
                  ),
                  _cornerIconButton(
                    tooltip: l10n.settingsTitle,
                    icon: Icons.settings_outlined,
                    color: onHeroMuted,
                    onPressed: () => _dismissThemeGuide(openSettings: true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRulesDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.rulesTitle),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.rulesGoal,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(l10n.rulesGoalDesc, style: const TextStyle(height: 1.5)),
              const SizedBox(height: 20),
              Text(
                l10n.rulesBasic,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(l10n.rulesBasicItems, style: const TextStyle(height: 1.6)),
              const SizedBox(height: 20),
              Text(
                l10n.rulesOps,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(l10n.rulesOpsItems, style: const TextStyle(height: 1.6)),
            ],
          ),
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.rulesGotIt),
          ),
        ],
      ),
    );
  }
}
