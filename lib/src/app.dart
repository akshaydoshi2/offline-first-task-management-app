import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tushop_assesment/l10n/app_localizations.dart';
import 'package:tushop_assesment/src/pages/splash/splash_screen.dart';
import 'package:tushop_assesment/src/providers/language_provider.dart';
import 'package:tushop_assesment/src/utilities/theme.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        title: 'Tushop Assesment',
        localizationsDelegates: const [
          // CountryLocalizations.delegate,
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: ref.watch(languageProvider),
        supportedLocales: const [
          Locale('en'),
          Locale('sw'),
        ],
        theme: Themes.light,
        home: const SplashScreen()
    );
  }
}