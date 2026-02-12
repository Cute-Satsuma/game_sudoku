import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/app_localizations.dart';
import 'screens/home_screen.dart';
import 'services/campaign_progress.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Defer storage init to avoid blocking startup; fallback to in-memory if plugin fails
  unawaited(CampaignProgress.ensureInitialized());
  runApp(const SudokuApp());
}

class SudokuApp extends StatelessWidget {
  const SudokuApp({super.key, this.localeOverride});

  /// Override locale for testing; null = use system locale
  final Locale? localeOverride;

  @override
  Widget build(BuildContext context) {
    final locale = localeOverride ?? WidgetsBinding.instance.platformDispatcher.locale;
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
      // Top 18 languages by usage, follows system locale
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
