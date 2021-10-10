// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'join_room_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$JoinRoomEventTearOff {
  const _$JoinRoomEventTearOff();

  _Started started() {
    return const _Started();
  }

  _RoomNameChanged roomNameChanged(String name) {
    return _RoomNameChanged(
      name,
    );
  }

  _UserNameChanged userNameChanged(String name) {
    return _UserNameChanged(
      name,
    );
  }

  _RoomPasswordChanged roomPasswordChanged(String pw) {
    return _RoomPasswordChanged(
      pw,
    );
  }

  _UserPasswordChanged userPasswordChanged(String pw) {
    return _UserPasswordChanged(
      pw,
    );
  }

  _JoinRequested joinRequested() {
    return const _JoinRequested();
  }
}

/// @nodoc
const $JoinRoomEvent = _$JoinRoomEventTearOff();

/// @nodoc
mixin _$JoinRoomEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String name) roomNameChanged,
    required TResult Function(String name) userNameChanged,
    required TResult Function(String pw) roomPasswordChanged,
    required TResult Function(String pw) userPasswordChanged,
    required TResult Function() joinRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name)? roomNameChanged,
    TResult Function(String name)? userNameChanged,
    TResult Function(String pw)? roomPasswordChanged,
    TResult Function(String pw)? userPasswordChanged,
    TResult Function()? joinRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name)? roomNameChanged,
    TResult Function(String name)? userNameChanged,
    TResult Function(String pw)? roomPasswordChanged,
    TResult Function(String pw)? userPasswordChanged,
    TResult Function()? joinRequested,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RoomNameChanged value) roomNameChanged,
    required TResult Function(_UserNameChanged value) userNameChanged,
    required TResult Function(_RoomPasswordChanged value) roomPasswordChanged,
    required TResult Function(_UserPasswordChanged value) userPasswordChanged,
    required TResult Function(_JoinRequested value) joinRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RoomNameChanged value)? roomNameChanged,
    TResult Function(_UserNameChanged value)? userNameChanged,
    TResult Function(_RoomPasswordChanged value)? roomPasswordChanged,
    TResult Function(_UserPasswordChanged value)? userPasswordChanged,
    TResult Function(_JoinRequested value)? joinRequested,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RoomNameChanged value)? roomNameChanged,
    TResult Function(_UserNameChanged value)? userNameChanged,
    TResult Function(_RoomPasswordChanged value)? roomPasswordChanged,
    TResult Function(_UserPasswordChanged value)? userPasswordChanged,
    TResult Function(_JoinRequested value)? joinRequested,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JoinRoomEventCopyWith<$Res> {
  factory $JoinRoomEventCopyWith(
          JoinRoomEvent value, $Res Function(JoinRoomEvent) then) =
      _$JoinRoomEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$JoinRoomEventCopyWithImpl<$Res>
    implements $JoinRoomEventCopyWith<$Res> {
  _$JoinRoomEventCopyWithImpl(this._value, this._then);

  final JoinRoomEvent _value;
  // ignore: unused_field
  final $Res Function(JoinRoomEvent) _then;
}

/// @nodoc
abstract class _$StartedCopyWith<$Res> {
  factory _$StartedCopyWith(_Started value, $Res Function(_Started) then) =
      __$StartedCopyWithImpl<$Res>;
}

/// @nodoc
class __$StartedCopyWithImpl<$Res> extends _$JoinRoomEventCopyWithImpl<$Res>
    implements _$StartedCopyWith<$Res> {
  __$StartedCopyWithImpl(_Started _value, $Res Function(_Started) _then)
      : super(_value, (v) => _then(v as _Started));

  @override
  _Started get _value => super._value as _Started;
}

/// @nodoc

class _$_Started implements _Started {
  const _$_Started();

  @override
  String toString() {
    return 'JoinRoomEvent.started()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Started);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String name) roomNameChanged,
    required TResult Function(String name) userNameChanged,
    required TResult Function(String pw) roomPasswordChanged,
    required TResult Function(String pw) userPasswordChanged,
    required TResult Function() joinRequested,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name)? roomNameChanged,
    TResult Function(String name)? userNameChanged,
    TResult Function(String pw)? roomPasswordChanged,
    TResult Function(String pw)? userPasswordChanged,
    TResult Function()? joinRequested,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name)? roomNameChanged,
    TResult Function(String name)? userNameChanged,
    TResult Function(String pw)? roomPasswordChanged,
    TResult Function(String pw)? userPasswordChanged,
    TResult Function()? joinRequested,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RoomNameChanged value) roomNameChanged,
    required TResult Function(_UserNameChanged value) userNameChanged,
    required TResult Function(_RoomPasswordChanged value) roomPasswordChanged,
    required TResult Function(_UserPasswordChanged value) userPasswordChanged,
    required TResult Function(_JoinRequested value) joinRequested,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RoomNameChanged value)? roomNameChanged,
    TResult Function(_UserNameChanged value)? userNameChanged,
    TResult Function(_RoomPasswordChanged value)? roomPasswordChanged,
    TResult Function(_UserPasswordChanged value)? userPasswordChanged,
    TResult Function(_JoinRequested value)? joinRequested,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RoomNameChanged value)? roomNameChanged,
    TResult Function(_UserNameChanged value)? userNameChanged,
    TResult Function(_RoomPasswordChanged value)? roomPasswordChanged,
    TResult Function(_UserPasswordChanged value)? userPasswordChanged,
    TResult Function(_JoinRequested value)? joinRequested,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements JoinRoomEvent {
  const factory _Started() = _$_Started;
}

/// @nodoc
abstract class _$RoomNameChangedCopyWith<$Res> {
  factory _$RoomNameChangedCopyWith(
          _RoomNameChanged value, $Res Function(_RoomNameChanged) then) =
      __$RoomNameChangedCopyWithImpl<$Res>;
  $Res call({String name});
}

/// @nodoc
class __$RoomNameChangedCopyWithImpl<$Res>
    extends _$JoinRoomEventCopyWithImpl<$Res>
    implements _$RoomNameChangedCopyWith<$Res> {
  __$RoomNameChangedCopyWithImpl(
      _RoomNameChanged _value, $Res Function(_RoomNameChanged) _then)
      : super(_value, (v) => _then(v as _RoomNameChanged));

  @override
  _RoomNameChanged get _value => super._value as _RoomNameChanged;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_RoomNameChanged(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_RoomNameChanged implements _RoomNameChanged {
  const _$_RoomNameChanged(this.name);

  @override
  final String name;

  @override
  String toString() {
    return 'JoinRoomEvent.roomNameChanged(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RoomNameChanged &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  _$RoomNameChangedCopyWith<_RoomNameChanged> get copyWith =>
      __$RoomNameChangedCopyWithImpl<_RoomNameChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String name) roomNameChanged,
    required TResult Function(String name) userNameChanged,
    required TResult Function(String pw) roomPasswordChanged,
    required TResult Function(String pw) userPasswordChanged,
    required TResult Function() joinRequested,
  }) {
    return roomNameChanged(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name)? roomNameChanged,
    TResult Function(String name)? userNameChanged,
    TResult Function(String pw)? roomPasswordChanged,
    TResult Function(String pw)? userPasswordChanged,
    TResult Function()? joinRequested,
  }) {
    return roomNameChanged?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name)? roomNameChanged,
    TResult Function(String name)? userNameChanged,
    TResult Function(String pw)? roomPasswordChanged,
    TResult Function(String pw)? userPasswordChanged,
    TResult Function()? joinRequested,
    required TResult orElse(),
  }) {
    if (roomNameChanged != null) {
      return roomNameChanged(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RoomNameChanged value) roomNameChanged,
    required TResult Function(_UserNameChanged value) userNameChanged,
    required TResult Function(_RoomPasswordChanged value) roomPasswordChanged,
    required TResult Function(_UserPasswordChanged value) userPasswordChanged,
    required TResult Function(_JoinRequested value) joinRequested,
  }) {
    return roomNameChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RoomNameChanged value)? roomNameChanged,
    TResult Function(_UserNameChanged value)? userNameChanged,
    TResult Function(_RoomPasswordChanged value)? roomPasswordChanged,
    TResult Function(_UserPasswordChanged value)? userPasswordChanged,
    TResult Function(_JoinRequested value)? joinRequested,
  }) {
    return roomNameChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RoomNameChanged value)? roomNameChanged,
    TResult Function(_UserNameChanged value)? userNameChanged,
    TResult Function(_RoomPasswordChanged value)? roomPasswordChanged,
    TResult Function(_UserPasswordChanged value)? userPasswordChanged,
    TResult Function(_JoinRequested value)? joinRequested,
    required TResult orElse(),
  }) {
    if (roomNameChanged != null) {
      return roomNameChanged(this);
    }
    return orElse();
  }
}

abstract class _RoomNameChanged implements JoinRoomEvent {
  const factory _RoomNameChanged(String name) = _$_RoomNameChanged;

  String get name;
  @JsonKey(ignore: true)
  _$RoomNameChangedCopyWith<_RoomNameChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$UserNameChangedCopyWith<$Res> {
  factory _$UserNameChangedCopyWith(
          _UserNameChanged value, $Res Function(_UserNameChanged) then) =
      __$UserNameChangedCopyWithImpl<$Res>;
  $Res call({String name});
}

/// @nodoc
class __$UserNameChangedCopyWithImpl<$Res>
    extends _$JoinRoomEventCopyWithImpl<$Res>
    implements _$UserNameChangedCopyWith<$Res> {
  __$UserNameChangedCopyWithImpl(
      _UserNameChanged _value, $Res Function(_UserNameChanged) _then)
      : super(_value, (v) => _then(v as _UserNameChanged));

  @override
  _UserNameChanged get _value => super._value as _UserNameChanged;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_UserNameChanged(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_UserNameChanged implements _UserNameChanged {
  const _$_UserNameChanged(this.name);

  @override
  final String name;

  @override
  String toString() {
    return 'JoinRoomEvent.userNameChanged(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserNameChanged &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  _$UserNameChangedCopyWith<_UserNameChanged> get copyWith =>
      __$UserNameChangedCopyWithImpl<_UserNameChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String name) roomNameChanged,
    required TResult Function(String name) userNameChanged,
    required TResult Function(String pw) roomPasswordChanged,
    required TResult Function(String pw) userPasswordChanged,
    required TResult Function() joinRequested,
  }) {
    return userNameChanged(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name)? roomNameChanged,
    TResult Function(String name)? userNameChanged,
    TResult Function(String pw)? roomPasswordChanged,
    TResult Function(String pw)? userPasswordChanged,
    TResult Function()? joinRequested,
  }) {
    return userNameChanged?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name)? roomNameChanged,
    TResult Function(String name)? userNameChanged,
    TResult Function(String pw)? roomPasswordChanged,
    TResult Function(String pw)? userPasswordChanged,
    TResult Function()? joinRequested,
    required TResult orElse(),
  }) {
    if (userNameChanged != null) {
      return userNameChanged(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RoomNameChanged value) roomNameChanged,
    required TResult Function(_UserNameChanged value) userNameChanged,
    required TResult Function(_RoomPasswordChanged value) roomPasswordChanged,
    required TResult Function(_UserPasswordChanged value) userPasswordChanged,
    required TResult Function(_JoinRequested value) joinRequested,
  }) {
    return userNameChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RoomNameChanged value)? roomNameChanged,
    TResult Function(_UserNameChanged value)? userNameChanged,
    TResult Function(_RoomPasswordChanged value)? roomPasswordChanged,
    TResult Function(_UserPasswordChanged value)? userPasswordChanged,
    TResult Function(_JoinRequested value)? joinRequested,
  }) {
    return userNameChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RoomNameChanged value)? roomNameChanged,
    TResult Function(_UserNameChanged value)? userNameChanged,
    TResult Function(_RoomPasswordChanged value)? roomPasswordChanged,
    TResult Function(_UserPasswordChanged value)? userPasswordChanged,
    TResult Function(_JoinRequested value)? joinRequested,
    required TResult orElse(),
  }) {
    if (userNameChanged != null) {
      return userNameChanged(this);
    }
    return orElse();
  }
}

abstract class _UserNameChanged implements JoinRoomEvent {
  const factory _UserNameChanged(String name) = _$_UserNameChanged;

  String get name;
  @JsonKey(ignore: true)
  _$UserNameChangedCopyWith<_UserNameChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$RoomPasswordChangedCopyWith<$Res> {
  factory _$RoomPasswordChangedCopyWith(_RoomPasswordChanged value,
          $Res Function(_RoomPasswordChanged) then) =
      __$RoomPasswordChangedCopyWithImpl<$Res>;
  $Res call({String pw});
}

/// @nodoc
class __$RoomPasswordChangedCopyWithImpl<$Res>
    extends _$JoinRoomEventCopyWithImpl<$Res>
    implements _$RoomPasswordChangedCopyWith<$Res> {
  __$RoomPasswordChangedCopyWithImpl(
      _RoomPasswordChanged _value, $Res Function(_RoomPasswordChanged) _then)
      : super(_value, (v) => _then(v as _RoomPasswordChanged));

  @override
  _RoomPasswordChanged get _value => super._value as _RoomPasswordChanged;

  @override
  $Res call({
    Object? pw = freezed,
  }) {
    return _then(_RoomPasswordChanged(
      pw == freezed
          ? _value.pw
          : pw // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_RoomPasswordChanged implements _RoomPasswordChanged {
  const _$_RoomPasswordChanged(this.pw);

  @override
  final String pw;

  @override
  String toString() {
    return 'JoinRoomEvent.roomPasswordChanged(pw: $pw)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RoomPasswordChanged &&
            (identical(other.pw, pw) || other.pw == pw));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pw);

  @JsonKey(ignore: true)
  @override
  _$RoomPasswordChangedCopyWith<_RoomPasswordChanged> get copyWith =>
      __$RoomPasswordChangedCopyWithImpl<_RoomPasswordChanged>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String name) roomNameChanged,
    required TResult Function(String name) userNameChanged,
    required TResult Function(String pw) roomPasswordChanged,
    required TResult Function(String pw) userPasswordChanged,
    required TResult Function() joinRequested,
  }) {
    return roomPasswordChanged(pw);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name)? roomNameChanged,
    TResult Function(String name)? userNameChanged,
    TResult Function(String pw)? roomPasswordChanged,
    TResult Function(String pw)? userPasswordChanged,
    TResult Function()? joinRequested,
  }) {
    return roomPasswordChanged?.call(pw);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name)? roomNameChanged,
    TResult Function(String name)? userNameChanged,
    TResult Function(String pw)? roomPasswordChanged,
    TResult Function(String pw)? userPasswordChanged,
    TResult Function()? joinRequested,
    required TResult orElse(),
  }) {
    if (roomPasswordChanged != null) {
      return roomPasswordChanged(pw);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RoomNameChanged value) roomNameChanged,
    required TResult Function(_UserNameChanged value) userNameChanged,
    required TResult Function(_RoomPasswordChanged value) roomPasswordChanged,
    required TResult Function(_UserPasswordChanged value) userPasswordChanged,
    required TResult Function(_JoinRequested value) joinRequested,
  }) {
    return roomPasswordChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RoomNameChanged value)? roomNameChanged,
    TResult Function(_UserNameChanged value)? userNameChanged,
    TResult Function(_RoomPasswordChanged value)? roomPasswordChanged,
    TResult Function(_UserPasswordChanged value)? userPasswordChanged,
    TResult Function(_JoinRequested value)? joinRequested,
  }) {
    return roomPasswordChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RoomNameChanged value)? roomNameChanged,
    TResult Function(_UserNameChanged value)? userNameChanged,
    TResult Function(_RoomPasswordChanged value)? roomPasswordChanged,
    TResult Function(_UserPasswordChanged value)? userPasswordChanged,
    TResult Function(_JoinRequested value)? joinRequested,
    required TResult orElse(),
  }) {
    if (roomPasswordChanged != null) {
      return roomPasswordChanged(this);
    }
    return orElse();
  }
}

abstract class _RoomPasswordChanged implements JoinRoomEvent {
  const factory _RoomPasswordChanged(String pw) = _$_RoomPasswordChanged;

  String get pw;
  @JsonKey(ignore: true)
  _$RoomPasswordChangedCopyWith<_RoomPasswordChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$UserPasswordChangedCopyWith<$Res> {
  factory _$UserPasswordChangedCopyWith(_UserPasswordChanged value,
          $Res Function(_UserPasswordChanged) then) =
      __$UserPasswordChangedCopyWithImpl<$Res>;
  $Res call({String pw});
}

/// @nodoc
class __$UserPasswordChangedCopyWithImpl<$Res>
    extends _$JoinRoomEventCopyWithImpl<$Res>
    implements _$UserPasswordChangedCopyWith<$Res> {
  __$UserPasswordChangedCopyWithImpl(
      _UserPasswordChanged _value, $Res Function(_UserPasswordChanged) _then)
      : super(_value, (v) => _then(v as _UserPasswordChanged));

  @override
  _UserPasswordChanged get _value => super._value as _UserPasswordChanged;

  @override
  $Res call({
    Object? pw = freezed,
  }) {
    return _then(_UserPasswordChanged(
      pw == freezed
          ? _value.pw
          : pw // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_UserPasswordChanged implements _UserPasswordChanged {
  const _$_UserPasswordChanged(this.pw);

  @override
  final String pw;

  @override
  String toString() {
    return 'JoinRoomEvent.userPasswordChanged(pw: $pw)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserPasswordChanged &&
            (identical(other.pw, pw) || other.pw == pw));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pw);

  @JsonKey(ignore: true)
  @override
  _$UserPasswordChangedCopyWith<_UserPasswordChanged> get copyWith =>
      __$UserPasswordChangedCopyWithImpl<_UserPasswordChanged>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String name) roomNameChanged,
    required TResult Function(String name) userNameChanged,
    required TResult Function(String pw) roomPasswordChanged,
    required TResult Function(String pw) userPasswordChanged,
    required TResult Function() joinRequested,
  }) {
    return userPasswordChanged(pw);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name)? roomNameChanged,
    TResult Function(String name)? userNameChanged,
    TResult Function(String pw)? roomPasswordChanged,
    TResult Function(String pw)? userPasswordChanged,
    TResult Function()? joinRequested,
  }) {
    return userPasswordChanged?.call(pw);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name)? roomNameChanged,
    TResult Function(String name)? userNameChanged,
    TResult Function(String pw)? roomPasswordChanged,
    TResult Function(String pw)? userPasswordChanged,
    TResult Function()? joinRequested,
    required TResult orElse(),
  }) {
    if (userPasswordChanged != null) {
      return userPasswordChanged(pw);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RoomNameChanged value) roomNameChanged,
    required TResult Function(_UserNameChanged value) userNameChanged,
    required TResult Function(_RoomPasswordChanged value) roomPasswordChanged,
    required TResult Function(_UserPasswordChanged value) userPasswordChanged,
    required TResult Function(_JoinRequested value) joinRequested,
  }) {
    return userPasswordChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RoomNameChanged value)? roomNameChanged,
    TResult Function(_UserNameChanged value)? userNameChanged,
    TResult Function(_RoomPasswordChanged value)? roomPasswordChanged,
    TResult Function(_UserPasswordChanged value)? userPasswordChanged,
    TResult Function(_JoinRequested value)? joinRequested,
  }) {
    return userPasswordChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RoomNameChanged value)? roomNameChanged,
    TResult Function(_UserNameChanged value)? userNameChanged,
    TResult Function(_RoomPasswordChanged value)? roomPasswordChanged,
    TResult Function(_UserPasswordChanged value)? userPasswordChanged,
    TResult Function(_JoinRequested value)? joinRequested,
    required TResult orElse(),
  }) {
    if (userPasswordChanged != null) {
      return userPasswordChanged(this);
    }
    return orElse();
  }
}

abstract class _UserPasswordChanged implements JoinRoomEvent {
  const factory _UserPasswordChanged(String pw) = _$_UserPasswordChanged;

  String get pw;
  @JsonKey(ignore: true)
  _$UserPasswordChangedCopyWith<_UserPasswordChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$JoinRequestedCopyWith<$Res> {
  factory _$JoinRequestedCopyWith(
          _JoinRequested value, $Res Function(_JoinRequested) then) =
      __$JoinRequestedCopyWithImpl<$Res>;
}

/// @nodoc
class __$JoinRequestedCopyWithImpl<$Res>
    extends _$JoinRoomEventCopyWithImpl<$Res>
    implements _$JoinRequestedCopyWith<$Res> {
  __$JoinRequestedCopyWithImpl(
      _JoinRequested _value, $Res Function(_JoinRequested) _then)
      : super(_value, (v) => _then(v as _JoinRequested));

  @override
  _JoinRequested get _value => super._value as _JoinRequested;
}

/// @nodoc

class _$_JoinRequested implements _JoinRequested {
  const _$_JoinRequested();

  @override
  String toString() {
    return 'JoinRoomEvent.joinRequested()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _JoinRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String name) roomNameChanged,
    required TResult Function(String name) userNameChanged,
    required TResult Function(String pw) roomPasswordChanged,
    required TResult Function(String pw) userPasswordChanged,
    required TResult Function() joinRequested,
  }) {
    return joinRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name)? roomNameChanged,
    TResult Function(String name)? userNameChanged,
    TResult Function(String pw)? roomPasswordChanged,
    TResult Function(String pw)? userPasswordChanged,
    TResult Function()? joinRequested,
  }) {
    return joinRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String name)? roomNameChanged,
    TResult Function(String name)? userNameChanged,
    TResult Function(String pw)? roomPasswordChanged,
    TResult Function(String pw)? userPasswordChanged,
    TResult Function()? joinRequested,
    required TResult orElse(),
  }) {
    if (joinRequested != null) {
      return joinRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RoomNameChanged value) roomNameChanged,
    required TResult Function(_UserNameChanged value) userNameChanged,
    required TResult Function(_RoomPasswordChanged value) roomPasswordChanged,
    required TResult Function(_UserPasswordChanged value) userPasswordChanged,
    required TResult Function(_JoinRequested value) joinRequested,
  }) {
    return joinRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RoomNameChanged value)? roomNameChanged,
    TResult Function(_UserNameChanged value)? userNameChanged,
    TResult Function(_RoomPasswordChanged value)? roomPasswordChanged,
    TResult Function(_UserPasswordChanged value)? userPasswordChanged,
    TResult Function(_JoinRequested value)? joinRequested,
  }) {
    return joinRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RoomNameChanged value)? roomNameChanged,
    TResult Function(_UserNameChanged value)? userNameChanged,
    TResult Function(_RoomPasswordChanged value)? roomPasswordChanged,
    TResult Function(_UserPasswordChanged value)? userPasswordChanged,
    TResult Function(_JoinRequested value)? joinRequested,
    required TResult orElse(),
  }) {
    if (joinRequested != null) {
      return joinRequested(this);
    }
    return orElse();
  }
}

abstract class _JoinRequested implements JoinRoomEvent {
  const factory _JoinRequested() = _$_JoinRequested;
}

/// @nodoc
class _$JoinRoomStateTearOff {
  const _$JoinRoomStateTearOff();

  _JoinRoomState call(
      {required String roomName,
      required String userName,
      required String roomPassword,
      required String userPassword,
      required bool joiningRoom,
      String? roomNameError,
      String? userNameError,
      String? roomPasswordError,
      String? userPasswordError}) {
    return _JoinRoomState(
      roomName: roomName,
      userName: userName,
      roomPassword: roomPassword,
      userPassword: userPassword,
      joiningRoom: joiningRoom,
      roomNameError: roomNameError,
      userNameError: userNameError,
      roomPasswordError: roomPasswordError,
      userPasswordError: userPasswordError,
    );
  }
}

/// @nodoc
const $JoinRoomState = _$JoinRoomStateTearOff();

/// @nodoc
mixin _$JoinRoomState {
  String get roomName => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get roomPassword => throw _privateConstructorUsedError;
  String get userPassword => throw _privateConstructorUsedError;
  bool get joiningRoom => throw _privateConstructorUsedError;
  String? get roomNameError => throw _privateConstructorUsedError;
  String? get userNameError => throw _privateConstructorUsedError;
  String? get roomPasswordError => throw _privateConstructorUsedError;
  String? get userPasswordError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $JoinRoomStateCopyWith<JoinRoomState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JoinRoomStateCopyWith<$Res> {
  factory $JoinRoomStateCopyWith(
          JoinRoomState value, $Res Function(JoinRoomState) then) =
      _$JoinRoomStateCopyWithImpl<$Res>;
  $Res call(
      {String roomName,
      String userName,
      String roomPassword,
      String userPassword,
      bool joiningRoom,
      String? roomNameError,
      String? userNameError,
      String? roomPasswordError,
      String? userPasswordError});
}

/// @nodoc
class _$JoinRoomStateCopyWithImpl<$Res>
    implements $JoinRoomStateCopyWith<$Res> {
  _$JoinRoomStateCopyWithImpl(this._value, this._then);

  final JoinRoomState _value;
  // ignore: unused_field
  final $Res Function(JoinRoomState) _then;

  @override
  $Res call({
    Object? roomName = freezed,
    Object? userName = freezed,
    Object? roomPassword = freezed,
    Object? userPassword = freezed,
    Object? joiningRoom = freezed,
    Object? roomNameError = freezed,
    Object? userNameError = freezed,
    Object? roomPasswordError = freezed,
    Object? userPasswordError = freezed,
  }) {
    return _then(_value.copyWith(
      roomName: roomName == freezed
          ? _value.roomName
          : roomName // ignore: cast_nullable_to_non_nullable
              as String,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      roomPassword: roomPassword == freezed
          ? _value.roomPassword
          : roomPassword // ignore: cast_nullable_to_non_nullable
              as String,
      userPassword: userPassword == freezed
          ? _value.userPassword
          : userPassword // ignore: cast_nullable_to_non_nullable
              as String,
      joiningRoom: joiningRoom == freezed
          ? _value.joiningRoom
          : joiningRoom // ignore: cast_nullable_to_non_nullable
              as bool,
      roomNameError: roomNameError == freezed
          ? _value.roomNameError
          : roomNameError // ignore: cast_nullable_to_non_nullable
              as String?,
      userNameError: userNameError == freezed
          ? _value.userNameError
          : userNameError // ignore: cast_nullable_to_non_nullable
              as String?,
      roomPasswordError: roomPasswordError == freezed
          ? _value.roomPasswordError
          : roomPasswordError // ignore: cast_nullable_to_non_nullable
              as String?,
      userPasswordError: userPasswordError == freezed
          ? _value.userPasswordError
          : userPasswordError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$JoinRoomStateCopyWith<$Res>
    implements $JoinRoomStateCopyWith<$Res> {
  factory _$JoinRoomStateCopyWith(
          _JoinRoomState value, $Res Function(_JoinRoomState) then) =
      __$JoinRoomStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String roomName,
      String userName,
      String roomPassword,
      String userPassword,
      bool joiningRoom,
      String? roomNameError,
      String? userNameError,
      String? roomPasswordError,
      String? userPasswordError});
}

/// @nodoc
class __$JoinRoomStateCopyWithImpl<$Res>
    extends _$JoinRoomStateCopyWithImpl<$Res>
    implements _$JoinRoomStateCopyWith<$Res> {
  __$JoinRoomStateCopyWithImpl(
      _JoinRoomState _value, $Res Function(_JoinRoomState) _then)
      : super(_value, (v) => _then(v as _JoinRoomState));

  @override
  _JoinRoomState get _value => super._value as _JoinRoomState;

  @override
  $Res call({
    Object? roomName = freezed,
    Object? userName = freezed,
    Object? roomPassword = freezed,
    Object? userPassword = freezed,
    Object? joiningRoom = freezed,
    Object? roomNameError = freezed,
    Object? userNameError = freezed,
    Object? roomPasswordError = freezed,
    Object? userPasswordError = freezed,
  }) {
    return _then(_JoinRoomState(
      roomName: roomName == freezed
          ? _value.roomName
          : roomName // ignore: cast_nullable_to_non_nullable
              as String,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      roomPassword: roomPassword == freezed
          ? _value.roomPassword
          : roomPassword // ignore: cast_nullable_to_non_nullable
              as String,
      userPassword: userPassword == freezed
          ? _value.userPassword
          : userPassword // ignore: cast_nullable_to_non_nullable
              as String,
      joiningRoom: joiningRoom == freezed
          ? _value.joiningRoom
          : joiningRoom // ignore: cast_nullable_to_non_nullable
              as bool,
      roomNameError: roomNameError == freezed
          ? _value.roomNameError
          : roomNameError // ignore: cast_nullable_to_non_nullable
              as String?,
      userNameError: userNameError == freezed
          ? _value.userNameError
          : userNameError // ignore: cast_nullable_to_non_nullable
              as String?,
      roomPasswordError: roomPasswordError == freezed
          ? _value.roomPasswordError
          : roomPasswordError // ignore: cast_nullable_to_non_nullable
              as String?,
      userPasswordError: userPasswordError == freezed
          ? _value.userPasswordError
          : userPasswordError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_JoinRoomState extends _JoinRoomState {
  const _$_JoinRoomState(
      {required this.roomName,
      required this.userName,
      required this.roomPassword,
      required this.userPassword,
      required this.joiningRoom,
      this.roomNameError,
      this.userNameError,
      this.roomPasswordError,
      this.userPasswordError})
      : super._();

  @override
  final String roomName;
  @override
  final String userName;
  @override
  final String roomPassword;
  @override
  final String userPassword;
  @override
  final bool joiningRoom;
  @override
  final String? roomNameError;
  @override
  final String? userNameError;
  @override
  final String? roomPasswordError;
  @override
  final String? userPasswordError;

  @override
  String toString() {
    return 'JoinRoomState(roomName: $roomName, userName: $userName, roomPassword: $roomPassword, userPassword: $userPassword, joiningRoom: $joiningRoom, roomNameError: $roomNameError, userNameError: $userNameError, roomPasswordError: $roomPasswordError, userPasswordError: $userPasswordError)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _JoinRoomState &&
            (identical(other.roomName, roomName) ||
                other.roomName == roomName) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.roomPassword, roomPassword) ||
                other.roomPassword == roomPassword) &&
            (identical(other.userPassword, userPassword) ||
                other.userPassword == userPassword) &&
            (identical(other.joiningRoom, joiningRoom) ||
                other.joiningRoom == joiningRoom) &&
            (identical(other.roomNameError, roomNameError) ||
                other.roomNameError == roomNameError) &&
            (identical(other.userNameError, userNameError) ||
                other.userNameError == userNameError) &&
            (identical(other.roomPasswordError, roomPasswordError) ||
                other.roomPasswordError == roomPasswordError) &&
            (identical(other.userPasswordError, userPasswordError) ||
                other.userPasswordError == userPasswordError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      roomName,
      userName,
      roomPassword,
      userPassword,
      joiningRoom,
      roomNameError,
      userNameError,
      roomPasswordError,
      userPasswordError);

  @JsonKey(ignore: true)
  @override
  _$JoinRoomStateCopyWith<_JoinRoomState> get copyWith =>
      __$JoinRoomStateCopyWithImpl<_JoinRoomState>(this, _$identity);
}

abstract class _JoinRoomState extends JoinRoomState {
  const factory _JoinRoomState(
      {required String roomName,
      required String userName,
      required String roomPassword,
      required String userPassword,
      required bool joiningRoom,
      String? roomNameError,
      String? userNameError,
      String? roomPasswordError,
      String? userPasswordError}) = _$_JoinRoomState;
  const _JoinRoomState._() : super._();

  @override
  String get roomName;
  @override
  String get userName;
  @override
  String get roomPassword;
  @override
  String get userPassword;
  @override
  bool get joiningRoom;
  @override
  String? get roomNameError;
  @override
  String? get userNameError;
  @override
  String? get roomPasswordError;
  @override
  String? get userPasswordError;
  @override
  @JsonKey(ignore: true)
  _$JoinRoomStateCopyWith<_JoinRoomState> get copyWith =>
      throw _privateConstructorUsedError;
}
