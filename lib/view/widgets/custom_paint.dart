import 'package:flutter/material.dart';

class DrawShape extends StatelessWidget {
  final bool animated;
  final List<Offset> coordinates;
  final double strokeWidth;
  final bool closed;

  const DrawShape(
      {super.key,
      this.animated = false,
      this.strokeWidth = 10,
      required this.coordinates,
      required this.closed});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      key: key,
      painter: CustomRect(
        coordinates: coordinates,
        closed: closed,
        strokeWidth: strokeWidth,
        animated: animated,
      ),
    );
  }
}

class CustomRect extends CustomPainter {
  final bool closed;

  final bool animated;
  final double strokeWidth;
  final List<Offset> coordinates;
  CustomRect({
    required this.closed,
    required this.animated,
    required this.strokeWidth,
    required this.coordinates,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Path path = Path();

    if (coordinates.isNotEmpty) {
      path.moveTo(coordinates[0].dx, coordinates[0].dy);
    }

    for (var i = 0; i < coordinates.length; i++) {
      path.lineTo(coordinates[i].dx, coordinates[i].dy);
    }
    if (closed && coordinates.length > 2) {
      path.close();

      canvas.drawPath(
          path,
          paint
            ..color = Colors.white
            ..style = PaintingStyle.fill);
      canvas.drawLine(
          coordinates.first, coordinates.last, paint..color = Colors.black);
    }

    for (var i = 0; i < coordinates.length; i++) {
      if (i + 1 < coordinates.length) {
        canvas.drawLine(
            coordinates[i], coordinates[i + 1], paint..color = Colors.black);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => animated;
}
