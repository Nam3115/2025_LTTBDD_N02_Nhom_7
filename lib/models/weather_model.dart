class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final String description;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final int visibility;
  final DateTime sunrise;
  final DateTime sunset;
  final String icon;
  final double latitude; // Thêm latitude
  final double longitude; // Thêm longitude

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.description,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.visibility,
    required this.sunrise,
    required this.sunset,
    required this.icon,
    required this.latitude,
    required this.longitude,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      feelsLike: json['main']['feels_like'].toDouble(),
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      pressure: json['main']['pressure'],
      visibility: json['visibility'],
      sunrise: DateTime.fromMillisecondsSinceEpoch(
        json['sys']['sunrise'] * 1000,
      ),
      sunset: DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000),
      icon: json['weather'][0]['icon'],
      latitude: json['coord']['lat'].toDouble(), // Thêm lat từ API
      longitude: json['coord']['lon'].toDouble(), // Thêm lon từ API
    );
  }
}
