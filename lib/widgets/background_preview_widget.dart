import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../l10n/app_localizations.dart';

/// Widget để preview tất cả các background gradient
/// Dùng để test và xem các màu sắc thay đổi theo thời gian và thời tiết
class BackgroundPreviewWidget extends StatelessWidget {
  const BackgroundPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.viewBackgrounds),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(l10n.viewBackgrounds, [
            _buildGradientCard(
              '${l10n.dawn} (5:00-7:00)',
              AppTheme.clearSkyDawnGradient,
              '🌅',
            ),
            _buildGradientCard(
              '${l10n.morning} (7:00-11:00)',
              AppTheme.clearSkyMorningGradient,
              '☀️',
            ),
            _buildGradientCard(
              '${l10n.noon} (11:00-15:00)',
              AppTheme.clearSkyNoonGradient,
              '🌞',
            ),
            _buildGradientCard(
              '${l10n.afternoon} (15:00-18:00)',
              AppTheme.clearSkyAfternoonGradient,
              '🌇',
            ),
            _buildGradientCard(
              '${l10n.dusk} (18:00-19:30)',
              AppTheme.clearSkySunsetGradient,
              '🌆',
            ),
            _buildGradientCard(
              '${l10n.evening} (19:30-21:00)',
              AppTheme.clearSkyDuskGradient,
              '🌃',
            ),
            _buildGradientCard(
              '${l10n.night} (21:00-5:00)',
              AppTheme.clearSkyNightGradient,
              '🌙',
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection(l10n.clouds, [
            _buildGradientCard(
              '${l10n.clouds} (Day)',
              AppTheme.cloudyDayGradient,
              '☁️',
            ),
            _buildGradientCard(
              '${l10n.clouds} (Night)',
              AppTheme.cloudyNightGradient,
              '☁️🌙',
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection(l10n.rain, [
            _buildGradientCard(
              '${l10n.rain} (Day)',
              AppTheme.rainyDayGradient,
              '🌧️',
            ),
            _buildGradientCard(
              '${l10n.rain} (Night)',
              AppTheme.rainyNightGradient,
              '🌧️🌙',
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection(l10n.weatherDetails, [
            _buildGradientCard(
              l10n.thunderstorm,
              AppTheme.thunderstormGradient,
              '⛈️',
            ),
            _buildGradientCard(l10n.snow, AppTheme.snowDayGradient, '❄️'),
            _buildGradientCard(
              '${l10n.snow} (Night)',
              AppTheme.snowNightGradient,
              '❄️🌙',
            ),
            _buildGradientCard(l10n.mist, AppTheme.mistGradient, '🌫️'),
          ]),
          const SizedBox(height: 24),
          _buildTestSection(context),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildGradientCard(
    String label,
    LinearGradient gradient,
    String emoji,
  ) {
    return Container(
      height: 120,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Label
          Positioned(
            left: 16,
            top: 16,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
              ),
            ),
          ),
          // Emoji
          Positioned(
            right: 16,
            bottom: 16,
            child: Text(emoji, style: const TextStyle(fontSize: 48)),
          ),
        ],
      ),
    );
  }

  Widget _buildTestSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.viewBackgrounds,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        _buildDynamicTestCard(context, 'Clear', DateTime.now()),
        _buildDynamicTestCard(context, 'Clouds', DateTime.now()),
        _buildDynamicTestCard(context, 'Rain', DateTime.now()),
        const SizedBox(height: 16),
        Text(
          l10n.viewBackgroundsDesc,
          style: const TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildDynamicTestCard(
    BuildContext context,
    String condition,
    DateTime dateTime,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final gradient = AppTheme.getDynamicGradient(
      weatherCondition: condition,
      dateTime: dateTime,
    );
    final timeOfDay = AppTheme.getTimeOfDay(dateTime);
    final hour = dateTime.hour;

    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$condition - ${l10n.now}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
              ),
            ),
            Text(
              '🕐 ${hour.toString().padLeft(2, '0')}:00 - $timeOfDay',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
