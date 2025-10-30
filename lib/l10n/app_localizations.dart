import 'package:flutter/material.dart';

/// Hệ thống đa ngôn ngữ cho Weather App
/// Hỗ trợ: Tiếng Việt (vi) và Tiếng Anh (en)
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // Supported locales
  static const List<Locale> supportedLocales = [
    Locale('vi', 'VN'), // Tiếng Việt
    Locale('en', 'US'), // English
  ];

  // Get translations based on locale
  static final Map<String, Map<String, String>> _localizedValues = {
    'en': _enTranslations,
    'vi': _viTranslations,
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  // Getter methods for easy access
  String get appName => translate('app_name');
  String get weatherForecast => translate('weather_forecast');

  // Home Screen
  String get myLocation => translate('my_location');
  String get search => translate('search');
  String get refresh => translate('refresh');
  String get settings => translate('settings');
  String get feelsLike => translate('feels_like');
  String get humidity => translate('humidity');
  String get wind => translate('wind');
  String get pressure => translate('pressure');
  String get visibility => translate('visibility');
  String get uvIndex => translate('uv_index');
  String get airQuality => translate('air_quality');
  String get sunrise => translate('sunrise');
  String get sunset => translate('sunset');

  // Weather Conditions
  String get clear => translate('clear');
  String get clouds => translate('clouds');
  String get rain => translate('rain');
  String get drizzle => translate('drizzle');
  String get thunderstorm => translate('thunderstorm');
  String get snow => translate('snow');
  String get mist => translate('mist');
  String get fog => translate('fog');
  String get haze => translate('haze');
  String get smoke => translate('smoke');
  String get dust => translate('dust');
  String get sand => translate('sand');
  String get ash => translate('ash');
  String get squall => translate('squall');
  String get tornado => translate('tornado');

  // Forecast
  String get hourlyForecast => translate('hourly_forecast');
  String get dailyForecast => translate('daily_forecast');
  String get today => translate('today');
  String get tomorrow => translate('tomorrow');

  // Details
  String get weatherDetails => translate('weather_details');
  String get minTemp => translate('min_temp');
  String get maxTemp => translate('max_temp');
  String get precipitation => translate('precipitation');
  String get cloudiness => translate('cloudiness');
  String get windDirection => translate('wind_direction');
  String get windSpeed => translate('wind_speed');

  // Wind Directions
  String get north => translate('north');
  String get northEast => translate('north_east');
  String get east => translate('east');
  String get southEast => translate('south_east');
  String get south => translate('south');
  String get southWest => translate('south_west');
  String get west => translate('west');
  String get northWest => translate('north_west');

  // Air Quality
  String get good => translate('good');
  String get fair => translate('fair');
  String get moderate => translate('moderate');
  String get poor => translate('poor');
  String get veryPoor => translate('very_poor');

  // Settings
  String get settingsTitle => translate('settings_title');
  String get general => translate('general');
  String get units => translate('units');
  String get temperatureUnit => translate('temperature_unit');
  String get windSpeedUnit => translate('wind_speed_unit');
  String get celsius => translate('celsius');
  String get fahrenheit => translate('fahrenheit');
  String get metersPerSecond => translate('meters_per_second');
  String get milesPerHour => translate('miles_per_hour');
  String get kilometersPerHour => translate('kilometers_per_hour');

  String get notifications => translate('notifications');
  String get weatherNotifications => translate('weather_notifications');
  String get weatherNotificationsDesc =>
      translate('weather_notifications_desc');

  String get appearance => translate('appearance');
  String get themeMode => translate('theme_mode');
  String get themeModeDesc => translate('theme_mode_desc');
  String get lightMode => translate('light_mode');
  String get darkMode => translate('dark_mode');
  String get systemMode => translate('system_mode');
  String get viewBackgrounds => translate('view_backgrounds');
  String get viewBackgroundsDesc => translate('view_backgrounds_desc');

  String get language => translate('language');
  String get languageTitle => translate('language_title');
  String get languageDesc => translate('language_desc');
  String get vietnamese => translate('vietnamese');
  String get english => translate('english');

  String get about => translate('about');
  String get version => translate('version');
  String get developer => translate('developer');
  String get aboutApp => translate('about_app');
  String get aboutAppDesc => translate('about_app_desc');
  String get dataProvider => translate('data_provider');

  // Errors
  String get error => translate('error');
  String get errorLoadingWeather => translate('error_loading_weather');
  String get errorLocation => translate('error_location');
  String get errorLocationPermission => translate('error_location_permission');
  String get errorLocationPermissionDenied =>
      translate('error_location_permission_denied');
  String get errorLocationPermissionForever =>
      translate('error_location_permission_forever');
  String get errorLocationService => translate('error_location_service');
  String get errorNetwork => translate('error_network');
  String get errorTimeout => translate('error_timeout');
  String get errorApi => translate('error_api');
  String get errorCityNotFound => translate('error_city_not_found');
  String get retry => translate('retry');

  // Search
  String get searchCity => translate('search_city');
  String get searchHint => translate('search_hint');
  String get recentSearches => translate('recent_searches');
  String get popularCities => translate('popular_cities');

  // Loading
  String get loading => translate('loading');
  String get loadingWeather => translate('loading_weather');
  String get pleaseWait => translate('please_wait');

  // Time
  String get morning => translate('morning');
  String get afternoon => translate('afternoon');
  String get evening => translate('evening');
  String get night => translate('night');
  String get dawn => translate('dawn');
  String get dusk => translate('dusk');
  String get noon => translate('noon');

  // Units
  String get degree => translate('degree');
  String get percent => translate('percent');
  String get kilometer => translate('kilometer');
  String get meter => translate('meter');
  String get millimeter => translate('millimeter');
  String get hectopascal => translate('hectopascal');
}

// English Translations
const Map<String, String> _enTranslations = {
  'app_name': 'Weather App',
  'weather_forecast': 'Weather Forecast',

  // Home Screen
  'my_location': 'My Location',
  'search': 'Search',
  'refresh': 'Refresh',
  'settings': 'Settings',
  'feels_like': 'Feels Like',
  'humidity': 'Humidity',
  'wind': 'Wind',
  'pressure': 'Pressure',
  'visibility': 'Visibility',
  'uv_index': 'UV Index',
  'air_quality': 'Air Quality',
  'sunrise': 'Sunrise',
  'sunset': 'Sunset',

  // Weather Conditions
  'clear': 'Clear Sky',
  'clouds': 'Cloudy',
  'rain': 'Rain',
  'drizzle': 'Drizzle',
  'thunderstorm': 'Thunderstorm',
  'snow': 'Snow',
  'mist': 'Mist',
  'fog': 'Fog',
  'haze': 'Haze',
  'smoke': 'Smoke',
  'dust': 'Dust',
  'sand': 'Sand',
  'ash': 'Volcanic Ash',
  'squall': 'Squall',
  'tornado': 'Tornado',

  // Forecast
  'hourly_forecast': 'Hourly Forecast',
  'daily_forecast': 'Daily Forecast',
  'today': 'Today',
  'tomorrow': 'Tomorrow',

  // Details
  'weather_details': 'Weather Details',
  'min_temp': 'Min',
  'max_temp': 'Max',
  'precipitation': 'Precipitation',
  'cloudiness': 'Cloudiness',
  'wind_direction': 'Wind Direction',
  'wind_speed': 'Wind Speed',

  // Wind Directions
  'north': 'North',
  'north_east': 'Northeast',
  'east': 'East',
  'south_east': 'Southeast',
  'south': 'South',
  'south_west': 'Southwest',
  'west': 'West',
  'north_west': 'Northwest',

  // Air Quality
  'good': 'Good',
  'fair': 'Fair',
  'moderate': 'Moderate',
  'poor': 'Poor',
  'very_poor': 'Very Poor',

  // Settings
  'settings_title': 'Settings',
  'general': 'General',
  'units': 'Units',
  'temperature_unit': 'Temperature Unit',
  'wind_speed_unit': 'Wind Speed Unit',
  'celsius': 'Celsius (°C)',
  'fahrenheit': 'Fahrenheit (°F)',
  'meters_per_second': 'Meters/second (m/s)',
  'miles_per_hour': 'Miles/hour (mph)',
  'kilometers_per_hour': 'Kilometers/hour (km/h)',

  'notifications': 'Notifications',
  'weather_notifications': 'Weather Notifications',
  'weather_notifications_desc': 'Receive daily weather notifications',

  'appearance': 'Appearance',
  'theme_mode': 'Theme Mode',
  'theme_mode_desc': 'Choose your preferred theme',
  'light_mode': 'Light Mode',
  'dark_mode': 'Dark Mode',
  'system_mode': 'System Default',
  'view_backgrounds': 'View Dynamic Backgrounds',
  'view_backgrounds_desc': 'Preview all weather backgrounds',

  'language': 'Language',
  'language_title': 'Language',
  'language_desc': 'Choose your preferred language',
  'vietnamese': 'Tiếng Việt',
  'english': 'English',

  'about': 'About',
  'version': 'Version',
  'developer': 'Developer',
  'about_app': 'About App',
  'about_app_desc':
      'Weather App provides accurate and detailed weather information with data from OpenWeatherMap API. The app offers hourly and daily forecasts, air quality index, UV index, and many other useful features.',
  'data_provider': 'Data provided by OpenWeatherMap',

  // Errors
  'error': 'Error',
  'error_loading_weather': 'Cannot load weather data. Please try again later.',
  'error_location': 'Cannot determine your location',
  'error_location_permission': 'Location permission required',
  'error_location_permission_denied':
      'Location permission denied. Please grant permission in browser settings.',
  'error_location_permission_forever':
      'Location permission permanently denied. Please grant permission in device settings.',
  'error_location_service':
      'Location service is not enabled. Please enable GPS.',
  'error_network': 'No internet connection',
  'error_timeout': 'Connection too slow, please try again',
  'error_api': 'API error, please check API key',
  'error_city_not_found': 'City not found',
  'retry': 'Retry',

  // Search
  'search_city': 'Search City',
  'search_hint': 'Enter city name...',
  'recent_searches': 'Recent Searches',
  'popular_cities': 'Popular Cities',

  // Loading
  'loading': 'Loading',
  'loading_weather': 'Loading weather data...',
  'please_wait': 'Please wait',

  // Time
  'morning': 'Morning',
  'afternoon': 'Afternoon',
  'evening': 'Evening',
  'night': 'Night',
  'dawn': 'Dawn',
  'dusk': 'Dusk',
  'noon': 'Noon',

  // Units
  'degree': '°',
  'percent': '%',
  'kilometer': 'km',
  'meter': 'm',
  'millimeter': 'mm',
  'hectopascal': 'hPa',
};

// Vietnamese Translations
const Map<String, String> _viTranslations = {
  'app_name': 'Ứng Dụng Thời Tiết',
  'weather_forecast': 'Dự Báo Thời Tiết',

  // Home Screen
  'my_location': 'Vị Trí Của Tôi',
  'search': 'Tìm Kiếm',
  'refresh': 'Làm Mới',
  'settings': 'Cài Đặt',
  'feels_like': 'Cảm Giác Như',
  'humidity': 'Độ Ẩm',
  'wind': 'Gió',
  'pressure': 'Áp Suất',
  'visibility': 'Tầm Nhìn',
  'uv_index': 'Chỉ Số UV',
  'air_quality': 'Chất Lượng Không Khí',
  'sunrise': 'Mặt Trời Mọc',
  'sunset': 'Mặt Trời Lặn',

  // Weather Conditions
  'clear': 'Trời Quang',
  'clouds': 'Nhiều Mây',
  'rain': 'Mưa',
  'drizzle': 'Mưa Phùn',
  'thunderstorm': 'Dông',
  'snow': 'Tuyết',
  'mist': 'Sương Mù',
  'fog': 'Sương Mù Dày',
  'haze': 'Sương Mù Nhẹ',
  'smoke': 'Khói',
  'dust': 'Bụi',
  'sand': 'Cát Bụi',
  'ash': 'Tro Núi Lửa',
  'squall': 'Giông',
  'tornado': 'Lốc Xoáy',

  // Forecast
  'hourly_forecast': 'Dự Báo Theo Giờ',
  'daily_forecast': 'Dự Báo Theo Ngày',
  'today': 'Hôm Nay',
  'tomorrow': 'Ngày Mai',

  // Details
  'weather_details': 'Chi Tiết Thời Tiết',
  'min_temp': 'Thấp Nhất',
  'max_temp': 'Cao Nhất',
  'precipitation': 'Lượng Mưa',
  'cloudiness': 'Độ Mây',
  'wind_direction': 'Hướng Gió',
  'wind_speed': 'Tốc Độ Gió',

  // Wind Directions
  'north': 'Bắc',
  'north_east': 'Đông Bắc',
  'east': 'Đông',
  'south_east': 'Đông Nam',
  'south': 'Nam',
  'south_west': 'Tây Nam',
  'west': 'Tây',
  'north_west': 'Tây Bắc',

  // Air Quality
  'good': 'Tốt',
  'fair': 'Khá',
  'moderate': 'Trung Bình',
  'poor': 'Kém',
  'very_poor': 'Rất Kém',

  // Settings
  'settings_title': 'Cài Đặt',
  'general': 'Chung',
  'units': 'Đơn Vị Đo',
  'temperature_unit': 'Đơn Vị Nhiệt Độ',
  'wind_speed_unit': 'Đơn Vị Tốc Độ Gió',
  'celsius': 'Độ C (°C)',
  'fahrenheit': 'Độ F (°F)',
  'meters_per_second': 'Mét/giây (m/s)',
  'miles_per_hour': 'Dặm/giờ (mph)',
  'kilometers_per_hour': 'Kilômét/giờ (km/h)',

  'notifications': 'Thông Báo',
  'weather_notifications': 'Thông Báo Thời Tiết',
  'weather_notifications_desc': 'Nhận thông báo thời tiết hàng ngày',

  'appearance': 'Giao Diện',
  'theme_mode': 'Chế Độ Giao Diện',
  'theme_mode_desc': 'Chọn chế độ giao diện ưa thích',
  'light_mode': 'Sáng',
  'dark_mode': 'Tối',
  'system_mode': 'Theo Hệ Thống',
  'view_backgrounds': 'Xem Background Động',
  'view_backgrounds_desc': 'Xem tất cả background theo thời tiết',

  'language': 'Ngôn Ngữ',
  'language_title': 'Ngôn Ngữ',
  'language_desc': 'Chọn ngôn ngữ hiển thị',
  'vietnamese': 'Tiếng Việt',
  'english': 'English',

  'about': 'Thông Tin',
  'version': 'Phiên Bản',
  'developer': 'Nhà Phát Triển',
  'about_app': 'Về Ứng Dụng',
  'about_app_desc':
      'Weather App cung cấp thông tin thời tiết chính xác và chi tiết với dữ liệu từ OpenWeatherMap API. Ứng dụng cung cấp dự báo theo giờ, theo ngày, chỉ số chất lượng không khí, chỉ số UV và nhiều tính năng hữu ích khác.',
  'data_provider': 'Dữ liệu cung cấp bởi OpenWeatherMap',

  // Errors
  'error': 'Lỗi',
  'error_loading_weather': 'Không thể tải thời tiết. Vui lòng thử lại sau.',
  'error_location': 'Không thể xác định vị trí của bạn',
  'error_location_permission': 'Cần cấp quyền truy cập vị trí',
  'error_location_permission_denied':
      'Quyền truy cập vị trí bị từ chối. Vui lòng cấp quyền trong cài đặt trình duyệt.',
  'error_location_permission_forever':
      'Quyền truy cập vị trí bị từ chối vĩnh viễn. Vui lòng cấp quyền trong cài đặt thiết bị.',
  'error_location_service': 'Dịch vụ vị trí chưa được bật. Vui lòng bật GPS.',
  'error_network': 'Không có kết nối internet',
  'error_timeout': 'Kết nối quá chậm, vui lòng thử lại',
  'error_api': 'Lỗi API, vui lòng kiểm tra API key',
  'error_city_not_found': 'Không tìm thấy thành phố',
  'retry': 'Thử Lại',

  // Search
  'search_city': 'Tìm Kiếm Thành Phố',
  'search_hint': 'Nhập tên thành phố...',
  'recent_searches': 'Tìm Kiếm Gần Đây',
  'popular_cities': 'Thành Phố Phổ Biến',

  // Loading
  'loading': 'Đang Tải',
  'loading_weather': 'Đang tải dữ liệu thời tiết...',
  'please_wait': 'Vui lòng đợi',

  // Time
  'morning': 'Buổi Sáng',
  'afternoon': 'Chiều Tà',
  'evening': 'Buổi Tối',
  'night': 'Ban Đêm',
  'dawn': 'Bình Minh',
  'dusk': 'Chạng Vạng',
  'noon': 'Ban Trưa',

  // Units
  'degree': '°',
  'percent': '%',
  'kilometer': 'km',
  'meter': 'm',
  'millimeter': 'mm',
  'hectopascal': 'hPa',
};

// Localizations Delegate
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'vi'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
