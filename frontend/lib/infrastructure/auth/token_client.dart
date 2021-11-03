import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio_http/dio_http.dart';
import 'package:secret_santa_list/infrastructure/auth/token_pair.dart';

part 'token_client.g.dart';

@RestApi()
abstract class TokenClient {
  factory TokenClient(Dio dio, {String baseUrl}) = _TokenClient;

  @POST("/auth")
  Future<TokenPairResponse> authenticate(@Header("Authorization") String auth);

  @POST("/deauth")
  Future<void> deauthenticate();
}
