import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/weather_model.dart';
import '../models/air_quality_model.dart';
import '../models/advanced_weather_model.dart';
import '../models/forecast_model.dart';
import '../widgets/hourly_forecast_widget.dart';
import '../widgets/weather_detail_card.dart';
import '../widgets/air_quality_card.dart';
import '../widgets/uv_index_card.dart';
import '../widgets/weather_alerts_widget.dart';
import '../widgets/weather_animations.dart';

class WeatherDetailScreen extends StatefulWidget {
  final Weather weather;
  final List<HourlyForecast> hourlyForecasts;
  final AirQuality? airQuality;
  final UVIndex? uvIndex;
  final List<WeatherAlert>? alerts;

  const WeatherDetailScreen({
    super.key,
    required this.weather,
    required this.hourlyForecasts,
    this.airQuality,
    this.uvIndex,
    this.alerts,
  });

  @override
  State<WeatherDetailScreen> createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen> {
  LinearGradient _getGradientForWeather(String? condition) {
    if (condition == null) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF4A90E2), Color(0xFF50C9C3)],
      );
    }

    switch (condition.toLowerCase()) {
      case 'clear':
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF2E5CFF), Color(0xFF47B5FF)],
        );
      case 'clouds':
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF6B7F9C), Color(0xFF99A8B9)],
        );
      case 'rain':
      case 'drizzle':
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF2C3E50), Color(0xFF4CA1AF)],
        );
      case 'thunderstorm':
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF141E30), Color(0xFF243B55)],
        );
      case 'snow':
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE6F3FF), Color(0xFFB3D9FF)],
        );
      default:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF4A90E2), Color(0xFF50C9C3)],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: _getGradientForWeather(widget.weather.mainCondition),
        ),
        child: Stack(
          children: [
            // Weather animations
            Positioned.fill(
              child: WeatherAnimations(
                weatherCondition: widget.weather.mainCondition,
              ),
            ),
            // Content
            SafeArea(
              child: Column(
                children: [
                  _buildAppBar(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildMainWeatherInfo(),
                          const SizedBox(height: 24),
                          if (widget.alerts != null &&
                              widget.alerts!.isNotEmpty) ...[
                            WeatherAlertsWidget(alerts: widget.alerts!),
                            const SizedBox(height: 24),
                          ],
                          const Text(
                            'Dự báo theo giờ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          HourlyForecastWidget(
                            forecasts: widget.hourlyForecasts,
                          ),
                          const SizedBox(height: 24),
                          if (widget.airQuality != null) ...[
                            AirQualityCard(airQuality: widget.airQuality!),
                            const SizedBox(height: 16),
                          ],
                          if (widget.uvIndex != null) ...[
                            UVIndexCard(uvIndex: widget.uvIndex!),
                            const SizedBox(height: 16),
                          ],
                          _buildWeatherDetails(),
                          const SizedBox(height: 24),
                          _buildSunInfo(),
                        ],
                      ),
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

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.weather.cityName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMainWeatherInfo() {
    return Center(
      child: Column(
        children: [
          Image.network(
            'https://openweathermap.org/img/wn/${widget.weather.icon}@4x.png',
            width: 150,
            height: 150,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.wb_sunny, color: Colors.white, size: 100);
            },
          ),
          Text(
            '${widget.weather.temperature.round()}°',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 72,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.weather.description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Cảm giác như ${widget.weather.feelsLike.round()}°',
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Chi tiết thời tiết',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: [
            WeatherDetailCard(
              icon: Icons.water_drop,
              title: 'Độ ẩm',
              value: '${widget.weather.humidity}%',
            ),
            WeatherDetailCard(
              icon: Icons.air,
              title: 'Tốc độ gió',
              value: '${widget.weather.windSpeed.toStringAsFixed(1)} m/s',
            ),
            WeatherDetailCard(
              icon: Icons.compress,
              title: 'Áp suất',
              value: '${widget.weather.pressure} hPa',
            ),
            WeatherDetailCard(
              icon: Icons.visibility,
              title: 'Tầm nhìn',
              value:
                  '${(widget.weather.visibility / 1000).toStringAsFixed(1)} km',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSunInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const Icon(
                Icons.wb_twilight,
                color: Colors.orangeAccent,
                size: 32,
              ),
              const SizedBox(height: 8),
              const Text(
                'Bình minh',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat('HH:mm').format(widget.weather.sunrise),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(height: 60, width: 1, color: Colors.white.withOpacity(0.3)),
          Column(
            children: [
              const Icon(
                Icons.nights_stay,
                color: Colors.deepPurpleAccent,
                size: 32,
              ),
              const SizedBox(height: 8),
              const Text(
                'Hoàng hôn',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat('HH:mm').format(widget.weather.sunset),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
