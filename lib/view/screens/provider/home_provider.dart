import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sobol_task/view/screens/provider/home_state.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>(
    (ref) => HomeNotifier(HomeState()));

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier(super.state);

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

    state = state.copyWith(coordinates: List.from(state.coordinates));
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
