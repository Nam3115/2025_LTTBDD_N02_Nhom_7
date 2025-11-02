import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/weather_details_model.dart';
import '../models/weather_model.dart';
import '../utils/app_theme.dart';
import '../l10n/app_localizations.dart';

/// Weather Details Grid - MSN Weather inspired
/// Displays comprehensive weather information in a grid layout
class WeatherDetailsGrid extends StatelessWidget {
  final Weather weather;
  final WeatherDetails details;

  const WeatherDetailsGrid({
    Key? key,
    required this.weather,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Row(
            children: [
              const Icon(
                FontAwesomeIcons.circleInfo,
                size: 20,
                color: AppTheme.white,
              ),
              const SizedBox(width: AppTheme.spacingS),
              Text(l10n.weatherDetails, style: AppTheme.headlineSmall),
            ],
          ),
          const SizedBox(height: AppTheme.spacingM),

          // Grid of detail cards
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: AppTheme.spacingM,
            crossAxisSpacing: AppTheme.spacingM,
            childAspectRatio: 1.3,
            children: [
              _buildDetailCard(
                icon: FontAwesomeIcons.temperatureHalf,
                title: l10n.feelsLike,
                value: '${details.feelsLike.round()}°',
                subtitle: details.getFeelsLikeDescription(weather.temperature),
                color: _getTemperatureColor(details.feelsLike),
              ),
              _buildDetailCard(
                icon: FontAwesomeIcons.wind,
                title: l10n.wind,
                value: '${details.windSpeedKmh.round()} km/h',
                subtitle: details.getWindDirection(),
                color: AppTheme.lightBlue,
                trailing: _buildWindDirectionIcon(details.windDeg),
              ),
              _buildDetailCard(
                icon: FontAwesomeIcons.droplet,
                title: l10n.humidity,
                value: '${details.humidity}%',
                subtitle: details.getHumidityDescription(),
                color: AppTheme.blue,
              ),
              _buildDetailCard(
                icon: FontAwesomeIcons.eye,
                title: l10n.visibility,
                value: '${(details.visibility / 1000).toStringAsFixed(1)} km',
                subtitle: details.getVisibilityDescription(),
                color: AppTheme.lightPurple,
              ),
              _buildDetailCard(
                icon: FontAwesomeIcons.gaugeHigh,
                title: l10n.pressure,
                value: '${details.pressure} hPa',
                subtitle: details.getPressureDescription(),
                color: AppTheme.orange,
              ),
              _buildDetailCard(
                icon: FontAwesomeIcons.cloud,
                title: l10n.cloudiness,
                value: '${details.cloudiness}%',
                subtitle: _getCloudinessDescription(details.cloudiness),
                color: AppTheme.grey,
              ),
            ],
          ),

          // Min/Max Temperature Card (Full Width)
          const SizedBox(height: AppTheme.spacingM),
          _buildMinMaxTempCard(context),
        ],
      ),
    );
  }

  Widget _buildDetailCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color color,
    Widget? trailing,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withOpacity(0.3), color.withOpacity(0.1)],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        border: Border.all(color: AppTheme.white.withOpacity(0.2), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon and Title
            Row(
              children: [
                FaIcon(icon, size: 16, color: AppTheme.white.withOpacity(0.7)),
                const SizedBox(width: AppTheme.spacingXS),
                Expanded(
                  child: Text(
                    title,
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.white.withOpacity(0.7),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (trailing != null) trailing,
              ],
            ),
            const SizedBox(height: AppTheme.spacingXS),

            // Value
            Text(
              value,
              style: AppTheme.headlineMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),

            // Subtitle/Description
            Text(
              subtitle,
              style: AppTheme.bodySmall.copyWith(
                color: AppTheme.white.withOpacity(0.6),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWindDirectionIcon(int degrees) {
    return Transform.rotate(
      angle: degrees * 3.14159 / 180,
      child: FaIcon(
        FontAwesomeIcons.locationArrow,
        size: 14,
        color: AppTheme.white.withOpacity(0.7),
      ),
    );
  }

  Widget _buildMinMaxTempCard(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.orange.withOpacity(0.3),
            AppTheme.blue.withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        border: Border.all(color: AppTheme.white.withOpacity(0.2), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Row(
          children: [
            // Min Temperature
            Expanded(
              child: Column(
                children: [
                  FaIcon(
                    FontAwesomeIcons.temperatureArrowDown,
                    size: 20,
                    color: AppTheme.blue.withOpacity(0.9),
                  ),
                  const SizedBox(height: AppTheme.spacingXS),
                  Text(
                    l10n.minTemp,
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${details.tempMin.round()}°',
                    style: AppTheme.headlineMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.blue,
                    ),
                  ),
                ],
              ),
            ),

            // Divider
            Container(
              width: 1,
              height: 60,
              color: AppTheme.white.withOpacity(0.2),
            ),

            // Max Temperature
            Expanded(
              child: Column(
                children: [
                  FaIcon(
                    FontAwesomeIcons.temperatureArrowUp,
                    size: 20,
                    color: AppTheme.orange.withOpacity(0.9),
                  ),
                  const SizedBox(height: AppTheme.spacingXS),
                  Text(
                    l10n.maxTemp,
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${details.tempMax.round()}°',
                    style: AppTheme.headlineMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.orange,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTemperatureColor(double temp) {
    if (temp >= 35) return Colors.red;
    if (temp >= 30) return AppTheme.orange;
    if (temp >= 25) return Colors.amber;
    if (temp >= 20) return Colors.green;
    if (temp >= 15) return AppTheme.lightBlue;
    return AppTheme.blue;
  }

  String _getCloudinessDescription(int cloudiness) {
    if (cloudiness >= 85) return 'U ám';
    if (cloudiness >= 65) return 'Nhiều mây';
    if (cloudiness >= 35) return 'Có mây';
    if (cloudiness >= 15) return 'Ít mây';
    return 'Quang đãng';
  }
}
