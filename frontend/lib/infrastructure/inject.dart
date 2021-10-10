import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';

@module
abstract class InjectableModule {
  @lazySingleton
  GraphQLClient get gql => GraphQLClient(
        link: HttpLink("http://localhost:8080/v1/graphql"),
        cache: GraphQLCache(),
      );
}
