import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

/// Widget để preview tất cả các background gradient
/// Dùng để test và xem các màu sắc thay đổi theo thời gian và thời tiết
class BackgroundPreviewWidget extends StatelessWidget {
  const BackgroundPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Background Preview'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection('TRỜI QUANG - THEO THỜI GIAN', [
            _buildGradientCard(
              'Bình Minh (5:00-7:00)',
              AppTheme.clearSkyDawnGradient,
              '🌅',
            ),
            _buildGradientCard(
              'Buổi Sáng (7:00-11:00)',
              AppTheme.clearSkyMorningGradient,
              '☀️',
            ),
            _buildGradientCard(
              'Ban Trưa (11:00-15:00)',
              AppTheme.clearSkyNoonGradient,
              '🌞',
            ),
            _buildGradientCard(
              'Chiều Tà (15:00-18:00)',
              AppTheme.clearSkyAfternoonGradient,
              '🌇',
            ),
            _buildGradientCard(
              'Hoàng Hôn (18:00-19:30)',
              AppTheme.clearSkySunsetGradient,
              '🌆',
            ),
            _buildGradientCard(
              'Chạng Vạng (19:30-21:00)',
              AppTheme.clearSkyDuskGradient,
              '🌃',
            ),
            _buildGradientCard(
              'Ban Đêm (21:00-5:00)',
              AppTheme.clearSkyNightGradient,
              '🌙',
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection('NHIỀU MÂY', [
            _buildGradientCard(
              'Mây Ban Ngày',
              AppTheme.cloudyDayGradient,
              '☁️',
            ),
            _buildGradientCard(
              'Mây Ban Đêm',
              AppTheme.cloudyNightGradient,
              '☁️🌙',
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection('MƯA', [
            _buildGradientCard(
              'Mưa Ban Ngày',
              AppTheme.rainyDayGradient,
              '🌧️',
            ),
            _buildGradientCard(
              'Mưa Ban Đêm',
              AppTheme.rainyNightGradient,
              '🌧️🌙',
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection('THỜI TIẾT ĐẶC BIỆT', [
            _buildGradientCard(
              'Giông Bão',
              AppTheme.thunderstormGradient,
              '⛈️',
            ),
            _buildGradientCard(
              'Tuyết Ban Ngày',
              AppTheme.snowDayGradient,
              '❄️',
            ),
            _buildGradientCard(
              'Tuyết Ban Đêm',
              AppTheme.snowNightGradient,
              '❄️🌙',
            ),
            _buildGradientCard('Sương Mù', AppTheme.mistGradient, '🌫️'),
          ]),
          const SizedBox(height: 24),
          _buildTestSection(),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildGradientCard(
    String label,
    LinearGradient gradient,
    String emoji,
  ) {
    return Container(
      height: 120,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Label
          Positioned(
            left: 16,
            top: 16,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
              ),
            ),
          ),
          // Emoji
          Positioned(
            right: 16,
            bottom: 16,
            child: Text(emoji, style: const TextStyle(fontSize: 48)),
          ),
        ],
      ),
    );
  }

  Widget _buildTestSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TEST ĐỘNG - GRADIENT THEO THỜI GIAN THỰC',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        _buildDynamicTestCard('Clear', DateTime.now()),
        _buildDynamicTestCard('Clouds', DateTime.now()),
        _buildDynamicTestCard('Rain', DateTime.now()),
        const SizedBox(height: 16),
        const Text(
          '💡 TIP: Thay đổi giờ trên thiết bị để xem background thay đổi!',
          style: TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildDynamicTestCard(String condition, DateTime dateTime) {
    final gradient = AppTheme.getDynamicGradient(
      weatherCondition: condition,
      dateTime: dateTime,
    );
    final timeOfDay = AppTheme.getTimeOfDay(dateTime);
    final hour = dateTime.hour;

    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$condition - Hiện tại',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
              ),
            ),
            Text(
              '🕐 ${hour.toString().padLeft(2, '0')}:00 - $timeOfDay',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
