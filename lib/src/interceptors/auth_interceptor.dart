import 'package:auth_token_service/auth_token_service.dart';
import 'package:flutter/material.dart';

import '../exceptions/http_4xx_exceptions.dart';
import '../exceptions/http_exception_base.dart';
import 'i_auth_interceptor.dart';

export '../exceptions/http_4xx_exceptions.dart';
export 'i_auth_interceptor.dart';

class AuthInterceptor extends IAuthInterceptor {
  AuthInterceptor({required this.onTokenExpired, required this.tokenService});

  final void Function() onTokenExpired;
  final IAuthTokenService tokenService;

  @override
  Future<void> onError(HttpException error) async {
    debugPrint('AuthInterceptor:onError');

    if (error is UnauthorizedHttpException) {
      onTokenExpired();
    }
  }

  @override
  Future<void> onRequest() async {
    debugPrint('AuthInterceptor:onRequest');

    final token = await tokenService.getAuthToken();

    if (token?.expired ?? false) {
      onTokenExpired();

      throw const UnauthorizedHttpException();
    }
  }
}
