// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeState {
  List<Offset> get previousActions => throw _privateConstructorUsedError;
  bool get closed => throw _privateConstructorUsedError;
  List<Offset> get coordinates => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {List<Offset> previousActions, bool closed, List<Offset> coordinates});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? previousActions = null,
    Object? closed = null,
    Object? coordinates = null,
  }) {
    return _then(_value.copyWith(
      previousActions: null == previousActions
          ? _value.previousActions
          : previousActions // ignore: cast_nullable_to_non_nullable
              as List<Offset>,
      closed: null == closed
          ? _value.closed
          : closed // ignore: cast_nullable_to_non_nullable
              as bool,
      coordinates: null == coordinates
          ? _value.coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<Offset>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
          _$HomeStateImpl value, $Res Function(_$HomeStateImpl) then) =
      __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Offset> previousActions, bool closed, List<Offset> coordinates});
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
      _$HomeStateImpl _value, $Res Function(_$HomeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? previousActions = null,
    Object? closed = null,
    Object? coordinates = null,
  }) {
    return _then(_$HomeStateImpl(
      previousActions: null == previousActions
          ? _value._previousActions
          : previousActions // ignore: cast_nullable_to_non_nullable
              as List<Offset>,
      closed: null == closed
          ? _value.closed
          : closed // ignore: cast_nullable_to_non_nullable
              as bool,
      coordinates: null == coordinates
          ? _value._coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<Offset>,
    ));
  }
}

/// @nodoc

class _$HomeStateImpl extends _HomeState {
  _$HomeStateImpl(
      {final List<Offset> previousActions = const [],
      this.closed = false,
      final List<Offset> coordinates = const []})
      : _previousActions = previousActions,
        _coordinates = coordinates,
        super._();

  final List<Offset> _previousActions;
  @override
  @JsonKey()
  List<Offset> get previousActions {
    if (_previousActions is EqualUnmodifiableListView) return _previousActions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_previousActions);
  }

  @override
  @JsonKey()
  final bool closed;
  final List<Offset> _coordinates;
  @override
  @JsonKey()
  List<Offset> get coordinates {
    if (_coordinates is EqualUnmodifiableListView) return _coordinates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coordinates);
  }

  @override
  String toString() {
    return 'HomeState(previousActions: $previousActions, closed: $closed, coordinates: $coordinates)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            const DeepCollectionEquality()
                .equals(other._previousActions, _previousActions) &&
            (identical(other.closed, closed) || other.closed == closed) &&
            const DeepCollectionEquality()
                .equals(other._coordinates, _coordinates));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_previousActions),
      closed,
      const DeepCollectionEquality().hash(_coordinates));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState extends HomeState {
  factory _HomeState(
      {final List<Offset> previousActions,
      final bool closed,
      final List<Offset> coordinates}) = _$HomeStateImpl;
  _HomeState._() : super._();

  @override
  List<Offset> get previousActions;
  @override
  bool get closed;
  @override
  List<Offset> get coordinates;
  @override
  @JsonKey(ignore: true)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
