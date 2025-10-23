import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import '../models/air_quality_model.dart';
import '../models/advanced_weather_model.dart';

class WeatherService {
  static const String BASE_URL = 'https://api.openweathermap.org/data/2.5';
  final String apiKey;
  static bool _isRequestingPermission =
      false; // Prevent multiple permission requests
  static LocationPermission? _cachedPermission; // Cache permission result

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    try {
      final response = await http
          .get(
            Uri.parse(
              '$BASE_URL/weather?q=$cityName&appid=$apiKey&units=metric',
            ),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 404) {
        throw Exception('Không tìm thấy thành phố "$cityName"');
      } else if (response.statusCode == 401) {
        throw Exception('API key không hợp lệ');
      } else {
        throw Exception('Lỗi tải dữ liệu thời tiết (${response.statusCode})');
      }
    } catch (e) {
      if (e.toString().contains('TimeoutException')) {
        throw Exception('Kết nối quá chậm, vui lòng thử lại');
      }
      rethrow;
    }
  }

  Future<Weather> getWeatherByCoordinates(double lat, double lon) async {
    try {
      final response = await http
          .get(
            Uri.parse(
              '$BASE_URL/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric',
            ),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        throw Exception('API key không hợp lệ');
      } else {
        throw Exception('Lỗi tải dữ liệu thời tiết (${response.statusCode})');
      }
    } catch (e) {
      if (e.toString().contains('TimeoutException')) {
        throw Exception('Kết nối quá chậm, vui lòng thử lại');
      }
      rethrow;
    }
  }

  Future<List<HourlyForecast>> getHourlyForecast(double lat, double lon) async {
    final response = await http.get(
      Uri.parse(
        '$BASE_URL/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> forecastList = data['list'];

      // Get next 8 hourly forecasts (24 hours)
      return forecastList
          .take(8)
          .map((item) => HourlyForecast.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load hourly forecast');
    }
  }

  Future<List<DailyForecast>> getDailyForecast(double lat, double lon) async {
    final response = await http.get(
      Uri.parse(
        '$BASE_URL/forecast/daily?lat=$lat&lon=$lon&cnt=7&appid=$apiKey&units=metric',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> forecastList = data['list'];

      return forecastList.map((item) => DailyForecast.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load daily forecast');
    }
  }

  Future<String> getCurrentCity() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }

    // Check for location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Convert coordinates to city name
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    String? city = placemarks[0].locality;
    return city ?? '';
  }

  Future<Position> getCurrentPosition() async {
    try {
      // Prevent multiple simultaneous permission requests
      if (_isRequestingPermission) {
        throw Exception('Đang xin quyền truy cập vị trí, vui lòng đợi...');
      }

      // If we already know permission was denied, don't retry immediately
      if (_cachedPermission == LocationPermission.denied ||
          _cachedPermission == LocationPermission.deniedForever) {
        if (_cachedPermission == LocationPermission.deniedForever) {
          throw Exception(
            'Quyền truy cập vị trí bị từ chối vĩnh viễn. Vui lòng cấp quyền trong cài đặt thiết bị.',
          );
        }
        throw Exception(
          'Quyền truy cập vị trí bị từ chối. Vui lòng cấp quyền trong cài đặt trình duyệt.',
        );
      }

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Dịch vụ vị trí chưa được bật. Vui lòng bật GPS.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      _cachedPermission = permission;

      if (permission == LocationPermission.denied) {
        _isRequestingPermission = true;
        try {
          permission = await Geolocator.requestPermission().timeout(
            const Duration(seconds: 30),
          );
          _cachedPermission = permission;
        } on TimeoutException {
          _cachedPermission = LocationPermission.denied;
          throw Exception(
            'Yêu cầu quyền truy cập vị trí hết thời gian. Vui lòng thử lại.',
          );
        } catch (e) {
          _cachedPermission = LocationPermission.denied;
          throw Exception('Lỗi khi yêu cầu quyền truy cập vị trí: $e');
        } finally {
          _isRequestingPermission = false;
        }

        if (permission == LocationPermission.denied) {
          throw Exception(
            'Quyền truy cập vị trí bị từ chối. Vui lòng cấp quyền trong cài đặt trình duyệt.',
          );
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
          'Quyền truy cập vị trí bị từ chối vĩnh viễn. Vui lòng cấp quyền trong cài đặt thiết bị.',
        );
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).timeout(const Duration(seconds: 10));

      return position;
    } catch (e) {
      if (e.toString().contains('TimeoutException')) {
        throw Exception('Không thể xác định vị trí. Vui lòng thử lại.');
      }
      rethrow;
    }
  }

  // Air Quality Index
  Future<AirQuality> getAirQuality(double lat, double lon) async {
    final response = await http.get(
      Uri.parse('$BASE_URL/air_pollution?lat=$lat&lon=$lon&appid=$apiKey'),
    );

    if (response.statusCode == 200) {
      return AirQuality.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load air quality data');
    }
  }

  // UV Index (from OneCall API - free tier)
  Future<UVIndex> getUVIndex(double lat, double lon) async {
    // Note: UV index is available in OneCall API 3.0
    final response = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=minutely,hourly,daily,alerts&appid=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UVIndex(
        value: data['current']['uvi'].toDouble(),
        dateTime: DateTime.fromMillisecondsSinceEpoch(
          data['current']['dt'] * 1000,
        ),
      );
    } else {
      throw Exception('Failed to load UV index');
    }
  }

  // Weather Alerts
  Future<List<WeatherAlert>> getWeatherAlerts(double lat, double lon) async {
    final response = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=minutely,hourly,daily,current&appid=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['alerts'] != null) {
        final List<dynamic> alertsList = data['alerts'];
        return alertsList.map((item) => WeatherAlert.fromJson(item)).toList();
      }
      return [];
    } else {
      throw Exception('Failed to load weather alerts');
    }
  }

  // Get comprehensive weather data (all in one)
  Future<Map<String, dynamic>> getComprehensiveWeather(
    double lat,
    double lon,
  ) async {
    try {
      final weather = await getWeatherByCoordinates(lat, lon);
      final hourlyForecast = await getHourlyForecast(lat, lon);
      final airQuality = await getAirQuality(lat, lon);

      UVIndex? uvIndex;
      List<WeatherAlert>? alerts;

      try {
        uvIndex = await getUVIndex(lat, lon);
      } catch (e) {
        // UV Index might not be available in free tier
        uvIndex = null;
      }

      try {
        alerts = await getWeatherAlerts(lat, lon);
      } catch (e) {
        alerts = [];
      }

      return {
        'weather': weather,
        'hourlyForecast': hourlyForecast,
        'airQuality': airQuality,
        'uvIndex': uvIndex,
        'alerts': alerts,
      };
    } catch (e) {
      throw Exception('Failed to load comprehensive weather data: $e');
    }
  }

  // Reset cached permission (call this when user wants to retry)
  static void resetPermissionCache() {
    _cachedPermission = null;
    _isRequestingPermission = false;
  }
}
