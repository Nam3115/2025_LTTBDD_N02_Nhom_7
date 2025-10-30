class HourlyForecast {
  final DateTime time;
  final double temperature;
  final String mainCondition;
  final String icon;
  final int humidity;
  final double windSpeed;

  HourlyForecast({
    required this.time,
    required this.temperature,
    required this.mainCondition,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
    );
  }
}

class DailyForecast {
  final DateTime date;
  final double minTemp;
  final double maxTemp;
  final String mainCondition;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;

  DailyForecast({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.mainCondition,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      minTemp: json['temp']['min'].toDouble(),
      maxTemp: json['temp']['max'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      humidity: json['humidity'],
      windSpeed: json['wind_speed'].toDouble(),
    );
  }
}
