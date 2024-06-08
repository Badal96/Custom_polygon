import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:custom_polygon/config/assets.dart';
import 'package:custom_polygon/config/colors.dart';
import 'package:custom_polygon/view/screens/provider/home_provider.dart';
import 'package:custom_polygon/view/widgets/custom_paint.dart';
import 'package:custom_polygon/view/widgets/indicator.dart';
import 'package:custom_polygon/view/widgets/line_length.dart';

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
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onPanStart: (details) {
              ref.read(homeProvider.notifier).addOffset(details.localPosition);
            },
            onPanUpdate: (details) {
              if (homeState.closed || (homeState.coordinates.isEmpty)) {
                return;
              }

              ref.read(homeProvider.notifier).changeOffset(
                  details.localPosition, homeState.coordinates.length - 1);
            },
            onPanEnd: (details) {
              print(homeState.coordinates.last);
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

// class CustomPanGestureRecognizer extends PanGestureRecognizer {
//   @override
//   void addAllowedPointer(PointerDownEvent event) {
//     super.addAllowedPointer(event);
//     resolve(GestureDisposition.accepted);
//     //get the GestureRecognizer win immediately after invoking onPanDown
//   }
// }

// RawGestureDetector CustomPanGestureDetector(
//     {GestureDragDownCallback? onPanDown,
//     GestureDragStartCallback? onPanStart,
//     GestureDragUpdateCallback? onPanUpdate,
//     GestureDragEndCallback? onPanEnd,
//     GestureDragCancelCallback? onPanCancel,
//     Widget? child}) {
//   return RawGestureDetector(
//     gestures: {
//       CustomPanGestureRecognizer:
//           GestureRecognizerFactoryWithHandlers<CustomPanGestureRecognizer>(
//               () => CustomPanGestureRecognizer(), (detector) {
//         detector
//           ..onDown = onPanDown
//           ..onStart = onPanStart
//           ..onUpdate = onPanUpdate
//           ..onEnd = onPanEnd
//           ..onCancel = onPanCancel;
//       })
//     },
//     child: child,
//   );
// }

// class PanGestureDetector extends StatelessWidget {
//   final Widget? child;
//   final HitTestBehavior? behavior;
//   final bool excludeFromSemantics;
//   final SemanticsGestureDelegate? semantics;
//   final double? touchSlop;
//   final GestureDragCancelCallback? onPanCancel;
//   final GestureDragDownCallback? onPanDown;
//   final GestureDragEndCallback? onPanEnd;
//   final GestureDragStartCallback? onPanStart;
//   final GestureDragUpdateCallback? onPanUpdate;

//   const PanGestureDetector({
//     super.key,
//     this.child,
//     this.behavior,
//     this.excludeFromSemantics = false,
//     this.semantics,
//     this.touchSlop,
//     this.onPanCancel,
//     this.onPanDown,
//     this.onPanEnd,
//     this.onPanStart,
//     this.onPanUpdate,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return RawGestureDetector(
//       behavior: behavior,
//       excludeFromSemantics: excludeFromSemantics,
//       semantics: semantics,
//       gestures: {
//         PanGestureRecognizer:
//             GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>(
//           () => PanGestureRecognizer()
//             ..gestureSettings = DeviceGestureSettings(touchSlop: touchSlop),
//           (PanGestureRecognizer detector) {
//             detector
//               ..onDown = onPanDown
//               ..onStart = onPanStart
//               ..onUpdate = onPanUpdate
//               ..onEnd = onPanEnd
//               ..onCancel = onPanCancel;
//           },
//         )
//       },
//       child: child,
//     );
//   }
// }
