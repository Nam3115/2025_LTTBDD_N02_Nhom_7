class Constants {
  // Replace with your OpenWeatherMap API key
  // Get your free API key from: https://openweathermap.org/api
  static const String OPENWEATHER_API_KEY = '839dcaa0197bf9c3157a4d39677a6413';

  // Weather condition mappings
  static const Map<String, String> weatherConditions = {
    'Clear': 'Trời quang',
    'Clouds': 'Nhiều mây',
    'Rain': 'Mưa',
    'Drizzle': 'Mưa phùn',
    'Thunderstorm': 'Dông',
    'Snow': 'Tuyết',
    'Mist': 'Sương mù',
    'Smoke': 'Khói',
    'Haze': 'Sương mù nhẹ',
    'Dust': 'Bụi',
    'Fog': 'Sương mù dày',
    'Sand': 'Cát bụi',
    'Ash': 'Tro núi lửa',
    'Squall': 'Giông',
    'Tornado': 'Lốc xoáy',
  };

  static String getWeatherConditionInVietnamese(String condition) {
    return weatherConditions[condition] ?? condition;
  }

  static String getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return '☀️';
      case 'clouds':
        return '☁️';
      case 'rain':
        return '🌧️';
      case 'drizzle':
        return '🌦️';
      case 'thunderstorm':
        return '⛈️';
      case 'snow':
        return '❄️';
      case 'mist':
      case 'fog':
        return '🌫️';
      default:
        return '🌤️';
    }
  }

  /// Lấy emoji theo thời gian trong ngày
  static String getTimeOfDayEmoji(int hour) {
    if (hour >= 5 && hour < 7) return '🌅'; // Bình minh
    if (hour >= 7 && hour < 11) return '☀️'; // Buổi sáng
    if (hour >= 11 && hour < 15) return '🌞'; // Ban trưa
    if (hour >= 15 && hour < 18) return '🌇'; // Chiều tà
    if (hour >= 18 && hour < 19.5) return '🌆'; // Hoàng hôn
    if (hour >= 19.5 && hour < 21) return '🌃'; // Chạng vạng
    return '🌙'; // Ban đêm
  }
}
