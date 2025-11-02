import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider quản lý theme mode và language
class AppProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('vi', 'VN');
  bool _isInitialized = false;

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  bool get isInitialized => _isInitialized;

  bool get isDarkMode {
    if (_themeMode == ThemeMode.dark) return true;
    if (_themeMode == ThemeMode.light) return false;
    // System mode - check device brightness
    return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark;
  }

  /// Initialize settings from SharedPreferences
  Future<void> initialize() async {
    if (_isInitialized) return;

    final prefs = await SharedPreferences.getInstance();

    // Load theme mode
    final themeModeString = prefs.getString('theme_mode') ?? 'system';
    _themeMode = _parseThemeMode(themeModeString);

    // Load language
    final languageCode = prefs.getString('language_code') ?? 'vi';
    final countryCode = prefs.getString('country_code') ?? 'VN';
    _locale = Locale(languageCode, countryCode);

    // Ensure intl uses the stored locale for DateFormat/NumberFormat
    try {
      Intl.defaultLocale = _locale.toString();
    } catch (_) {}

    _isInitialized = true;
    notifyListeners();
  }

  /// Set theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;

    _themeMode = mode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', _themeModeToString(mode));
  }

  /// Set locale (language)
  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;

    _locale = locale;
    // Update Intl default locale so DateFormat/NumberFormat react immediately
    try {
      Intl.defaultLocale = _locale.toString();
    } catch (_) {}

    // Debug log to help trace locale changes during runtime
    // ignore: avoid_print
    print('AppProvider: locale changed -> ${_locale.toString()}');

    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
    await prefs.setString('country_code', locale.countryCode ?? '');
  }

  /// Toggle between light and dark mode
  Future<void> toggleTheme() async {
    if (_themeMode == ThemeMode.light) {
      await setThemeMode(ThemeMode.dark);
    } else {
      await setThemeMode(ThemeMode.light);
    }
  }

  /// Toggle between Vietnamese and English
  Future<void> toggleLanguage() async {
    if (_locale.languageCode == 'vi') {
      await setLocale(const Locale('en', 'US'));
    } else {
      await setLocale(const Locale('vi', 'VN'));
    }
  }

  // Helper methods
  ThemeMode _parseThemeMode(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }

  String getThemeModeName(BuildContext context, ThemeMode mode) {
    // You can use AppLocalizations here if needed
    switch (mode) {
      case ThemeMode.light:
        return 'Light Mode';
      case ThemeMode.dark:
        return 'Dark Mode';
      case ThemeMode.system:
        return 'System Default';
    }
  }
}
