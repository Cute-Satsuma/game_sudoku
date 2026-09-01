import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/app_localizations.dart';
import 'screens/home_screen.dart';
import 'services/campaign_progress.dart';
import 'services/game_settings_controller.dart';
import 'theme/caju_style.dart';
import 'theme/launcher_icon.dart';
import 'theme/paper_filter.dart';
import 'theme/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(CampaignProgress.ensureInitialized());
  final themeController = ThemeController();
  final gameSettings = GameSettingsController();
  await Future.wait([
    themeController.load(),
    gameSettings.load(),
    SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(
    SudokuApp(
      themeController: themeController,
      gameSettings: gameSettings,
    ),
  );
}

class SudokuApp extends StatefulWidget {
  const SudokuApp({
    super.key,
    required this.themeController,
    required this.gameSettings,
    this.localeOverride,
  });

  final ThemeController themeController;
  final GameSettingsController gameSettings;
  final Locale? localeOverride;

  @override
  State<SudokuApp> createState() => _SudokuAppState();
}

class _SudokuAppState extends State<SudokuApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      syncLauncherIcon(widget.themeController.iconStyle);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeController = widget.themeController;
    final locale =
        widget.localeOverride ??
        WidgetsBinding.instance.platformDispatcher.locale;
    return ThemeScope(
      controller: themeController,
      child: GameSettingsScope(
        controller: widget.gameSettings,
        child: ListenableBuilder(
          listenable: themeController,
          builder: (context, _) {
            return MaterialApp(
            locale: locale,
            title: AppLocalizations.get(locale.languageCode).appTitle,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('zh'),
              Locale('hi'),
              Locale('es'),
              Locale('ar'),
              Locale('fr'),
              Locale('bn'),
              Locale('pt'),
              Locale('ru'),
              Locale('id'),
              Locale('ur'),
              Locale('de'),
              Locale('ja'),
              Locale('vi'),
              Locale('tr'),
              Locale('ko'),
              Locale('it'),
              Locale('th'),
            ],
            theme: buildAppTheme(
              themeController.palette,
              Brightness.light,
              typeface: themeController.typeface,
              paperFilter: themeController.paperFilter,
            ),
            darkTheme: buildAppTheme(
              themeController.palette,
              Brightness.dark,
              typeface: themeController.typeface,
              paperFilter: themeController.paperFilter,
            ),
            themeMode: themeController.themeMode,
            themeAnimationDuration: const Duration(milliseconds: 420),
            builder: (context, child) {
              final brightness = Theme.of(context).brightness;
              final darkIcons = brightness == Brightness.light;
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  systemNavigationBarColor: Colors.transparent,
                  statusBarIconBrightness: darkIcons
                      ? Brightness.dark
                      : Brightness.light,
                  systemNavigationBarIconBrightness: darkIcons
                      ? Brightness.dark
                      : Brightness.light,
                  systemStatusBarContrastEnforced: false,
                  systemNavigationBarContrastEnforced: false,
                ),
                child: _WebPhoneShell(
                  child: PaperFilterOverlay(
                    child: child ?? const SizedBox.shrink(),
                  ),
                ),
              );
            },
            home: const HomeScreen(),
          );
        },
        ),
      ),
    );
  }
}

/// 手机以外的宽屏用竖屏宽度居中，避免被拉成横屏多列。
class _WebPhoneShell extends StatelessWidget {
  const _WebPhoneShell({required this.child});

  final Widget child;
  static const double _phoneWidth = 420;
  static const double _frameBreakpoint = 520;

  static bool get _usesPortraitFrame {
    if (kIsWeb) return true;
    return switch (defaultTargetPlatform) {
      TargetPlatform.macOS ||
      TargetPlatform.windows ||
      TargetPlatform.linux => true,
      _ => false,
    };
  }

  @override
  Widget build(BuildContext context) {
    if (!_usesPortraitFrame) return child;

    final mq = MediaQuery.of(context);
    if (mq.size.width <= _frameBreakpoint) {
      return child;
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final stageColor = isDark
        ? const Color(0xFF12100F)
        : const Color(0xFFFFFAF4);

    return ColoredBox(
      color: stageColor,
      child: LayoutBuilder(
        builder: (context, constraints) {
          const verticalMargin = 20.0;
          final phoneHeight = (constraints.maxHeight - verticalMargin * 2)
              .clamp(560.0, 880.0);
          return Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _PortalBackdropPainter(isDark: isDark),
                ),
              ),
              if (constraints.maxWidth >= 920)
                Positioned(
                  left: 34,
                  top: 28,
                  child: _WebBrandMark(isDark: isDark),
                ),
              Center(
                child: Container(
                  width: _phoneWidth,
                  height: phoneHeight,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.10)
                          : const Color(0xFFEADFD5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: isDark ? 0.32 : 0.10,
                        ),
                        blurRadius: 30,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(21),
                    child: MediaQuery(
                      data: mq.copyWith(
                        size: Size(_phoneWidth, phoneHeight),
                        padding: EdgeInsets.zero,
                        viewPadding: EdgeInsets.zero,
                        viewInsets: EdgeInsets.zero,
                      ),
                      child: child,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _WebBrandMark extends StatelessWidget {
  const _WebBrandMark({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final ink = isDark ? const Color(0xFFF7EFE9) : const Color(0xFF302019);
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: const Color(0xFFE85D18),
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE85D18).withValues(alpha: 0.22),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(Icons.eco_rounded, size: 21, color: Colors.white),
        ),
        const SizedBox(width: 11),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Caju',
              style: TextStyle(
                color: ink,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
            const Text(
              'CUTE SATSUMA',
              style: TextStyle(
                color: Color(0xFFE85D18),
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PortalBackdropPainter extends CustomPainter {
  const _PortalBackdropPainter({required this.isDark});

  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = (isDark ? Colors.white : const Color(0xFF3E2723)).withValues(
        alpha: isDark ? 0.025 : 0.035,
      )
      ..strokeWidth = 1;
    const step = 32.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    void glow(Offset center, double radius, Color color) {
      final paint = Paint()
        ..shader = RadialGradient(
          colors: [color, color.withValues(alpha: 0)],
        ).createShader(Rect.fromCircle(center: center, radius: radius));
      canvas.drawCircle(center, radius, paint);
    }

    glow(
      Offset(size.width * 0.10, size.height * 0.16),
      250,
      const Color(0xFFFFC85A).withValues(alpha: isDark ? 0.07 : 0.16),
    );
    glow(
      Offset(size.width * 0.92, size.height * 0.58),
      310,
      const Color(0xFFE85D18).withValues(alpha: isDark ? 0.06 : 0.10),
    );
  }

  @override
  bool shouldRepaint(covariant _PortalBackdropPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}
