import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/forecast_model.dart';
import '../utils/app_theme.dart';
import 'package:weather_icons/weather_icons.dart';
import '../l10n/app_localizations.dart';

class ModernHourlyForecast extends StatelessWidget {
  final List<HourlyForecast> forecasts;

  const ModernHourlyForecast({super.key, required this.forecasts});

  IconData _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return WeatherIcons.day_sunny;
      case 'clouds':
        return WeatherIcons.cloudy;
      case 'rain':
        return WeatherIcons.rain;
      case 'drizzle':
        return WeatherIcons.sprinkle;
      case 'thunderstorm':
        return WeatherIcons.thunderstorm;
      case 'snow':
        return WeatherIcons.snow;
      case 'mist':
      case 'fog':
        return WeatherIcons.fog;
      default:
        return WeatherIcons.day_sunny;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppTheme.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: AppTheme.spacingM),
            child: Text(l10n.hourlyForecast, style: AppTheme.titleLarge),
          ),
          const SizedBox(height: AppTheme.spacingM),
          SizedBox(
            height: 110, // Giảm xuống 110 để chắc chắn
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingM,
              ),
              itemCount: forecasts.take(12).length,
              itemBuilder: (context, index) {
                final forecast = forecasts[index];
                final time = DateFormat('HH:mm').format(forecast.time);
                final isNow = index == 0;

                return Container(
                  width: 68, // Giảm từ 70 xuống 68
                  margin: const EdgeInsets.only(right: AppTheme.spacingM),
                  padding: const EdgeInsets.all(8), // Đơn giản hóa padding
                  decoration: AppTheme.glassmorphicCard.copyWith(
                    color: isNow
                        ? AppTheme.white.withOpacity(0.25)
                        : AppTheme.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(AppTheme.radiusXL),
                  ),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceAround, // Dùng spaceAround
                    mainAxisSize:
                        MainAxisSize.max, // Cho phép expand full height
                    children: [
                      // Time
                      Text(
                        isNow ? l10n.now : time,
                        style: AppTheme.labelMedium.copyWith(
                          color: isNow
                              ? AppTheme.white
                              : AppTheme.white.withOpacity(0.8),
                          fontSize: 10,
                        ),
                        maxLines: 1,
                      ),
                      // Weather Icon
                      BoxedIcon(
                        _getWeatherIcon(forecast.mainCondition),
                        size: 24, // Giảm từ 26 xuống 24
                        color: AppTheme.white,
                      ),
                      // Temperature
                      Text(
                        '${forecast.temperature.round()}°',
                        style: AppTheme.titleLarge.copyWith(
                          fontWeight: isNow ? FontWeight.bold : FontWeight.w600,
                          fontSize: 14, // Giảm từ 15 xuống 14
                        ),
                        maxLines: 1,
                      ),
                      // Humidity
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.water_drop,
                            size: 8, // Giảm từ 9 xuống 8
                            color: AppTheme.white.withOpacity(0.7),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${forecast.humidity}%',
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.white.withOpacity(0.7),
                              fontSize: 9,
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ModernDailyForecast extends StatelessWidget {
  final List<DailyForecast> forecasts;

  const ModernDailyForecast({super.key, required this.forecasts});

  IconData _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return WeatherIcons.day_sunny;
      case 'clouds':
        return WeatherIcons.cloudy;
      case 'rain':
        return WeatherIcons.rain;
      case 'drizzle':
        return WeatherIcons.sprinkle;
      case 'thunderstorm':
        return WeatherIcons.thunderstorm;
      case 'snow':
        return WeatherIcons.snow;
      case 'mist':
      case 'fog':
        return WeatherIcons.fog;
      default:
        return WeatherIcons.day_sunny;
    }
  }

  String _getDayName(DateTime date, BuildContext context) {
    final now = DateTime.now();
    if (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year) {
      return AppLocalizations.of(context)!.today;
    } else if (date.day == now.add(const Duration(days: 1)).day) {
      return AppLocalizations.of(context)!.tomorrow;
    }
    return DateFormat(
      'EEEE',
      Localizations.localeOf(context).toString(),
    ).format(date);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppTheme.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: AppTheme.spacingM),
            child: Text(l10n.dailyForecast, style: AppTheme.titleLarge),
          ),
          const SizedBox(height: AppTheme.spacingM),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
            padding: const EdgeInsets.all(AppTheme.spacingM),
            decoration: AppTheme.glassmorphicCard,
            child: Column(
              children: forecasts.map((forecast) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppTheme.spacingS,
                  ),
                  child: Row(
                    children: [
                      // Day Name
                      Expanded(
                        flex: 3,
                        child: Text(
                          _getDayName(forecast.date, context),
                          style: AppTheme.bodyLarge,
                        ),
                      ),
                      // Weather Icon
                      BoxedIcon(
                        _getWeatherIcon(forecast.mainCondition),
                        size: 28,
                        color: AppTheme.white,
                      ),
                      const SizedBox(width: AppTheme.spacingM),
                      // Humidity
                      Row(
                        children: [
                          Icon(
                            Icons.water_drop,
                            size: 14,
                            color: AppTheme.white.withOpacity(0.7),
                          ),
                          const SizedBox(width: 2),
                          SizedBox(
                            width: 30,
                            child: Text(
                              '${forecast.humidity}%',
                              style: AppTheme.bodySmall.copyWith(
                                color: AppTheme.white.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Temperature Range
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${forecast.maxTemp.round()}°',
                              style: AppTheme.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: AppTheme.spacingS),
                            Text(
                              '${forecast.minTemp.round()}°',
                              style: AppTheme.titleMedium.copyWith(
                                color: AppTheme.white.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
