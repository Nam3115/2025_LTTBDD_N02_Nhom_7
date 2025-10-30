import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  String _temperatureUnit = 'metric'; // metric or imperial
  String _windSpeedUnit = 'ms'; // m/s or mph
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications') ?? true;
      _temperatureUnit = prefs.getString('temperatureUnit') ?? 'metric';
      _windSpeedUnit = prefs.getString('windSpeedUnit') ?? 'ms';
      _darkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications', _notificationsEnabled);
    await prefs.setString('temperatureUnit', _temperatureUnit);
    await prefs.setString('windSpeedUnit', _windSpeedUnit);
    await prefs.setBool('darkMode', _darkMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4A90E2), Color(0xFF50C9C3)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    _buildSectionTitle('Đơn vị đo'),
                    _buildSettingsCard([
                      _buildTemperatureUnitSetting(),
                      const Divider(color: Colors.white24, height: 1),
                      _buildWindSpeedUnitSetting(),
                    ]),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Thông báo'),
                    _buildSettingsCard([_buildNotificationsSetting()]),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Giao diện'),
                    _buildSettingsCard([_buildDarkModeSetting()]),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Thông tin'),
                    _buildSettingsCard([
                      _buildInfoItem('Phiên bản', '1.0.0'),
                      const Divider(color: Colors.white24, height: 1),
                      _buildInfoItem('Nhà phát triển', 'Weather App Team'),
                    ]),
                    const SizedBox(height: 24),
                    _buildAboutSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          const Text(
            'Cài đặt',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildTemperatureUnitSetting() {
    return ListTile(
      leading: const Icon(Icons.thermostat, color: Colors.white),
      title: const Text(
        'Đơn vị nhiệt độ',
        style: TextStyle(color: Colors.white),
      ),
      trailing: DropdownButton<String>(
        value: _temperatureUnit,
        dropdownColor: const Color(0xFF4A90E2),
        style: const TextStyle(color: Colors.white),
        underline: Container(),
        items: const [
          DropdownMenuItem(value: 'metric', child: Text('Celsius (°C)')),
          DropdownMenuItem(value: 'imperial', child: Text('Fahrenheit (°F)')),
        ],
        onChanged: (value) {
          setState(() {
            _temperatureUnit = value!;
          });
          _saveSettings();
        },
      ),
    );
  }

  Widget _buildWindSpeedUnitSetting() {
    return ListTile(
      leading: const Icon(Icons.air, color: Colors.white),
      title: const Text(
        'Đơn vị tốc độ gió',
        style: TextStyle(color: Colors.white),
      ),
      trailing: DropdownButton<String>(
        value: _windSpeedUnit,
        dropdownColor: const Color(0xFF4A90E2),
        style: const TextStyle(color: Colors.white),
        underline: Container(),
        items: const [
          DropdownMenuItem(value: 'ms', child: Text('m/s')),
          DropdownMenuItem(value: 'mph', child: Text('mph')),
          DropdownMenuItem(value: 'kmh', child: Text('km/h')),
        ],
        onChanged: (value) {
          setState(() {
            _windSpeedUnit = value!;
          });
          _saveSettings();
        },
      ),
    );
  }

  Widget _buildNotificationsSetting() {
    return SwitchListTile(
      secondary: const Icon(Icons.notifications, color: Colors.white),
      title: const Text(
        'Thông báo thời tiết',
        style: TextStyle(color: Colors.white),
      ),
      subtitle: const Text(
        'Nhận thông báo về thời tiết hàng ngày',
        style: TextStyle(color: Colors.white70, fontSize: 12),
      ),
      value: _notificationsEnabled,
      activeThumbColor: Colors.white,
      activeTrackColor: Colors.white.withOpacity(0.5),
      onChanged: (value) {
        setState(() {
          _notificationsEnabled = value;
        });
        _saveSettings();
      },
    );
  }

  Widget _buildDarkModeSetting() {
    return SwitchListTile(
      secondary: const Icon(Icons.dark_mode, color: Colors.white),
      title: const Text('Chế độ tối', style: TextStyle(color: Colors.white)),
      subtitle: const Text(
        'Tự động chuyển sang chế độ tối vào ban đêm',
        style: TextStyle(color: Colors.white70, fontSize: 12),
      ),
      value: _darkMode,
      activeThumbColor: Colors.white,
      activeTrackColor: Colors.white.withOpacity(0.5),
      onChanged: (value) {
        setState(() {
          _darkMode = value;
        });
        _saveSettings();
      },
    );
  }

  Widget _buildInfoItem(String title, String value) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: Text(value, style: const TextStyle(color: Colors.white70)),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Về ứng dụng',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Weather App cung cấp thông tin thời tiết chính xác và chi tiết '
            'với dữ liệu từ OpenWeatherMap API. Ứng dụng cung cấp dự báo '
            'theo giờ, theo ngày, chỉ số chất lượng không khí, chỉ số UV và '
            'nhiều tính năng hữu ích khác.',
            style: TextStyle(color: Colors.white70, height: 1.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'Data provided by OpenWeatherMap',
            style: TextStyle(color: Colors.white60, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
