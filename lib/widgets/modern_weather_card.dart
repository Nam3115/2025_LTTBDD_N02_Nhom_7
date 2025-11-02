import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../l10n/app_localizations.dart';

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
          isLarge ? AppTheme.spacingM : 10, // Giảm padding
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
                  padding: const EdgeInsets.all(5), // Giảm từ 6 xuống 5
                  decoration: BoxDecoration(
                    color: (iconColor ?? AppTheme.white).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(AppTheme.radiusM),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor ?? AppTheme.white,
                    size: isLarge ? 18 : 16, // Giảm size icon
                  ),
                ),
                const SizedBox(width: 6), // Giảm từ 8 xuống 6
                Expanded(
                  child: Text(
                    title,
                    style: isLarge
                        ? AppTheme.titleMedium.copyWith(
                            color: AppTheme.white.withOpacity(0.8),
                            fontSize: 13, // Giảm từ 14 xuống 13
                            height: 1.0,
                          )
                        : AppTheme.bodyMedium.copyWith(
                            color: AppTheme.white.withOpacity(0.8),
                            fontSize: 11, // Giảm từ 12 xuống 11
                            height: 1.0,
                          ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: isLarge ? 8 : 5), // Giảm spacing
            // Value
            Text(
              value,
              style:
                  (isLarge ? AppTheme.headlineMedium : AppTheme.headlineSmall)
                      .copyWith(
                        fontSize: isLarge ? 26 : 22, // Giảm font size
                        height: 1.0,
                      ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // Subtitle (optional)
            if (subtitle != null) ...[
              const SizedBox(height: 2),
              Text(
                subtitle!,
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.white.withOpacity(0.7),
                  fontSize: 10, // Giảm từ 11 xuống 10
                  height: 1.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
        horizontal: 8, // Giảm từ 10 xuống 8
        vertical: 5, // Giảm từ 6 xuống 5
      ),
      decoration: AppTheme.glassmorphicCard,
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor ?? AppTheme.white,
            size: 15, // Giảm từ 16 xuống 15
          ),
          const SizedBox(width: 5), // Giảm từ 6 xuống 5
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.white.withOpacity(0.7),
                    fontSize: 9, // Giảm từ 10 xuống 9
                    height: 1.0, // Giảm line height
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  value,
                  style: AppTheme.titleMedium.copyWith(
                    fontSize: 13, // Giảm từ 14 xuống 13
                    height: 1.2, // Giảm line height
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
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
        mainAxisAlignment: MainAxisAlignment.center, // Căn giữa theo chiều dọc
        crossAxisAlignment:
            CrossAxisAlignment.center, // Căn giữa theo chiều ngang
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
          // Temperature - No degree symbol needed, already included
          Text(
            temperature,
            style: AppTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacingS),
          // Condition
          Text(
            condition,
            style: AppTheme.headlineSmall.copyWith(
              color: AppTheme.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacingXS),
          // Feels Like
          Text(
            '${AppLocalizations.of(context)!.feelsLike} $feelsLike',
            style: AppTheme.bodyLarge.copyWith(
              color: AppTheme.white.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
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
                Text(high, style: AppTheme.titleLarge),
                const SizedBox(width: AppTheme.spacingL),
                Icon(
                  Icons.arrow_downward,
                  color: AppTheme.white.withOpacity(0.8),
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(low, style: AppTheme.titleLarge),
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
