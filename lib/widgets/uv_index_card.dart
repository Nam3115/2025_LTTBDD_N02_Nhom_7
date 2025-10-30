import 'package:flutter/material.dart';
import '../models/advanced_weather_model.dart';

class UVIndexCard extends StatelessWidget {
  final UVIndex uvIndex;

  const UVIndexCard({super.key, required this.uvIndex});

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
                  Icon(Icons.wb_sunny, color: Color(uvIndex.color), size: 28),
                  const SizedBox(width: 12),
                  const Text(
                    'Chỉ số UV',
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
                  color: Color(uvIndex.color),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  uvIndex.category,
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
          Center(
            child: Text(
              uvIndex.value.toStringAsFixed(1),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            uvIndex.advice,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          _buildUVScale(),
        ],
      ),
    );
  }

  Widget _buildUVScale() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF00E400), // Green
                Color(0xFFFFFF00), // Yellow
                Color(0xFFFF7E00), // Orange
                Color(0xFFFF0000), // Red
                Color(0xFF8F3F97), // Purple
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('0', style: TextStyle(color: Colors.white70, fontSize: 12)),
            Text('2', style: TextStyle(color: Colors.white70, fontSize: 12)),
            Text('5', style: TextStyle(color: Colors.white70, fontSize: 12)),
            Text('7', style: TextStyle(color: Colors.white70, fontSize: 12)),
            Text('10', style: TextStyle(color: Colors.white70, fontSize: 12)),
            Text('11+', style: TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ],
    );
  }
}
