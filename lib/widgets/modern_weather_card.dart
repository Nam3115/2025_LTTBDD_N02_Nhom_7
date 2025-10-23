import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class ModernWeatherCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback? onTap;
  final bool isLarge;

  const ModernWeatherCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    required this.icon,
    this.iconColor,
    this.onTap,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(
          isLarge ? AppTheme.spacingL : AppTheme.spacingM,
        ),
        decoration: AppTheme.glassmorphicCard,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon and Title Row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (iconColor ?? AppTheme.white).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(AppTheme.radiusM),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor ?? AppTheme.white,
                    size: isLarge ? 24 : 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: isLarge
                        ? AppTheme.titleMedium.copyWith(
                            color: AppTheme.white.withOpacity(0.8),
                          )
                        : AppTheme.bodyMedium.copyWith(
                            color: AppTheme.white.withOpacity(0.8),
                          ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: isLarge ? AppTheme.spacingM : AppTheme.spacingS),
            // Value
            Text(
              value,
              style: isLarge ? AppTheme.headlineMedium : AppTheme.headlineSmall,
            ),
            // Subtitle (optional)
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.white.withOpacity(0.7),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class CompactWeatherCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? iconColor;

  const CompactWeatherCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingM,
        vertical: AppTheme.spacingS,
      ),
      decoration: AppTheme.glassmorphicCard,
      child: Row(
        children: [
          Icon(icon, color: iconColor ?? AppTheme.white, size: 20),
          const SizedBox(width: AppTheme.spacingS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 2),
                Text(value, style: AppTheme.titleMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeroWeatherCard extends StatelessWidget {
  final String temperature;
  final String condition;
  final String feelsLike;
  final String high;
  final String low;
  final IconData weatherIcon;

  const HeroWeatherCard({
    super.key,
    required this.temperature,
    required this.condition,
    required this.feelsLike,
    required this.high,
    required this.low,
    required this.weatherIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingXL),
      decoration: AppTheme.glassmorphicCard.copyWith(
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          // Weather Icon
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(weatherIcon, size: 80, color: AppTheme.white),
          ),
          const SizedBox(height: AppTheme.spacingL),
          // Temperature
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(temperature, style: AppTheme.displayLarge),
              Text('°', style: AppTheme.displayMedium.copyWith(fontSize: 48)),
            ],
          ),
          const SizedBox(height: AppTheme.spacingS),
          // Condition
          Text(
            condition,
            style: AppTheme.headlineSmall.copyWith(
              color: AppTheme.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: AppTheme.spacingXS),
          // Feels Like
          Text(
            'Cảm giác như $feelsLike°',
            style: AppTheme.bodyLarge.copyWith(
              color: AppTheme.white.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: AppTheme.spacingL),
          // High/Low
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingL,
              vertical: AppTheme.spacingM,
            ),
            decoration: BoxDecoration(
              color: AppTheme.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(AppTheme.radiusXL),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_upward,
                  color: AppTheme.white.withOpacity(0.8),
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text('$high°', style: AppTheme.titleLarge),
                const SizedBox(width: AppTheme.spacingL),
                Icon(
                  Icons.arrow_downward,
                  color: AppTheme.white.withOpacity(0.8),
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text('$low°', style: AppTheme.titleLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InfoChipCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? backgroundColor;

  const InfoChipCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingM,
        vertical: AppTheme.spacingS,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppTheme.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppTheme.radiusCircle),
        border: Border.all(color: AppTheme.white.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppTheme.white),
          const SizedBox(width: AppTheme.spacingXS),
          Text(label, style: AppTheme.bodySmall),
          const SizedBox(width: AppTheme.spacingXS),
          Text(value, style: AppTheme.labelMedium),
        ],
      ),
    );
  }
}
