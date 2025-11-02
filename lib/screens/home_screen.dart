import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import '../models/air_quality_model.dart';
import '../models/advanced_weather_model.dart';
import '../services/weather_service.dart';
import '../widgets/hourly_forecast_widget.dart';
import '../widgets/weather_detail_card.dart';
import '../utils/constants.dart';
import 'search_screen.dart';
import 'weather_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _weatherService = WeatherService(Constants.OPENWEATHER_API_KEY);
  Weather? _weather;
  List<HourlyForecast> _hourlyForecasts = [];
  AirQuality? _airQuality;
  UVIndex? _uvIndex;
  List<WeatherAlert>? _alerts;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final position = await _weatherService.getCurrentPosition();

      // Get comprehensive weather data
      final comprehensiveData = await _weatherService.getComprehensiveWeather(
        position.latitude,
        position.longitude,
      );

      setState(() {
        _weather = comprehensiveData['weather'];
        _hourlyForecasts = comprehensiveData['hourlyForecast'];
        _airQuality = comprehensiveData['airQuality'];
        _uvIndex = comprehensiveData['uvIndex'];
        _alerts = comprehensiveData['alerts'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _searchCity() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchScreen()),
    );

    if (result != null && result is String) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      try {
        final weather = await _weatherService.getWeather(result);
        // For simplicity, we'll use approximate coordinates
        // In production, you'd want to geocode the city name
        setState(() {
          _weather = weather;
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: _getGradientForWeather(_weather?.mainCondition),
        ),
        child: SafeArea(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : _errorMessage.isNotEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.white,
                        size: 64,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${l10n.error}: $_errorMessage',
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _fetchWeather,
                        child: Text(l10n.retry),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _fetchWeather,
                  color: Colors.white,
                  backgroundColor: Colors.blue,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(l10n),
                        const SizedBox(height: 32),
                        _buildCurrentWeather(l10n),
                        const SizedBox(height: 32),
                        if (_hourlyForecasts.isNotEmpty) ...[
                          Text(
                            l10n.hourlyForecast,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          HourlyForecastWidget(forecasts: _hourlyForecasts),
                        ],
                        const SizedBox(height: 24),
                        _buildWeatherDetails(l10n),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.white, size: 20),
                const SizedBox(width: 4),
                Text(
                  _weather?.cityName ?? l10n.myLocation,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              DateFormat(
                'EEEE, d MMMM yyyy',
                Localizations.localeOf(context).toString(),
              ).format(DateTime.now()),
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.info_outline,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {
                if (_weather != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WeatherDetailScreen(
                        weather: _weather!,
                        hourlyForecasts: _hourlyForecasts,
                        airQuality: _airQuality,
                        uvIndex: _uvIndex,
                        alerts: _alerts,
                      ),
                    ),
                  );
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white, size: 28),
              onPressed: _searchCity,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCurrentWeather(AppLocalizations l10n) {
    if (_weather == null) return const SizedBox();

    return Center(
      child: Column(
        children: [
          Image.network(
            'https://openweathermap.org/img/wn/${_weather!.icon}@4x.png',
            width: 200,
            height: 200,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.wb_sunny, color: Colors.white, size: 120);
            },
          ),
          Text(
            '${_weather!.temperature.round()}°',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 80,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            // Use translation keys for weather conditions (map in Constants or use l10n)
            // Fallback to the raw condition if no translation exists
            (AppLocalizations.of(
                  context,
                )?.translate(_weather!.mainCondition.toLowerCase()) ??
                _weather!.mainCondition),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _weather!.description,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.arrow_upward, color: Colors.white70, size: 16),
              Text(
                ' ${_weather!.feelsLike.round()}°',
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(width: 24),
              const Icon(Icons.thermostat, color: Colors.white70, size: 16),
              Text(
                '${l10n.feelsLike} ${_weather!.feelsLike.round()}°',
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetails(AppLocalizations l10n) {
    if (_weather == null) return const SizedBox();

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        WeatherDetailCard(
          icon: Icons.water_drop,
          title: l10n.humidity,
          value: '${_weather!.humidity}%',
        ),
        WeatherDetailCard(
          icon: Icons.air,
          title: l10n.windSpeed,
          value:
              '${_weather!.windSpeed.toStringAsFixed(1)} ${l10n.getWindSpeedUnit ?? 'm/s'}',
        ),
        WeatherDetailCard(
          icon: Icons.compress,
          title: l10n.pressure,
          value: '${_weather!.pressure} ${l10n.hectopascal}',
        ),
        WeatherDetailCard(
          icon: Icons.visibility,
          title: l10n.visibility,
          value:
              '${(_weather!.visibility / 1000).toStringAsFixed(1)} ${l10n.kilometer}',
        ),
        WeatherDetailCard(
          icon: Icons.wb_twilight,
          title: l10n.sunrise,
          value: DateFormat(
            'HH:mm',
            Localizations.localeOf(context).toString(),
          ).format(_weather!.sunrise),
        ),
        WeatherDetailCard(
          icon: Icons.nights_stay,
          title: l10n.sunset,
          value: DateFormat(
            'HH:mm',
            Localizations.localeOf(context).toString(),
          ).format(_weather!.sunset),
        ),
      ],
    );
  }
}
