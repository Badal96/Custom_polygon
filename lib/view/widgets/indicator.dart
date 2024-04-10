import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sobol_task/config/assets.dart';
import 'package:sobol_task/config/colors.dart';
import 'package:sobol_task/view/screens/provider/home_provider.dart';

class Indicator extends ConsumerWidget {
  final int index;
  final double topPadding;
  const Indicator({
    super.key,
    required this.index,
    required this.topPadding,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double indicatorSize = 50;
    double circleSize = 15;

    final homeState = ref.watch(homeProvider);

    bool isDragTarget = homeState.dragTarget == index;
    double widgetAlignment = isDragTarget ? indicatorSize / 2 : circleSize / 2;
    return Positioned(
      top: homeState.coordinates[index].dy - widgetAlignment,
      left: homeState.coordinates[index].dx - widgetAlignment,
      child: GestureDetector(
        onPanUpdate: (details) {
          if (!homeState.closed) {
            return;
          }
          ref.read(homeProvider.notifier).changeOffset(
              Offset(details.globalPosition.dx,
                  details.globalPosition.dy - indicatorSize / 2 - topPadding),
              index);
        },
        onPanEnd: (details) {
          ref.read(homeProvider.notifier).hideDragTarget();
        },
        child: isDragTarget
            ? SvgPicture.asset(
                Assets.indicatorArrow,
                height: indicatorSize,
              )
            : Container(
                height: circleSize,
                width: circleSize,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: homeState.closed ? AppColors.grey : Colors.white,
                        width: homeState.closed ? 2 : 3),
                    color:
                        homeState.closed ? Colors.white : AppColors.lightBlue,
                    shape: BoxShape.circle),
              ),
      ),
    );
  }
}
