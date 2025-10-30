import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';
import '../providers/app_provider.dart';
import '../utils/app_theme.dart';
import '../widgets/background_preview_widget.dart';

class NewSettingsScreen extends StatefulWidget {
  const NewSettingsScreen({super.key});

  @override
  State<NewSettingsScreen> createState() => _NewSettingsScreenState();
}

class _NewSettingsScreenState extends State<NewSettingsScreen> {
  bool _notificationsEnabled = true;
  String _temperatureUnit = 'metric';
  String _windSpeedUnit = 'ms';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications') ?? true;
      _temperatureUnit = prefs.getString('temperatureUnit') ?? 'metric';
      _windSpeedUnit = prefs.getString('windSpeedUnit') ?? 'ms';
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications', _notificationsEnabled);
    await prefs.setString('temperatureUnit', _temperatureUnit);
    await prefs.setString('windSpeedUnit', _windSpeedUnit);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final appProvider = Provider.of<AppProvider>(context);
    final isDarkMode = appProvider.isDarkMode;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.getDynamicGradient(
            weatherCondition: 'Clear',
            dateTime: DateTime.now(),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context, l10n, isDarkMode),
              Expanded(
                child: SingleChildScrollView(
                  // Đổi từ ListView sang SingleChildScrollView
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    // Wrap content trong Column
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Language Section
                      _buildSectionTitle(l10n.language, isDarkMode),
                      _buildSettingsCard(isDarkMode, [
                        _buildLanguageSelector(context, l10n, appProvider),
                      ]),
                      const SizedBox(height: 24),

                      // Appearance Section
                      _buildSectionTitle(l10n.appearance, isDarkMode),
                      _buildSettingsCard(isDarkMode, [
                        _buildThemeSelector(context, l10n, appProvider),
                        const Divider(height: 1),
                        _buildBackgroundPreviewButton(
                          context,
                          l10n,
                          isDarkMode,
                        ),
                      ]),
                      const SizedBox(height: 24),

                      // Units Section
                      _buildSectionTitle(l10n.units, isDarkMode),
                      _buildSettingsCard(isDarkMode, [
                        _buildTemperatureUnitSetting(l10n, isDarkMode),
                        const Divider(height: 1),
                        _buildWindSpeedUnitSetting(l10n, isDarkMode),
                      ]),
                      const SizedBox(height: 24),

                      // Notifications Section
                      _buildSectionTitle(l10n.notifications, isDarkMode),
                      _buildSettingsCard(isDarkMode, [
                        _buildNotificationsSetting(l10n, isDarkMode),
                      ]),
                      const SizedBox(height: 24),

                      // About Section
                      _buildSectionTitle(l10n.about, isDarkMode),
                      _buildSettingsCard(isDarkMode, [
                        _buildInfoItem(l10n.version, '1.0.0', isDarkMode),
                        const Divider(height: 1),
                        _buildInfoItem(
                          l10n.developer,
                          'Weather App Team',
                          isDarkMode,
                        ),
                      ]),
                      const SizedBox(height: 24),

                      _buildAboutSection(l10n, isDarkMode),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(
    BuildContext context,
    AppLocalizations l10n,
    bool isDarkMode,
  ) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            l10n.settingsTitle,
            style: AppTheme.headlineLarge.copyWith(
              shadows: [
                Shadow(color: Colors.black.withOpacity(0.3), blurRadius: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(color: Colors.black.withOpacity(0.3), blurRadius: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(bool isDarkMode, List<Widget> children) {
    return Container(
      decoration: AppTheme.getCardDecoration(isDarkMode).copyWith(
        color: isDarkMode
            ? Colors.black.withOpacity(0.3)
            : Colors.white.withOpacity(0.9),
      ),
      child: Column(children: children),
    );
  }

  // Language Selector
  Widget _buildLanguageSelector(
    BuildContext context,
    AppLocalizations l10n,
    AppProvider appProvider,
  ) {
    final isDarkMode = appProvider.isDarkMode;
    return ListTile(
      leading: Icon(
        Icons.language,
        color: isDarkMode ? Colors.white : AppTheme.primaryBlue,
      ),
      title: Text(
        l10n.languageTitle,
        style: TextStyle(
          color: AppTheme.getTextColor(isDarkMode),
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        l10n.languageDesc,
        style: TextStyle(
          color: AppTheme.getTextColor(isDarkMode, isPrimary: false),
          fontSize: 12,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppTheme.primaryBlue.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              appProvider.locale.languageCode == 'vi'
                  ? '🇻🇳 ${l10n.vietnamese}'
                  : '🇺🇸 ${l10n.english}',
              style: TextStyle(
                color: isDarkMode ? Colors.white : AppTheme.primaryBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              color: isDarkMode ? Colors.white : AppTheme.primaryBlue,
            ),
          ],
        ),
      ),
      onTap: () => _showLanguageDialog(context, l10n, appProvider),
    );
  }

  void _showLanguageDialog(
    BuildContext context,
    AppLocalizations l10n,
    AppProvider appProvider,
  ) {
    final isDarkMode = appProvider.isDarkMode;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDarkMode
              ? AppTheme.darkCardBackground
              : Colors.white,
          title: Text(
            l10n.languageTitle,
            style: TextStyle(color: AppTheme.getTextColor(isDarkMode)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption(
                context,
                '🇻🇳 ${l10n.vietnamese}',
                const Locale('vi', 'VN'),
                appProvider,
                isDarkMode,
              ),
              const SizedBox(height: 8),
              _buildLanguageOption(
                context,
                '🇺🇸 ${l10n.english}',
                const Locale('en', 'US'),
                appProvider,
                isDarkMode,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    String label,
    Locale locale,
    AppProvider appProvider,
    bool isDarkMode,
  ) {
    final isSelected = appProvider.locale == locale;
    return InkWell(
      onTap: () {
        appProvider.setLocale(locale);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryBlue.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryBlue
                : AppTheme.getBorderColor(isDarkMode),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: AppTheme.getTextColor(isDarkMode),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: AppTheme.primaryBlue),
          ],
        ),
      ),
    );
  }

  // Theme Selector
  Widget _buildThemeSelector(
    BuildContext context,
    AppLocalizations l10n,
    AppProvider appProvider,
  ) {
    final isDarkMode = appProvider.isDarkMode;
    String themeName;
    if (appProvider.themeMode == ThemeMode.light) {
      themeName = l10n.lightMode;
    } else if (appProvider.themeMode == ThemeMode.dark) {
      themeName = l10n.darkMode;
    } else {
      themeName = l10n.systemMode;
    }

    return ListTile(
      leading: Icon(
        appProvider.themeMode == ThemeMode.dark
            ? Icons.dark_mode
            : appProvider.themeMode == ThemeMode.light
            ? Icons.light_mode
            : Icons.brightness_auto,
        color: isDarkMode ? Colors.white : AppTheme.primaryBlue,
      ),
      title: Text(
        l10n.themeMode,
        style: TextStyle(
          color: AppTheme.getTextColor(isDarkMode),
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        l10n.themeModeDesc,
        style: TextStyle(
          color: AppTheme.getTextColor(isDarkMode, isPrimary: false),
          fontSize: 12,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppTheme.primaryBlue.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              themeName,
              style: TextStyle(
                color: isDarkMode ? Colors.white : AppTheme.primaryBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              color: isDarkMode ? Colors.white : AppTheme.primaryBlue,
            ),
          ],
        ),
      ),
      onTap: () => _showThemeDialog(context, l10n, appProvider),
    );
  }

  void _showThemeDialog(
    BuildContext context,
    AppLocalizations l10n,
    AppProvider appProvider,
  ) {
    final isDarkMode = appProvider.isDarkMode;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDarkMode
              ? AppTheme.darkCardBackground
              : Colors.white,
          title: Text(
            l10n.themeMode,
            style: TextStyle(color: AppTheme.getTextColor(isDarkMode)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildThemeOption(
                context,
                Icons.light_mode,
                l10n.lightMode,
                ThemeMode.light,
                appProvider,
                isDarkMode,
              ),
              const SizedBox(height: 8),
              _buildThemeOption(
                context,
                Icons.dark_mode,
                l10n.darkMode,
                ThemeMode.dark,
                appProvider,
                isDarkMode,
              ),
              const SizedBox(height: 8),
              _buildThemeOption(
                context,
                Icons.brightness_auto,
                l10n.systemMode,
                ThemeMode.system,
                appProvider,
                isDarkMode,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    IconData icon,
    String label,
    ThemeMode mode,
    AppProvider appProvider,
    bool isDarkMode,
  ) {
    final isSelected = appProvider.themeMode == mode;
    return InkWell(
      onTap: () {
        appProvider.setThemeMode(mode);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryBlue.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryBlue
                : AppTheme.getBorderColor(isDarkMode),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? AppTheme.primaryBlue
                  : AppTheme.getTextColor(isDarkMode),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: AppTheme.getTextColor(isDarkMode),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: AppTheme.primaryBlue),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundPreviewButton(
    BuildContext context,
    AppLocalizations l10n,
    bool isDarkMode,
  ) {
    return ListTile(
      leading: Icon(
        Icons.palette,
        color: isDarkMode ? Colors.white : AppTheme.primaryBlue,
      ),
      title: Text(
        l10n.viewBackgrounds,
        style: TextStyle(
          color: AppTheme.getTextColor(isDarkMode),
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        l10n.viewBackgroundsDesc,
        style: TextStyle(
          color: AppTheme.getTextColor(isDarkMode, isPrimary: false),
          fontSize: 12,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: AppTheme.getTextColor(isDarkMode, isPrimary: false),
        size: 16,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BackgroundPreviewWidget(),
          ),
        );
      },
    );
  }

  Widget _buildTemperatureUnitSetting(AppLocalizations l10n, bool isDarkMode) {
    return ListTile(
      leading: Icon(
        Icons.thermostat,
        color: isDarkMode ? Colors.white : AppTheme.primaryBlue,
      ),
      title: Text(
        l10n.temperatureUnit,
        style: TextStyle(
          color: AppTheme.getTextColor(isDarkMode),
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: DropdownButton<String>(
        value: _temperatureUnit,
        dropdownColor: isDarkMode ? AppTheme.darkCardBackground : Colors.white,
        style: TextStyle(color: AppTheme.getTextColor(isDarkMode)),
        underline: Container(),
        items: [
          DropdownMenuItem(value: 'metric', child: Text(l10n.celsius)),
          DropdownMenuItem(value: 'imperial', child: Text(l10n.fahrenheit)),
        ],
        onChanged: (value) {
          setState(() {
            _temperatureUnit = value!;
          });
          _saveSettings();
        },
      ),
    );
  }

  Widget _buildWindSpeedUnitSetting(AppLocalizations l10n, bool isDarkMode) {
    return ListTile(
      leading: Icon(
        Icons.air,
        color: isDarkMode ? Colors.white : AppTheme.primaryBlue,
      ),
      title: Text(
        l10n.windSpeedUnit,
        style: TextStyle(
          color: AppTheme.getTextColor(isDarkMode),
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: DropdownButton<String>(
        value: _windSpeedUnit,
        dropdownColor: isDarkMode ? AppTheme.darkCardBackground : Colors.white,
        style: TextStyle(color: AppTheme.getTextColor(isDarkMode)),
        underline: Container(),
        items: [
          DropdownMenuItem(value: 'ms', child: Text(l10n.metersPerSecond)),
          DropdownMenuItem(value: 'mph', child: Text(l10n.milesPerHour)),
          DropdownMenuItem(value: 'kmh', child: Text(l10n.kilometersPerHour)),
        ],
        onChanged: (value) {
          setState(() {
            _windSpeedUnit = value!;
          });
          _saveSettings();
        },
      ),
    );
  }

  Widget _buildNotificationsSetting(AppLocalizations l10n, bool isDarkMode) {
    return SwitchListTile(
      secondary: Icon(
        Icons.notifications,
        color: isDarkMode ? Colors.white : AppTheme.primaryBlue,
      ),
      title: Text(
        l10n.weatherNotifications,
        style: TextStyle(
          color: AppTheme.getTextColor(isDarkMode),
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        l10n.weatherNotificationsDesc,
        style: TextStyle(
          color: AppTheme.getTextColor(isDarkMode, isPrimary: false),
          fontSize: 12,
        ),
      ),
      value: _notificationsEnabled,
      activeColor: AppTheme.primaryBlue,
      onChanged: (value) {
        setState(() {
          _notificationsEnabled = value;
        });
        _saveSettings();
      },
    );
  }

  Widget _buildInfoItem(String title, String value, bool isDarkMode) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: AppTheme.getTextColor(isDarkMode),
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        value,
        style: TextStyle(
          color: AppTheme.getTextColor(isDarkMode, isPrimary: false),
        ),
      ),
    );
  }

  Widget _buildAboutSection(AppLocalizations l10n, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.getCardDecoration(isDarkMode).copyWith(
        color: isDarkMode
            ? Colors.black.withOpacity(0.3)
            : Colors.white.withOpacity(0.9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.aboutApp,
            style: TextStyle(
              color: AppTheme.getTextColor(isDarkMode),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.aboutAppDesc,
            style: TextStyle(
              color: AppTheme.getTextColor(isDarkMode, isPrimary: false),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.dataProvider,
            style: TextStyle(
              color: AppTheme.getTextColor(isDarkMode, isPrimary: false),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
