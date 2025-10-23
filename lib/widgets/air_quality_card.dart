import 'package:flutter/material.dart';
import '../models/air_quality_model.dart';

class AirQualityCard extends StatelessWidget {
  final AirQuality airQuality;

  const AirQualityCard({super.key, required this.airQuality});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.air,
                    color: Color(airQuality.getAQIColor()),
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Chất lượng không khí',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Color(airQuality.getAQIColor()),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  airQuality.category,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            airQuality.getHealthAdvice(),
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPollutantItem('PM2.5', airQuality.pm2_5.toStringAsFixed(1)),
              _buildPollutantItem('PM10', airQuality.pm10.toStringAsFixed(1)),
              _buildPollutantItem('O₃', airQuality.o3.toStringAsFixed(0)),
              _buildPollutantItem('NO₂', airQuality.no2.toStringAsFixed(0)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPollutantItem(String name, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(name, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}
