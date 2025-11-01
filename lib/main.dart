import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';
import 'providers/app_provider.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize date formatting for Vietnamese locale
  await initializeDateFormatting('vi_VN', null);
  await initializeDateFormatting('en_US', null);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppProvider()..initialize(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, _) {
        return MaterialApp(
          title: 'Weather App',
          debugShowCheckedModeBanner: false,

          // Theme Configuration
          theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
            fontFamily: 'Roboto',
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
            fontFamily: 'Roboto',
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF0F172A),
          ),
          themeMode: appProvider.themeMode,

          // Localization Configuration
          locale: appProvider.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          home: const SplashScreen(),
        );
      },
    );
  }
}
