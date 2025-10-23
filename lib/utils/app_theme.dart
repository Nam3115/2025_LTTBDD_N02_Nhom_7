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

  // Weather-based Gradients
  static const LinearGradient clearSkyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2E5CFF), Color(0xFF3E7BFF), Color(0xFF47BFFF)],
  );

  static const LinearGradient cloudyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6B7F9C), Color(0xFF8B95A8), Color(0xFF99A8B9)],
  );

  static const LinearGradient rainyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2C3E50), Color(0xFF3F5973), Color(0xFF4CA1AF)],
  );

  static const LinearGradient thunderstormGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF141E30), Color(0xFF1E2B44), Color(0xFF243B55)],
  );

  static const LinearGradient snowGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE0F2FE), Color(0xFFBAE6FD), Color(0xFF7DD3FC)],
  );

  static const LinearGradient sunsetGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF6B6B), Color(0xFFFECA57), Color(0xFFEE5A6F)],
  );

  static const LinearGradient nightGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
  );

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
  static LinearGradient getGradientForWeather(String? condition, bool isNight) {
    if (condition == null) return clearSkyGradient;

    if (isNight &&
        (condition.toLowerCase() == 'clear' ||
            condition.toLowerCase() == 'clouds')) {
      return nightGradient;
    }

    switch (condition.toLowerCase()) {
      case 'clear':
        return clearSkyGradient;
      case 'clouds':
        return cloudyGradient;
      case 'rain':
      case 'drizzle':
        return rainyGradient;
      case 'thunderstorm':
        return thunderstormGradient;
      case 'snow':
        return snowGradient;
      default:
        return clearSkyGradient;
    }
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
}
