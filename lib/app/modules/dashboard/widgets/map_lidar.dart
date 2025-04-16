import 'dart:math';
import 'package:flutter/material.dart';

class RadarWidget extends StatelessWidget {
  final List<Map<String, double>> points;
  final double maxDistance;
  final double angle;

  const RadarWidget(
      {super.key,
      required this.points,
      required this.maxDistance,
      required this.angle});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(500, 500),
      painter:
          RadarPainter(points: points, maxDistance: maxDistance, angle: angle),
    );
  }
}

class RadarPainter extends CustomPainter {
  final List<Map<String, double>> points;
  final double maxDistance;
  final double angle;

  RadarPainter(
      {required this.points, required this.maxDistance, required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    final paintBackground = Paint()
      ..shader = const RadialGradient(
        colors: [
          Color.fromARGB(255, 126, 123, 123),
          Color.fromARGB(255, 220, 220, 224)
        ],
        stops: [0.3, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, paintBackground);

    final paintPoint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final paintLine = Paint()
      ..color = Colors.black.withValues(alpha: 0.3)
      ..strokeWidth = 2;

    // Draw circles every 1000 units
    final paintCircle = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final paintCircleNear = Paint()
      ..color = Colors.red.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (int distance = 1000; distance <= maxDistance; distance += 1000) {
      double circleRadius = (distance / (maxDistance + 20)) * radius;
      canvas.drawCircle(center, circleRadius,
          distance <= 2000 ? paintCircleNear : paintCircle);
    }

    // Draw vertical middle line
    canvas.drawLine(Offset(center.dx, center.dy - radius),
        Offset(center.dx, center.dy + radius), paintLine);

    // Draw horizontal middle line
    canvas.drawLine(Offset(center.dx - radius, center.dy),
        Offset(center.dx + radius, center.dy), paintLine);

    // Draw detection line and background
    final paintDetectionLine = Paint()
      ..color = Colors.green
      ..strokeWidth = 2;

    final paintDetectionBackground = Paint()
      ..color = Colors.green.withOpacity(0.2);

    final angleRad = (angle / 2) * pi / 180;
    final dx = center.dx + radius * cos(angleRad - pi / 2);
    final dy = center.dy + radius * sin(angleRad - pi / 2);

    final angleRad2 = (-angle / 2) * pi / 180;
    final dx2 = center.dx + radius * cos(angleRad2 - pi / 2);
    final dy2 = center.dy + radius * sin(angleRad2 - pi / 2);

    // Draw background between detection lines
    final path = Path()
      ..moveTo(center.dx, center.dy)
      ..lineTo(dx, dy)
      ..arcTo(Rect.fromCircle(center: center, radius: radius),
          angleRad - pi / 2, -angle * pi / 180, false)
      ..lineTo(center.dx, center.dy);
    canvas.drawPath(path, paintDetectionBackground);

    // Draw detection lines
    canvas.drawLine(center, Offset(dx, dy), paintDetectionLine);
    canvas.drawLine(center, Offset(dx2, dy2), paintDetectionLine);

    for (var point in points) {
      double angle = point['angle']! * pi / 180;
      double distance = point['distance']!;

      // Normalizar distancia al radio del radar (asumiendo máx. 100)
      double scaledDistance = (distance / (maxDistance + 20)) * radius;

      final dx = center.dx + scaledDistance * cos(angle - pi / 2);
      final dy = center.dy + scaledDistance * sin(angle - pi / 2);

      canvas.drawCircle(Offset(dx, dy), 4, paintPoint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
