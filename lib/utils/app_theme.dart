import 'package:flutter/material.dart';

class AppTheme {
  // Modern Color Palette
  static const Color primaryBlue = Color(0xFF3E7BFF);
  static const Color secondaryBlue = Color(0xFF47BFFF);
  static const Color darkBlue = Color(0xFF1E3A8A);
  static const Color lightBlue = Color(0xFF7DD3FC);
  static const Color blue = Color(0xFF3B82F6);

  static const Color accentPurple = Color(0xFF8B5CF6);
  static const Color lightPurple = Color(0xFFA78BFA);
  static const Color accentPink = Color(0xFFEC4899);
  static const Color accentOrange = Color(0xFFF59E0B);
  static const Color orange = Color(0xFFF97316);

  // Neutral Colors
  static const Color darkGray = Color(0xFF1F2937);
  static const Color mediumGray = Color(0xFF6B7280);
  static const Color lightGray = Color(0xFFF3F4F6);
  static const Color grey = Color(0xFF9CA3AF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Light Mode Colors
  static const Color lightBackground = Color(0xFFF5F7FA);
  static const Color lightCardBackground = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF1F2937);
  static const Color lightTextSecondary = Color(0xFF6B7280);
  static const Color lightBorder = Color(0xFFE5E7EB);

  // Dark Mode Colors
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkCardBackground = Color(0xFF1E293B);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkBorder = Color(0xFF334155);

  // Weather-based Gradients with Time of Day Support

  // ===== CLEAR SKY GRADIENTS =====
  // Sáng sớm (5:00 - 7:00) - Bình minh
  static const LinearGradient clearSkyDawnGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF1E3A8A), // Xanh đậm
      Color(0xFF6366F1), // Xanh nhạt
      Color(0xFFFBBF24), // Vàng cam
      Color(0xFFFCA5A5), // Hồng nhạt
    ],
    stops: [0.0, 0.3, 0.7, 1.0],
  );

  // Buổi sáng (7:00 - 11:00) - Trời xanh sáng
  static const LinearGradient clearSkyMorningGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2563EB), Color(0xFF3B82F6), Color(0xFF60A5FA)],
  );

  // Ban trưa (11:00 - 15:00) - Nắng gắt
  static const LinearGradient clearSkyNoonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E40AF), Color(0xFF3B82F6), Color(0xFF7DD3FC)],
  );

  // Chiều tà (15:00 - 18:00) - Hoàng hôn
  static const LinearGradient clearSkyAfternoonGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF1E3A8A), // Xanh đậm
      Color(0xFFF59E0B), // Cam
      Color(0xFFF97316), // Cam đậm
      Color(0xFFFBBF24), // Vàng
    ],
    stops: [0.0, 0.4, 0.7, 1.0],
  );

  // Hoàng hôn (18:00 - 19:30) - Sunset
  static const LinearGradient clearSkySunsetGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF312E81), // Tím đậm
      Color(0xFFDB2777), // Hồng đậm
      Color(0xFFF97316), // Cam
      Color(0xFFFBBF24), // Vàng
    ],
    stops: [0.0, 0.3, 0.6, 1.0],
  );

  // Chạng vạng (19:30 - 21:00) - Dusk
  static const LinearGradient clearSkyDuskGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF1E1B4B), // Tím đen
      Color(0xFF3730A3), // Tím
      Color(0xFF6366F1), // Xanh tím
    ],
  );

  // Ban đêm (21:00 - 5:00) - Night
  static const LinearGradient clearSkyNightGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0F172A), Color(0xFF1E293B), Color(0xFF334155)],
  );

  // ===== CLOUDY GRADIENTS =====
  static const LinearGradient cloudyDayGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF64748B), Color(0xFF94A3B8), Color(0xFFCBD5E1)],
  );

  static const LinearGradient cloudyNightGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E293B), Color(0xFF334155), Color(0xFF475569)],
  );

  // ===== RAINY GRADIENTS =====
  static const LinearGradient rainyDayGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF475569), Color(0xFF64748B), Color(0xFF94A3B8)],
  );

  static const LinearGradient rainyNightGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0F172A), Color(0xFF1E293B), Color(0xFF334155)],
  );

  // ===== THUNDERSTORM GRADIENTS =====
  static const LinearGradient thunderstormGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0C0A1F), Color(0xFF1A1A2E), Color(0xFF16213E)],
  );

  // ===== SNOW GRADIENTS =====
  static const LinearGradient snowDayGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE0F2FE), Color(0xFFBAE6FD), Color(0xFF7DD3FC)],
  );

  static const LinearGradient snowNightGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E293B), Color(0xFF475569), Color(0xFF94A3B8)],
  );

  // ===== MIST/FOG GRADIENTS =====
  static const LinearGradient mistGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF9CA3AF), Color(0xFFD1D5DB), Color(0xFFE5E7EB)],
  );

  // Legacy gradients (kept for backward compatibility)
  static const LinearGradient clearSkyGradient = clearSkyNoonGradient;
  static const LinearGradient cloudyGradient = cloudyDayGradient;
  static const LinearGradient rainyGradient = rainyDayGradient;
  static const LinearGradient sunsetGradient = clearSkySunsetGradient;
  static const LinearGradient nightGradient = clearSkyNightGradient;
  static const LinearGradient snowGradient = snowDayGradient;

  // Typography
  static const TextStyle displayLarge = TextStyle(
    fontSize: 96,
    fontWeight: FontWeight.w300,
    color: white,
    height: 1.0,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.w300,
    color: white,
    height: 1.1,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w400,
    color: white,
    height: 1.2,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: white,
    height: 1.2,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: white,
    height: 1.2,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: white,
    height: 1.3,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: white,
    height: 1.3,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: white,
    height: 1.4,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: white,
    height: 1.4,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: white,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: white,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: white,
    height: 1.5,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: white,
    letterSpacing: 0.5,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: white,
    letterSpacing: 0.5,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: white,
    letterSpacing: 0.5,
  );

  // Card Styles
  static BoxDecoration glassmorphicCard = BoxDecoration(
    color: Colors.white.withOpacity(0.15),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
    ],
  );

  static BoxDecoration solidCard = BoxDecoration(
    color: Colors.white.withOpacity(0.2),
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.15),
        blurRadius: 15,
        offset: const Offset(0, 8),
      ),
    ],
  );

  static BoxDecoration lightCard = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.08),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );

  // Spacing
  static const double spacingXXS = 4.0;
  static const double spacingXS = 8.0;
  static const double spacingS = 12.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // Border Radius
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusXXL = 24.0;
  static const double radiusCircle = 999.0;

  // Helper Methods

  /// Lấy thời gian trong ngày (time of day category)
  static String getTimeOfDay(DateTime dateTime) {
    final hour = dateTime.hour;

    if (hour >= 5 && hour < 7) return 'dawn'; // Bình minh
    if (hour >= 7 && hour < 11) return 'morning'; // Buổi sáng
    if (hour >= 11 && hour < 15) return 'noon'; // Ban trưa
    if (hour >= 15 && hour < 18) return 'afternoon'; // Chiều tà
    if (hour >= 18 && hour < 19.5) return 'sunset'; // Hoàng hôn
    if (hour >= 19.5 && hour < 21) return 'dusk'; // Chạng vạng
    return 'night'; // Ban đêm
  }

  /// Kiểm tra có phải ban đêm không
  static bool isNightTime(DateTime dateTime) {
    final hour = dateTime.hour;
    return hour >= 21 || hour < 5; // 21:00 - 5:00 là ban đêm
  }

  /// Lấy gradient phù hợp dựa trên thời tiết và thời gian
  static LinearGradient getDynamicGradient({
    String? weatherCondition,
    DateTime? dateTime,
  }) {
    final now = dateTime ?? DateTime.now();
    final timeOfDay = getTimeOfDay(now);
    final condition = weatherCondition?.toLowerCase() ?? 'clear';

    // THUNDERSTORM - Luôn tối (bất kể thời gian)
    if (condition.contains('thunderstorm')) {
      return thunderstormGradient;
    }

    // SNOW
    if (condition.contains('snow')) {
      return isNightTime(now) ? snowNightGradient : snowDayGradient;
    }

    // RAIN / DRIZZLE
    if (condition.contains('rain') || condition.contains('drizzle')) {
      return isNightTime(now) ? rainyNightGradient : rainyDayGradient;
    }

    // MIST / FOG / HAZE
    if (condition.contains('mist') ||
        condition.contains('fog') ||
        condition.contains('haze') ||
        condition.contains('smoke') ||
        condition.contains('dust')) {
      return mistGradient;
    }

    // CLOUDY
    if (condition.contains('cloud')) {
      return isNightTime(now) ? cloudyNightGradient : cloudyDayGradient;
    }

    // CLEAR SKY - Thay đổi theo giờ trong ngày
    switch (timeOfDay) {
      case 'dawn':
        return clearSkyDawnGradient;
      case 'morning':
        return clearSkyMorningGradient;
      case 'noon':
        return clearSkyNoonGradient;
      case 'afternoon':
        return clearSkyAfternoonGradient;
      case 'sunset':
        return clearSkySunsetGradient;
      case 'dusk':
        return clearSkyDuskGradient;
      case 'night':
        return clearSkyNightGradient;
      default:
        return clearSkyNoonGradient;
    }
  }

  static LinearGradient getGradientForWeather(String? condition, bool isNight) {
    // Legacy method - sử dụng getDynamicGradient thay thế
    return getDynamicGradient(
      weatherCondition: condition,
      dateTime: DateTime.now(),
    );
  }

  static Color getConditionColor(String? condition) {
    if (condition == null) return primaryBlue;

    switch (condition.toLowerCase()) {
      case 'clear':
        return const Color(0xFFFFB340);
      case 'clouds':
        return const Color(0xFF8B95A8);
      case 'rain':
      case 'drizzle':
        return const Color(0xFF4CA1AF);
      case 'thunderstorm':
        return const Color(0xFF5A6B8C);
      case 'snow':
        return const Color(0xFF7DD3FC);
      default:
        return primaryBlue;
    }
  }

  static IconData getWeatherIcon(String? condition) {
    if (condition == null) return Icons.wb_sunny;

    switch (condition.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.cloud;
      case 'rain':
        return Icons.grain;
      case 'drizzle':
        return Icons.water_drop;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'snow':
        return Icons.ac_unit;
      case 'mist':
      case 'fog':
        return Icons.blur_on;
      default:
        return Icons.wb_sunny;
    }
  }

  // ===== LIGHT/DARK MODE METHODS =====

  /// Get text color based on theme mode
  static Color getTextColor(bool isDarkMode, {bool isPrimary = true}) {
    if (isDarkMode) {
      return isPrimary ? darkTextPrimary : darkTextSecondary;
    } else {
      return isPrimary ? lightTextPrimary : lightTextSecondary;
    }
  }

  /// Get card background color based on theme mode
  static Color getCardBackground(bool isDarkMode, {double opacity = 1.0}) {
    if (isDarkMode) {
      return darkCardBackground.withOpacity(opacity);
    } else {
      return lightCardBackground.withOpacity(opacity);
    }
  }

  /// Get app background color based on theme mode
  static Color getBackgroundColor(bool isDarkMode) {
    return isDarkMode ? darkBackground : lightBackground;
  }

  /// Get border color based on theme mode
  static Color getBorderColor(bool isDarkMode, {double opacity = 1.0}) {
    if (isDarkMode) {
      return darkBorder.withOpacity(opacity);
    } else {
      return lightBorder.withOpacity(opacity);
    }
  }

  /// Get glassmorphic card decoration for Light Mode
  static BoxDecoration getLightModeCard() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: lightBorder, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  /// Get glassmorphic card decoration for Dark Mode
  static BoxDecoration getDarkModeCard() {
    return BoxDecoration(
      color: darkCardBackground.withOpacity(0.8),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: darkBorder, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  /// Get card decoration based on theme mode
  static BoxDecoration getCardDecoration(bool isDarkMode) {
    return isDarkMode ? getDarkModeCard() : getLightModeCard();
  }

  /// Get gradient overlay for Light Mode (to make text readable)
  static LinearGradient getLightModeOverlay() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.3)],
    );
  }

  /// Get gradient overlay for Dark Mode
  static LinearGradient getDarkModeOverlay() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.black.withOpacity(0.2), Colors.black.withOpacity(0.4)],
    );
  }
}
