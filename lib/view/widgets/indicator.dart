import 'package:flutter/material.dart';
import 'package:sobol_task/config/colors.dart';

class Indicator extends StatelessWidget {
  final bool closed;
  final void Function(DragUpdateDetails details) onDrag;
  final Offset? offset;
  const Indicator(
      {super.key,
      required this.closed,
      required this.onDrag,
      required this.offset});

  @override
  Widget build(BuildContext context) {
    return offset == null
        ? const SizedBox.shrink()
        : Positioned(
            top: offset!.dy - 7,
            left: offset!.dx - 7,
            child: GestureDetector(
              onPanUpdate: onDrag,
              child: Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: closed ? AppColors.grey : Colors.white,
                        width: closed ? 2 : 3),
                    color: closed ? Colors.white : Colors.blue,
                    shape: BoxShape.circle),
              ),
            ),
          );
  }
}
