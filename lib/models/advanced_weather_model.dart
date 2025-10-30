class UVIndex {
  final double value;
  final DateTime dateTime;

  UVIndex({required this.value, required this.dateTime});

  String get category {
    if (value <= 2) return 'Thấp';
    if (value <= 5) return 'Trung bình';
    if (value <= 7) return 'Cao';
    if (value <= 10) return 'Rất cao';
    return 'Nguy hiểm';
  }

  String get advice {
    if (value <= 2) {
      return 'Không cần bảo vệ. An toàn khi ở ngoài trời';
    } else if (value <= 5) {
      return 'Cần bảo vệ nhẹ. Đeo kính râm khi trời nắng';
    } else if (value <= 7) {
      return 'Cần bảo vệ. Đội mũ, đeo kính, thoa kem chống nắng';
    } else if (value <= 10) {
      return 'Cần bảo vệ cao. Tránh ra ngoài vào giữa trưa';
    } else {
      return 'Cảnh báo! Tránh ra ngoài từ 10h-16h';
    }
  }

  int get color {
    if (value <= 2) return 0xFF00E400; // Green
    if (value <= 5) return 0xFFFFFF00; // Yellow
    if (value <= 7) return 0xFFFF7E00; // Orange
    if (value <= 10) return 0xFFFF0000; // Red
    return 0xFF8F3F97; // Purple
  }
}

class WeatherAlert {
  final String event;
  final String description;
  final DateTime start;
  final DateTime end;
  final String severity;

  WeatherAlert({
    required this.event,
    required this.description,
    required this.start,
    required this.end,
    required this.severity,
  });

  factory WeatherAlert.fromJson(Map<String, dynamic> json) {
    return WeatherAlert(
      event: json['event'] ?? '',
      description: json['description'] ?? '',
      start: DateTime.fromMillisecondsSinceEpoch(json['start'] * 1000),
      end: DateTime.fromMillisecondsSinceEpoch(json['end'] * 1000),
      severity: json['severity'] ?? 'minor',
    );
  }

  int get severityColor {
    switch (severity.toLowerCase()) {
      case 'extreme':
        return 0xFF8F3F97; // Purple
      case 'severe':
        return 0xFFFF0000; // Red
      case 'moderate':
        return 0xFFFF7E00; // Orange
      default:
        return 0xFFFFFF00; // Yellow
    }
  }

  String get severityText {
    switch (severity.toLowerCase()) {
      case 'extreme':
        return 'Cực kỳ nguy hiểm';
      case 'severe':
        return 'Nguy hiểm';
      case 'moderate':
        return 'Cảnh báo';
      default:
        return 'Thông báo';
    }
  }
}
