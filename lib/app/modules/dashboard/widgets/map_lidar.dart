import 'dart:math';
import 'package:flutter/material.dart';

class RadarWidget extends StatelessWidget {
  final List<Map<String, double>> points;

  const RadarWidget({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 200),
      painter: RadarPainter(points: points),
    );
  }
}


class RadarPainter extends CustomPainter {
  final List<Map<String, double>> points;

  RadarPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    final paintBackground = Paint()
      ..shader = RadialGradient(
        colors: [Colors.deepOrange, Colors.indigo.shade900],
        stops: [0.6, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, paintBackground);

    // Barrido del radar (como el sector naranja)
    final sweepAngle = pi / 3; // 60°
    final rotationAngle = -pi / 2; // Que empiece hacia arriba
    final paintSector = Paint()
      ..color = Colors.deepOrange.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      rotationAngle,
      sweepAngle,
      true,
      paintSector,
    );

    // Dibujar puntos
    final paintPoint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    for (var point in points) {
      double angle = point['angle']! * pi / 180;
      double distance = point['distance']!;

      // Normalizar distancia al radio del radar (asumiendo máx. 100)
      double scaledDistance = (distance / 100.0) * radius;

      final dx = center.dx + scaledDistance * cos(angle - pi / 2);
      final dy = center.dy + scaledDistance * sin(angle - pi / 2);

      canvas.drawCircle(Offset(dx, dy), 4, paintPoint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
