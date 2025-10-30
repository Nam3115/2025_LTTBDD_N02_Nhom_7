class AirQuality {
  final int aqi;
  final String category;
  final double co;
  final double no;
  final double no2;
  final double o3;
  final double so2;
  final double pm2_5;
  final double pm10;
  final double nh3;
  final DateTime dateTime;

  AirQuality({
    required this.aqi,
    required this.category,
    required this.co,
    required this.no,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm2_5,
    required this.pm10,
    required this.nh3,
    required this.dateTime,
  });

  factory AirQuality.fromJson(Map<String, dynamic> json) {
    final list = json['list'][0];
    final components = list['components'];
    final aqi = list['main']['aqi'];

    return AirQuality(
      aqi: aqi,
      category: _getAQICategory(aqi),
      co: components['co'].toDouble(),
      no: components['no'].toDouble(),
      no2: components['no2'].toDouble(),
      o3: components['o3'].toDouble(),
      so2: components['so2'].toDouble(),
      pm2_5: components['pm2_5'].toDouble(),
      pm10: components['pm10'].toDouble(),
      nh3: components['nh3'].toDouble(),
      dateTime: DateTime.fromMillisecondsSinceEpoch(list['dt'] * 1000),
    );
  }

  static String _getAQICategory(int aqi) {
    switch (aqi) {
      case 1:
        return 'Tốt';
      case 2:
        return 'Trung bình';
      case 3:
        return 'Kém';
      case 4:
        return 'Xấu';
      case 5:
        return 'Rất xấu';
      default:
        return 'Không xác định';
    }
  }

  String getHealthAdvice() {
    switch (aqi) {
      case 1:
        return 'Chất lượng không khí tốt, phù hợp cho hoạt động ngoài trời';
      case 2:
        return 'Chất lượng không khí chấp nhận được';
      case 3:
        return 'Nhóm nhạy cảm nên hạn chế hoạt động ngoài trời kéo dài';
      case 4:
        return 'Mọi người nên hạn chế hoạt động ngoài trời';
      case 5:
        return 'Cảnh báo sức khỏe! Hạn chế ra ngoài';
      default:
        return '';
    }
  }

  int getAQIColor() {
    switch (aqi) {
      case 1:
        return 0xFF00E400; // Green
      case 2:
        return 0xFFFFFF00; // Yellow
      case 3:
        return 0xFFFF7E00; // Orange
      case 4:
        return 0xFFFF0000; // Red
      case 5:
        return 0xFF8F3F97; // Purple
      default:
        return 0xFF808080; // Gray
    }
  }
}
