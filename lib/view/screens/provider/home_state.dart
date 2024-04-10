import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const HomeState._();

  factory HomeState({
    @Default(null) int? dragTarget,
    @Default([]) List<Offset> previousActions,
    @Default(false) bool closed,
    @Default([]) List<Offset> coordinates,
  }) = _HomeState;
}
