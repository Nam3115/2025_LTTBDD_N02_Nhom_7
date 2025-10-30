class UnitConverter {
  // Temperature conversion
  static double celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  static double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }

  static String formatTemperature(double celsius, String unit) {
    if (unit == 'imperial') {
      return '${celsiusToFahrenheit(celsius).round()}';
    }
    return '${celsius.round()}';
  }

  static String getTemperatureUnit(String unit) {
    return unit == 'imperial' ? '°F' : '°C';
  }

  // Wind speed conversion
  static double metersPerSecondToMilesPerHour(double ms) {
    return ms * 2.23694;
  }

  static double metersPerSecondToKilometersPerHour(double ms) {
    return ms * 3.6;
  }

  static String formatWindSpeed(double ms, String unit) {
    switch (unit) {
      case 'mph':
        return metersPerSecondToMilesPerHour(ms).toStringAsFixed(1);
      case 'kmh':
        return metersPerSecondToKilometersPerHour(ms).toStringAsFixed(1);
      default: // 'ms'
        return ms.toStringAsFixed(1);
    }
  }

  static String getWindSpeedUnit(String unit) {
    switch (unit) {
      case 'mph':
        return 'mph';
      case 'kmh':
        return 'km/h';
      default:
        return 'm/s';
    }
  }

  // Distance/Visibility conversion
  static double metersToMiles(double meters) {
    return meters * 0.000621371;
  }

  static double metersToKilometers(double meters) {
    return meters / 1000;
  }

  static String formatVisibility(double meters, String unit) {
    if (unit == 'imperial') {
      return metersToMiles(meters).toStringAsFixed(1);
    }
    return metersToKilometers(meters).toStringAsFixed(1);
  }

  static String getVisibilityUnit(String unit) {
    return unit == 'imperial' ? 'mi' : 'km';
  }
}
