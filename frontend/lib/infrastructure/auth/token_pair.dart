import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_pair.g.dart';
part 'token_pair.freezed.dart';

@freezed
@immutable
class TokenPairResponse with _$TokenPairResponse {
  const factory TokenPairResponse({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') required String refreshToken,
  }) = _TokenPairResponse;

  factory TokenPairResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenPairResponseFromJson(json);
}
