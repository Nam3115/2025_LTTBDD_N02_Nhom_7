import 'package:flutter/material.dart';
import 'dart:math' as math;

class WeatherAnimations extends StatefulWidget {
  final String weatherCondition;

  const WeatherAnimations({super.key, required this.weatherCondition});

  @override
  State<WeatherAnimations> createState() => _WeatherAnimationsState();
}

class _WeatherAnimationsState extends State<WeatherAnimations>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final List<Raindrop> _raindrops = [];
  final List<Snowflake> _snowflakes = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    if (widget.weatherCondition.toLowerCase().contains('rain')) {
      _initRaindrops();
    } else if (widget.weatherCondition.toLowerCase().contains('snow')) {
      _initSnowflakes();
    }
  }

  void _initRaindrops() {
    for (int i = 0; i < 50; i++) {
      _raindrops.add(
        Raindrop(
          x: math.Random().nextDouble(),
          y: math.Random().nextDouble(),
          speed: 0.02 + math.Random().nextDouble() * 0.03,
        ),
      );
    }
  }

  void _initSnowflakes() {
    for (int i = 0; i < 30; i++) {
      _snowflakes.add(
        Snowflake(
          x: math.Random().nextDouble(),
          y: math.Random().nextDouble(),
          speed: 0.01 + math.Random().nextDouble() * 0.02,
          size: 2 + math.Random().nextDouble() * 3,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.weatherCondition.toLowerCase().contains('rain')) {
      return _buildRainAnimation();
    } else if (widget.weatherCondition.toLowerCase().contains('snow')) {
      return _buildSnowAnimation();
    } else if (widget.weatherCondition.toLowerCase().contains('thunder')) {
      return _buildThunderAnimation();
    }
    return const SizedBox.shrink();
  }

  Widget _buildRainAnimation() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: RainPainter(
            raindrops: _raindrops,
            animation: _controller.value,
          ),
          size: Size.infinite,
        );
      },
    );
  }

  Widget _buildSnowAnimation() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: SnowPainter(
            snowflakes: _snowflakes,
            animation: _controller.value,
          ),
          size: Size.infinite,
        );
      },
    );
  }

  Widget _buildThunderAnimation() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final showFlash = (_controller.value * 10).floor() % 3 == 0;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          color: showFlash ? Colors.white.withOpacity(0.3) : Colors.transparent,
        );
      },
    );
  }
}

class Raindrop {
  double x;
  double y;
  final double speed;

  Raindrop({required this.x, required this.y, required this.speed});
}

class RainPainter extends CustomPainter {
  final List<Raindrop> raindrops;
  final double animation;

  RainPainter({required this.raindrops, required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 1.5;

    for (var drop in raindrops) {
      drop.y += drop.speed;
      if (drop.y > 1) drop.y = 0;

      final start = Offset(drop.x * size.width, drop.y * size.height);
      final end = Offset(drop.x * size.width, (drop.y * size.height) + 20);
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Snowflake {
  double x;
  double y;
  final double speed;
  final double size;

  Snowflake({
    required this.x,
    required this.y,
    required this.speed,
    required this.size,
  });
}

class SnowPainter extends CustomPainter {
  final List<Snowflake> snowflakes;
  final double animation;

  SnowPainter({required this.snowflakes, required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    for (var flake in snowflakes) {
      flake.y += flake.speed;
      flake.x += math.sin(animation * math.pi * 2) * 0.001;

      if (flake.y > 1) flake.y = 0;
      if (flake.x < 0) flake.x = 1;
      if (flake.x > 1) flake.x = 0;

      canvas.drawCircle(
        Offset(flake.x * size.width, flake.y * size.height),
        flake.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
