// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:graphql/client.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

import 'application/join_room/join_room_bloc.dart' as _i4;
import 'infrastructure/inject.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final injectableModule = _$InjectableModule();
  gh.lazySingleton<_i3.GraphQLClient>(() => injectableModule.gql);
  gh.factory<_i4.JoinRoomBloc>(
      () => _i4.JoinRoomBloc(get<_i3.GraphQLClient>()));
  return get;
}

class _$InjectableModule extends _i5.InjectableModule {}
