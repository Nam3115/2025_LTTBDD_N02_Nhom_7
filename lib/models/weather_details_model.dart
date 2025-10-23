/// Weather Details Model - Extended weather information
/// Inspired by MSN Weather detailed view
class WeatherDetails {
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final int pressure;
  final double windSpeed;
  final int windDeg;
  final int visibility; // in meters
  final int cloudiness;
  final double? precipitationProb; // 0-1 (0-100%)
  final double? precipitationVolume; // mm in last 3h

  WeatherDetails({
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.windDeg,
    required this.visibility,
    required this.cloudiness,
    this.precipitationProb,
    this.precipitationVolume,
  });

  factory WeatherDetails.fromJson(Map<String, dynamic> json) {
    return WeatherDetails(
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      tempMin: (json['main']['temp_min'] as num).toDouble(),
      tempMax: (json['main']['temp_max'] as num).toDouble(),
      humidity: json['main']['humidity'] as int,
      pressure: json['main']['pressure'] as int,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      windDeg: json['wind']['deg'] as int,
      visibility: json['visibility'] as int? ?? 10000,
      cloudiness: json['clouds']['all'] as int,
      precipitationProb: json['pop'] != null
          ? (json['pop'] as num).toDouble()
          : null,
      precipitationVolume: json['rain']?['3h'] != null
          ? (json['rain']['3h'] as num).toDouble()
          : json['snow']?['3h'] != null
          ? (json['snow']['3h'] as num).toDouble()
          : null,
    );
  }

  /// Get wind direction as Vietnamese text
  String getWindDirection() {
    if (windDeg >= 337.5 || windDeg < 22.5) return 'Bắc';
    if (windDeg >= 22.5 && windDeg < 67.5) return 'Đông Bắc';
    if (windDeg >= 67.5 && windDeg < 112.5) return 'Đông';
    if (windDeg >= 112.5 && windDeg < 157.5) return 'Đông Nam';
    if (windDeg >= 157.5 && windDeg < 202.5) return 'Nam';
    if (windDeg >= 202.5 && windDeg < 247.5) return 'Tây Nam';
    if (windDeg >= 247.5 && windDeg < 292.5) return 'Tây';
    return 'Tây Bắc';
  }

  /// Get wind direction as English code (for icons)
  String getWindDirectionCode() {
    if (windDeg >= 337.5 || windDeg < 22.5) return 'N';
    if (windDeg >= 22.5 && windDeg < 67.5) return 'NE';
    if (windDeg >= 67.5 && windDeg < 112.5) return 'E';
    if (windDeg >= 112.5 && windDeg < 157.5) return 'SE';
    if (windDeg >= 157.5 && windDeg < 202.5) return 'S';
    if (windDeg >= 202.5 && windDeg < 247.5) return 'SW';
    if (windDeg >= 247.5 && windDeg < 292.5) return 'W';
    return 'NW';
  }

  /// Get visibility in km with description
  String getVisibilityDescription() {
    final km = visibility / 1000;
    if (km >= 10) return 'Rất tốt';
    if (km >= 5) return 'Tốt';
    if (km >= 2) return 'Trung bình';
    if (km >= 1) return 'Kém';
    return 'Rất kém';
  }

  /// Get humidity level description
  String getHumidityDescription() {
    if (humidity >= 80) return 'Rất ẩm';
    if (humidity >= 60) return 'Ẩm';
    if (humidity >= 40) return 'Bình thường';
    if (humidity >= 20) return 'Khô';
    return 'Rất khô';
  }

  /// Get pressure description
  String getPressureDescription() {
    if (pressure >= 1020) return 'Cao';
    if (pressure >= 1010) return 'Bình thường';
    return 'Thấp';
  }

  /// Convert wind speed from m/s to km/h
  double get windSpeedKmh => windSpeed * 3.6;

  /// Get Beaufort scale description (Vietnamese)
  String getWindSpeedDescription() {
    if (windSpeed < 0.5) return 'Lặng gió';
    if (windSpeed < 1.6) return 'Gió nhẹ';
    if (windSpeed < 3.4) return 'Gió nhẹ';
    if (windSpeed < 5.5) return 'Gió nhẹ';
    if (windSpeed < 8.0) return 'Gió vừa';
    if (windSpeed < 10.8) return 'Gió vừa';
    if (windSpeed < 13.9) return 'Gió mạnh';
    if (windSpeed < 17.2) return 'Gió mạnh';
    if (windSpeed < 20.8) return 'Gió rất mạnh';
    if (windSpeed < 24.5) return 'Gió bão';
    if (windSpeed < 28.5) return 'Bão';
    if (windSpeed < 32.7) return 'Bão mạnh';
    return 'Bão rất mạnh';
  }

  /// Get feels like description compared to actual temp
  String getFeelsLikeDescription(double actualTemp) {
    final diff = feelsLike - actualTemp;
    if (diff > 3) return 'Nóng hơn nhiều';
    if (diff > 1) return 'Nóng hơn';
    if (diff < -3) return 'Lạnh hơn nhiều';
    if (diff < -1) return 'Lạnh hơn';
    return 'Tương đương';
  }
}
