import 'dart:math';

import 'package:flutter/material.dart';
import 'package:custom_polygon/config/colors.dart';

class LineLength extends StatelessWidget {
  final double length;
  final double rotation;
  final Offset position;
  const LineLength(
      {super.key,
      required this.length,
      required this.rotation,
      required this.position});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: position.dy - 10,
      left: position.dx - 25,
      child: Transform.rotate(
        angle: rotation * (pi / 180),
        child: Text(
          length.toStringAsFixed(2),
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.lightBlue,
              letterSpacing: 0.07),
        ),
      ),
    );
  }
}
