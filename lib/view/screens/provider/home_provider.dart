import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sobol_task/view/screens/provider/home_state.dart';
import 'dart:math';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>(
    (ref) => HomeNotifier(HomeState()));

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier(super.state);

  double determinant(Offset p1, Offset p2) {
    return p1.dx * p2.dy - p2.dx * p1.dy;
  }

  bool doLinesIntersect(
      Offset line1Start, Offset line1End, Offset line2Start, Offset line2End) {
    double det1 = determinant(line2Start - line1Start, line1End - line1Start);
    double det2 = determinant(line2End - line1Start, line1End - line1Start);
    double det3 = determinant(line1Start - line2Start, line2End - line2Start);
    double det4 = determinant(line1End - line2Start, line2End - line2Start);

    if ((det1 * det2 < 0) && (det3 * det4 < 0)) {
      return true;
    }

    return false;
  }

  bool doAnyLineIntersect(List<Offset> coordinates) {
    for (var i = 0; i < coordinates.length; i++) {
      for (var j = i + 1; j < coordinates.length - 1; j++) {
        if (doLinesIntersect(coordinates[i], coordinates[i + 1], coordinates[j],
            coordinates[j + 1])) {
          return false;
        }
      }
    }
    for (var i = 0; i < coordinates.length - 1; i++) {
      if (doLinesIntersect(coordinates.last, coordinates.first, coordinates[i],
          coordinates[i + 1])) {
        return false;
      }
    }
    return true;
  }

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
    if (doAnyLineIntersect(changedList)) {
      state = state.copyWith(coordinates: changedList);
    } else {
      return;
    }
  }

  void addOffset(Offset offset) {
    if (state.closed) {
      return;
    }
    if (doAnyLineIntersect([...state.coordinates, offset])) {
      state = state.copyWith(
          previousActions: [],
          coordinates: List.from([...state.coordinates, offset]));
    }
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
