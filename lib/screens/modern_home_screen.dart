import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import '../models/air_quality_model.dart';
import '../models/advanced_weather_model.dart';
import '../services/weather_service.dart';
import '../widgets/modern_weather_card.dart';
import '../widgets/modern_forecast_widget.dart';
import '../utils/app_theme.dart';
import '../utils/constants.dart';
import '../utils/unit_converter.dart';
import 'search_screen.dart';
import 'new_settings_screen.dart';

class ModernHomeScreen extends StatefulWidget {
  const ModernHomeScreen({super.key});

  @override
  State<ModernHomeScreen> createState() => _ModernHomeScreenState();
}

class _ModernHomeScreenState extends State<ModernHomeScreen>
    with TickerProviderStateMixin {
  final _weatherService = WeatherService(Constants.OPENWEATHER_API_KEY);
  Weather? _weather;
  List<HourlyForecast> _hourlyForecasts = [];
  AirQuality? _airQuality;
  UVIndex? _uvIndex;
  List<WeatherAlert>? _alerts;
  bool _isLoading = true;
  String _errorMessage = '';
  bool _isFetching = false; // Prevent multiple simultaneous fetches
  DateTime? _lastFetchTime; // Debounce fetches
  String _detailedAddress = ''; // Store detailed address

  // Unit settings
  String _temperatureUnit = 'metric'; // 'metric' or 'imperial'
  String _windSpeedUnit = 'ms'; // 'ms', 'mph', or 'kmh'

  // Last saved location
  String? _lastSavedCity; // Lưu thành phố cuối cùng
  double? _lastSavedLat; // Lưu latitude cuối cùng
  double? _lastSavedLon; // Lưu longitude cuối cùng

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _loadSettings();
    _fetchWeather();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _temperatureUnit = prefs.getString('temperatureUnit') ?? 'metric';
      _windSpeedUnit = prefs.getString('windSpeedUnit') ?? 'ms';

      // Load last saved location
      _lastSavedCity = prefs.getString('lastCity');
      _lastSavedLat = prefs.getDouble('lastLat');
      _lastSavedLon = prefs.getDouble('lastLon');
    });
  }

  Future<void> _saveLastLocation(String city, double lat, double lon) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastCity', city);
    await prefs.setDouble('lastLat', lat);
    await prefs.setDouble('lastLon', lon);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _fetchWeather() async {
    // Prevent multiple simultaneous fetch calls
    if (_isFetching) {
      print('Already fetching weather, skipping...');
      return;
    }

    // Debounce: Don't fetch if we just fetched less than 2 seconds ago
    if (_lastFetchTime != null &&
        DateTime.now().difference(_lastFetchTime!) <
            const Duration(seconds: 2)) {
      print('Fetch too soon, skipping...');
      return;
    }

    _isFetching = true;
    _lastFetchTime = DateTime.now();

    if (mounted) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });
    }

    try {
      double lat, lon;

      // Kiểm tra xem có location đã lưu không
      if (_lastSavedLat != null && _lastSavedLon != null) {
        print(
          'Using saved location: $_lastSavedCity ($_lastSavedLat, $_lastSavedLon)',
        );
        lat = _lastSavedLat!;
        lon = _lastSavedLon!;
      } else {
        // Không có location đã lưu, dùng GPS
        print('No saved location, using GPS...');
        final position = await _weatherService.getCurrentPosition();
        lat = position.latitude;
        lon = position.longitude;
      }

      // Get detailed address
      final detailedAddress = await _weatherService.getDetailedAddress(
        lat,
        lon,
      );

      // Get comprehensive weather data
      final comprehensiveData = await _weatherService.getComprehensiveWeather(
        lat,
        lon,
      );

      // Lưu location này để dùng cho lần sau
      await _saveLastLocation(detailedAddress, lat, lon);

      if (mounted) {
        setState(() {
          _weather = comprehensiveData['weather'];
          _hourlyForecasts = comprehensiveData['hourlyForecast'];
          _airQuality = comprehensiveData['airQuality'];
          _uvIndex = comprehensiveData['uvIndex'];
          _alerts = comprehensiveData['alerts'];
          _detailedAddress = detailedAddress;
          _lastSavedCity = detailedAddress;
          _lastSavedLat = lat;
          _lastSavedLon = lon;
          _isLoading = false;
        });

        _fadeController.forward();
      }
    } catch (e) {
      print('Error fetching weather: $e');
      if (mounted) {
        setState(() {
          _errorMessage = _getErrorMessage(e);
          _isLoading = false;
        });
      }
    } finally {
      if (mounted) {
        _isFetching = false;
      }
    }
  }

  String _getErrorMessage(dynamic error) {
    if (error.toString().contains('Permission')) {
      return 'Cần cấp quyền truy cập vị trí';
    } else if (error.toString().contains('Location')) {
      return 'Không thể xác định vị trí của bạn';
    } else if (error.toString().contains('Network') ||
        error.toString().contains('SocketException')) {
      return 'Không có kết nối internet';
    } else if (error.toString().contains('TimeoutException')) {
      return 'Kết nối quá chậm, vui lòng thử lại';
    } else if (error.toString().contains('API')) {
      return 'Lỗi API, vui lòng kiểm tra API key';
    } else {
      return 'Không thể tải thời tiết. Vui lòng thử lại sau.';
    }
  }

  Future<void> _searchCity() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchScreen()),
    );

    if (result != null && result is String) {
      if (_isFetching) {
        print('Already fetching, skipping search...');
        return;
      }

      _isFetching = true;
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      try {
        final weather = await _weatherService.getWeather(result);

        // Lấy detailed address từ coordinates của weather
        final detailedAddress = await _weatherService.getDetailedAddress(
          weather.latitude,
          weather.longitude,
        );

        // Lưu location để dùng cho lần sau
        await _saveLastLocation(
          detailedAddress,
          weather.latitude,
          weather.longitude,
        );

        if (mounted) {
          setState(() {
            _weather = weather;
            _detailedAddress = detailedAddress;
            _lastSavedCity = detailedAddress;
            _lastSavedLat = weather.latitude;
            _lastSavedLon = weather.longitude;
            _isLoading = false;
          });
          _fadeController.forward(from: 0);
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _errorMessage = _getErrorMessage(e);
            _isLoading = false;
          });
        }
        print('Error searching city: $e');
      } finally {
        _isFetching = false;
      }
    }
  }

  Future<void> _useCurrentLocation() async {
    // Xóa saved location và dùng GPS
    if (_isFetching) {
      print('Already fetching, skipping...');
      return;
    }

    setState(() {
      _lastSavedCity = null;
      _lastSavedLat = null;
      _lastSavedLon = null;
    });

    // Clear saved location từ SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('lastCity');
    await prefs.remove('lastLat');
    await prefs.remove('lastLon');

    // Fetch weather từ GPS
    await _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    // Sử dụng gradient động dựa trên thời tiết và thời gian thực
    final gradient = AppTheme.getDynamicGradient(
      weatherCondition: _weather?.mainCondition,
      dateTime: DateTime.now(),
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: gradient),
        child: SafeArea(
          child: _isLoading
              ? _buildLoadingState()
              : _errorMessage.isNotEmpty
              ? _buildErrorState()
              : _buildSuccessState(),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingXL),
            decoration: BoxDecoration(
              color: AppTheme.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const CircularProgressIndicator(
              color: AppTheme.white,
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: AppTheme.spacingL),
          Text(
            'Đang tải thời tiết...',
            style: AppTheme.titleMedium.copyWith(
              color: AppTheme.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    IconData errorIcon;
    String errorTitle;
    String errorSubtitle;

    if (_errorMessage.contains('vị trí')) {
      errorIcon = Icons.location_off;
      errorTitle = 'Lỗi Vị Trí';
      errorSubtitle = _errorMessage;
    } else if (_errorMessage.contains('internet') ||
        _errorMessage.contains('Kết nối')) {
      errorIcon = Icons.wifi_off;
      errorTitle = 'Không Có Kết Nối';
      errorSubtitle = _errorMessage;
    } else if (_errorMessage.contains('API')) {
      errorIcon = Icons.key_off;
      errorTitle = 'Lỗi API';
      errorSubtitle = _errorMessage;
    } else {
      errorIcon = Icons.cloud_off;
      errorTitle = 'Không Thể Tải Thời Tiết';
      errorSubtitle = _errorMessage;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingXL),
              decoration: BoxDecoration(
                color: AppTheme.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(errorIcon, color: AppTheme.white, size: 80),
            ),
            const SizedBox(height: AppTheme.spacingL),
            Text(
              errorTitle,
              style: AppTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.spacingS),
            Text(
              errorSubtitle,
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.white.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.spacingXL),
            ElevatedButton.icon(
              onPressed: () {
                // Reset permission cache before retrying
                WeatherService.resetPermissionCache();
                _fetchWeather();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Thử lại'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.white.withOpacity(0.3),
                foregroundColor: AppTheme.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingXL,
                  vertical: AppTheme.spacingM,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusCircle),
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingM),
            TextButton.icon(
              onPressed: _searchCity,
              icon: const Icon(Icons.search),
              label: const Text('Tìm thành phố'),
              style: TextButton.styleFrom(foregroundColor: AppTheme.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessState() {
    return RefreshIndicator(
      onRefresh: _fetchWeather,
      color: AppTheme.white,
      backgroundColor: AppTheme.primaryBlue,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // App Bar
          SliverToBoxAdapter(child: _buildAppBar()),
          // Main Content
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingM,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Giữ start cho các phần khác
                  children: [
                    const SizedBox(height: AppTheme.spacingL),
                    // Hero Weather Card - Căn giữa riêng
                    Center(child: _buildHeroSection()),
                    const SizedBox(height: AppTheme.spacingXL),
                    // Weather Alerts (if any)
                    if (_alerts != null && _alerts!.isNotEmpty) ...[
                      _buildAlertsSection(),
                      const SizedBox(height: AppTheme.spacingL),
                    ],
                    // Info Chips Row
                    _buildInfoChipsRow(),
                    const SizedBox(height: AppTheme.spacingXL),
                    // Hourly Forecast
                    if (_hourlyForecasts.isNotEmpty)
                      ModernHourlyForecast(forecasts: _hourlyForecasts),
                    const SizedBox(height: AppTheme.spacingL),
                    // Weather Details Grid
                    _buildDetailsGrid(),
                    const SizedBox(height: AppTheme.spacingXL),
                    // Additional Info
                    _buildAdditionalInfo(),
                    const SizedBox(height: AppTheme.spacingXXL),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Location Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppTheme.white.withOpacity(0.9),
                      size: 24,
                    ),
                    const SizedBox(width: AppTheme.spacingXS),
                    Expanded(
                      child: Text(
                        _detailedAddress.isNotEmpty
                            ? _detailedAddress
                            : (_weather?.cityName ?? 'Unknown'),
                        style: AppTheme.headlineSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('EEEE, d MMMM', 'vi_VN').format(DateTime.now()),
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          // Action Buttons
          Row(
            children: [
              // My Location Button - GPS
              IconButton(
                onPressed: _useCurrentLocation,
                icon: const Icon(Icons.my_location),
                color: AppTheme.white,
                iconSize: 28,
                style: IconButton.styleFrom(
                  backgroundColor: AppTheme.white.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusM),
                  ),
                ),
              ),
              const SizedBox(width: AppTheme.spacingS),
              IconButton(
                onPressed: _searchCity,
                icon: const Icon(Icons.search),
                color: AppTheme.white,
                iconSize: 28,
                style: IconButton.styleFrom(
                  backgroundColor: AppTheme.white.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusM),
                  ),
                ),
              ),
              const SizedBox(width: AppTheme.spacingS),
              IconButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewSettingsScreen(),
                    ),
                  );
                  // Reload settings and rebuild when returning from settings
                  await _loadSettings();
                  setState(() {});
                },
                icon: const Icon(Icons.settings_outlined),
                color: AppTheme.white,
                iconSize: 28,
                style: IconButton.styleFrom(
                  backgroundColor: AppTheme.white.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusM),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    if (_weather == null) return const SizedBox.shrink();

    final temp = UnitConverter.formatTemperature(
      _weather!.temperature,
      _temperatureUnit,
    );
    final tempUnit = UnitConverter.getTemperatureUnit(_temperatureUnit);
    final feelsLike = UnitConverter.formatTemperature(
      _weather!.feelsLike,
      _temperatureUnit,
    );
    final high = UnitConverter.formatTemperature(
      _weather!.temperature + 3,
      _temperatureUnit,
    );
    final low = UnitConverter.formatTemperature(
      _weather!.temperature - 5,
      _temperatureUnit,
    );

    return HeroWeatherCard(
      temperature: '$temp$tempUnit',
      condition: _weather!.mainCondition,
      feelsLike: '$feelsLike$tempUnit',
      high: '$high$tempUnit',
      low: '$low$tempUnit',
      weatherIcon: AppTheme.getWeatherIcon(_weather!.mainCondition),
    );
  }

  Widget _buildInfoChipsRow() {
    if (_weather == null) return const SizedBox.shrink();

    final windSpeed = UnitConverter.formatWindSpeed(
      _weather!.windSpeed,
      _windSpeedUnit,
    );
    final windUnit = UnitConverter.getWindSpeedUnit(_windSpeedUnit);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          InfoChipCard(
            label: 'Độ ẩm',
            value: '${_weather!.humidity}%',
            icon: Icons.water_drop,
          ),
          const SizedBox(width: AppTheme.spacingS),
          InfoChipCard(
            label: 'Gió',
            value: '$windSpeed $windUnit',
            icon: Icons.air,
          ),
          const SizedBox(width: AppTheme.spacingS),
          if (_airQuality != null)
            InfoChipCard(
              label: 'AQI',
              value: _airQuality!.aqi.toString(),
              icon: Icons.eco,
              backgroundColor: Color(
                _airQuality!.getAQIColor(),
              ).withOpacity(0.5),
            ),
          const SizedBox(width: AppTheme.spacingS),
          if (_uvIndex != null)
            InfoChipCard(
              label: 'UV',
              value: _uvIndex!.value.round().toString(),
              icon: Icons.wb_sunny_outlined,
              backgroundColor: Color(_uvIndex!.color).withOpacity(0.5),
            ),
        ],
      ),
    );
  }

  Widget _buildAlertsSection() {
    if (_alerts == null || _alerts!.isEmpty) return const SizedBox.shrink();

    final alert = _alerts!.first;
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.3),
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        border: Border.all(color: Colors.orange.withOpacity(0.5), width: 2),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange[100],
            size: 32,
          ),
          const SizedBox(width: AppTheme.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert.event,
                  style: AppTheme.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  alert.description,
                  style: AppTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsGrid() {
    if (_weather == null) return const SizedBox.shrink();

    final feelsLike = UnitConverter.formatTemperature(
      _weather!.feelsLike,
      _temperatureUnit,
    );
    final tempUnit = UnitConverter.getTemperatureUnit(_temperatureUnit);
    final windSpeed = UnitConverter.formatWindSpeed(
      _weather!.windSpeed,
      _windSpeedUnit,
    );
    final windUnit = UnitConverter.getWindSpeedUnit(_windSpeedUnit);
    final visibility = UnitConverter.formatVisibility(
      _weather!.visibility.toDouble(),
      _temperatureUnit,
    );
    final visibilityUnit = UnitConverter.getVisibilityUnit(_temperatureUnit);

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppTheme.spacingM,
      crossAxisSpacing: AppTheme.spacingM,
      childAspectRatio: 1.8, // Tăng tỷ lệ để cards thấp hơn, tránh overflow
      children: [
        ModernWeatherCard(
          title: 'Cảm giác như',
          value: '$feelsLike$tempUnit',
          icon: Icons.thermostat,
          iconColor: Colors.orange[300],
        ),
        ModernWeatherCard(
          title: 'Tốc độ gió',
          value: windSpeed,
          subtitle: windUnit,
          icon: Icons.air,
          iconColor: Colors.blue[300],
        ),
        ModernWeatherCard(
          title: 'Áp suất',
          value: '${_weather!.pressure}',
          subtitle: 'hPa',
          icon: Icons.speed,
          iconColor: Colors.purple[300],
        ),
        ModernWeatherCard(
          title: 'Tầm nhìn',
          value: visibility,
          subtitle: visibilityUnit,
          icon: Icons.visibility,
          iconColor: Colors.green[300],
        ),
      ],
    );
  }

  Widget _buildAdditionalInfo() {
    if (_weather == null) return const SizedBox.shrink();

    final sunrise = DateFormat('HH:mm').format(_weather!.sunrise);
    final sunset = DateFormat('HH:mm').format(_weather!.sunset);

    return Column(
      children: [
        CompactWeatherCard(
          icon: Icons.wb_sunny_outlined,
          label: 'Mặt trời mọc',
          value: sunrise,
          iconColor: Colors.amber[300],
        ),
        const SizedBox(height: AppTheme.spacingS),
        CompactWeatherCard(
          icon: Icons.nightlight_round,
          label: 'Mặt trời lặn',
          value: sunset,
          iconColor: Colors.deepOrange[300],
        ),
        const SizedBox(height: AppTheme.spacingS),
        CompactWeatherCard(
          icon: Icons.water_drop_outlined,
          label: 'Độ ẩm',
          value: '${_weather!.humidity}%',
          iconColor: Colors.lightBlue[300],
        ),
      ],
    );
  }
}
