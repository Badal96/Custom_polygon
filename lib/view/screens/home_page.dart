import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sobol_task/config/assets.dart';
import 'package:sobol_task/config/colors.dart';
import 'package:sobol_task/view/screens/provider/home_provider.dart';
import 'package:sobol_task/view/widgets/custom_paint.dart';
import 'package:sobol_task/view/widgets/indicator.dart';
import 'package:sobol_task/view/widgets/line_length.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 14,
      ),
      body: Stack(
        children: [
          GestureDetector(
            onPanStart: (details) {
              ref.read(homeProvider.notifier).addOffset(details.localPosition);
            },
            onPanUpdate: (details) {
              if (homeState.closed) {
                return;
              }
              ref.read(homeProvider.notifier).changeOffset(
                  details.localPosition, homeState.coordinates.length - 1);
            },
            onPanEnd: (details) {
              ref.read(homeProvider.notifier).hideDragTarget();
            },
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Assets.background), fit: BoxFit.cover)),
              height: height,
              width: width,
              child: DrawShape(
                closed: homeState.closed,
                animated: true,
                coordinates: homeState.coordinates,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: homeState.closed
                              ? null
                              : ref.read(homeProvider.notifier).revertAction,
                          icon: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                homeState.closed
                                    ? AppColors.lightgrey
                                    : AppColors.grey,
                                BlendMode.srcIn),
                            child: SvgPicture.asset(Assets.backIcon),
                          ),
                        ),
                        Container(
                          height: 15,
                          width: 1,
                          color: AppColors.grey,
                        ),
                        IconButton(
                          onPressed: homeState.closed
                              ? null
                              : ref.read(homeProvider.notifier).forwardAction,
                          icon: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                homeState.closed
                                    ? AppColors.lightgrey
                                    : AppColors.grey,
                                BlendMode.srcIn),
                            child: SvgPicture.asset(Assets.forwardIcon),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 46,
                    width: 46,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Center(
                      child: IconButton(
                          onPressed: () {
                            ref.read(homeProvider.notifier).toggleConnectRect();
                          },
                          icon: const Icon(
                            Icons.numbers,
                            color: AppColors.grey,
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
          ...homeState.coordinates.map(
            (e) => Indicator(
              topPadding:
                  MediaQuery.of(context).padding.top - 14, // 14 is appBar size
              index: homeState.coordinates.indexOf(e),
            ),
          ),
          if (homeState.coordinates.length > 2 && homeState.closed)
            ...ref.read(homeProvider.notifier).coordinatesLength().map((e) =>
                LineLength(
                    length: e['mainVectorLength'],
                    rotation: e['angle'],
                    position: e['position']))
        ],
      ),
    );
  }
}
