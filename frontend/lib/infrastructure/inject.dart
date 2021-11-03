import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';
import 'package:secret_santa_list/infrastructure/auth/token_store.dart';

@module
abstract class InjectableModule {
  @injectable
  Future<GraphQLClient> gql() async => GraphQLClient(
        link: HttpLink(
          "http://localhost:8080/v1/graphql",
          defaultHeaders: {
            HttpHeaders.authorizationHeader: "Bearer " +
                (await GetIt.I<TokenStore>().get(TokenStore.keyAccess))
          },
        ),
        cache: GetIt.I<GraphQLCache>(),
      );

  @lazySingleton
  GraphQLCache get gqlCache => GraphQLCache();

  @lazySingleton
  Dio get dio => Dio();
}
