import 'dart:io';

import 'package:dio/dio.dart';

class AuthTokenInterceptor extends Interceptor {
  AuthTokenInterceptor({
    required this.authBaseUrl,
    this.authorization,
  }) : super();

  final String authBaseUrl;
  String? authorization;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (authBaseUrl == options.baseUrl) {
      options.headers
          .putIfAbsent(HttpHeaders.authorizationHeader, () => authorization);
    }
    handler.next(options);
  }
}
