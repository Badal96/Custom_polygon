import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sobol_task/view/screens/provider/home_state.dart';
import 'dart:math';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>(
    (ref) => HomeNotifier(HomeState()));

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier(super.state);

//    bool doSegmentsIntersect(Offset p1, Offset p2, Offset q1, Offset q2) {
//   int o1 = orientation(p1, p2, q1);
//   int o2 = orientation(p1, p2, q2);
//   int o3 = orientation(q1, q2, p1);
//   int o4 = orientation(q1, q2, p2);

//   if (o1 != o2 && o3 != o4) return true;

//   if (o1 == 0 && onSegment(p1, q1, p2)) return true;
//   if (o2 == 0 && onSegment(p1, q2, p2)) return true;
//   if (o3 == 0 && onSegment(q1, p1, q2)) return true;
//   if (o4 == 0 && onSegment(q1, p2, q2)) return true;

//   return false;
// }

// int orientation(Offset p, Offset q, Offset r) {
//   double val = (q.dy - p.dy) * (r.dx - q.dx) - (q.dx - p.dx) * (r.dy - q.dy);
//   if (val.abs() < 1e-9) return 0;
//   return (val > 0) ? 1 : 2;
// }

// bool onSegment(Offset p, Offset q, Offset r) {
//   if (q.dx <= max(p.dx, r.dx) && q.dx >= min(p.dx, r.dx) &&
//       q.dy <= max(p.dy, r.dy) && q.dy >= min(p.dy, r.dy)) {
//     return true;
//   }
//   return false;
// }

// bool doAnySegmentsIntersect(List<Offset> points) {
//   int n = points.length;
//   for (int i = 0; i < n - 1; i++) {
//     for (int j = i + 1; j < n; j++) {
//       if (j == n - 1 && i == 0) continue;
//       if (doSegmentsIntersect(points[i], points[(i + 1) % n], points[j], points[(j + 1) % n])) {
//         return true;
//       }
//     }
//   }
//   return false;
// }

  List<Map<String, dynamic>> coordinatesLength() {
    List<Map<String, dynamic>> res = [];
    for (int i = 0; i < state.coordinates.length - 1; i++) {
      res.add(calcVector(state.coordinates[i], state.coordinates[i + 1]));
    }
    res.add(calcVector(state.coordinates.last, state.coordinates.first));

    return res;
  }

  Map<String, dynamic> calcVector(Offset offset1, Offset offset2) {
    double dx = offset2.dx - offset1.dx;
    double dy = offset2.dy - offset1.dy;
    double padding = 20;

    double mainVectorLength = sqrt(dx * dx + dy * dy);

    double angle = atan2(dy, dx);
    angle = angle * 180 / pi;

    double offsetX = (offset1.dx + offset2.dx) / 2;
    double offsetY = (offset1.dy + offset2.dy) / 2;
    if (angle.abs() <= 45) {
      offsetY -= padding * cos(angle * pi / 180);
      offsetX += padding * sin(angle * pi / 180);
    } else if (angle.abs() > 135) {
      offsetY -= padding * cos(angle * pi / 180);
      offsetX += padding * sin(angle * pi / 180);
    } else if (angle.abs() > 45 && angle.abs() <= 90) {
      offsetX += padding * sin(angle * pi / 180);
      offsetY -= padding * cos(angle * pi / 180);
    } else if (angle.abs() > 90 && angle.abs() <= 135) {
      offsetX += padding * sin(angle * pi / 180);
      offsetY -= padding * cos(angle * pi / 180);
    }
    Offset position = Offset(offsetX, offsetY);

    return {
      'mainVectorLength': mainVectorLength,
      'angle': angle,
      'position': position,
    };
  }

  void setDragTarget(int index) {
    state = state.copyWith(dragTarget: index);
  }

  void hideDragTarget() {
    state = state.copyWith(dragTarget: null);
  }

  void toggleConnectRect() {
    if (state.closed == false) {
      if (state.coordinates.length > 2) {
        state = state.copyWith(closed: true);
      }
    } else {
      state = state.copyWith(closed: false);
    }
  }

  void changeOffset(Offset offset, int index) {
    if (state.coordinates.length == 1) {
      addOffset(offset);
    }

    state = state.copyWith(dragTarget: index);

    List<Offset> changedList = List.from(state.coordinates);
    changedList[index] = offset;
    state = state.copyWith(coordinates: changedList);
  }

  void addOffset(Offset offset) {
    if (state.closed) {
      return;
    }

    state = state.copyWith(
        previousActions: [],
        coordinates: List.from([...state.coordinates, offset]));

    state = state.copyWith(
        dragTarget: state.coordinates.length - 1,
        coordinates: List.from(state.coordinates));
  }

  void forwardAction() {
    if (state.previousActions.isEmpty) {
      return;
    }
    List<Offset> changedList = List.from(state.previousActions);
    changedList.removeLast();
    state = state.copyWith(
        coordinates: [...state.coordinates, state.previousActions.last],
        previousActions: changedList);
  }

  void revertAction() {
    if (state.coordinates.isEmpty) {
      return;
    }
    List<Offset> changedList = List.from(state.coordinates);
    changedList.removeLast();
    state = state.copyWith(
      coordinates: changedList,
      previousActions: [...state.previousActions, state.coordinates.last],
    );
  }
}
