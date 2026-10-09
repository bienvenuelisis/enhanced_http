import 'package:auth_token_service/auth_token_service.dart';
import 'package:flutter/material.dart';

import '../exceptions/http_4xx_exceptions.dart';
import '../exceptions/http_exception_base.dart';
import 'i_auth_interceptor.dart';

export '../exceptions/http_4xx_exceptions.dart';
export 'i_auth_interceptor.dart';

class AuthInterceptor extends IAuthInterceptor {
  AuthInterceptor({
    required this.onTokenExpired,
    required this.tokenService,
    this.onRefreshToken,
  });

  final void Function() onTokenExpired;
  final IAuthTokenService tokenService;

  /// Exchanges a refresh token for a new token pair, or returns `null` when
  /// the session can no longer be refreshed.
  ///
  /// When not provided, an expired token ends the session immediately.
  final Future<AuthTokenData?> Function(String refreshToken)? onRefreshToken;

  /// Refresh in flight, shared so concurrent requests refresh only once.
  Future<AuthTokenData?>? _refreshing;

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

    if (token == null || !token.expired) {
      return;
    }

    final refresh = onRefreshToken;
    final refreshToken = token.refreshToken;

    if (refresh == null || refreshToken == null || refreshToken.isEmpty) {
      _onTokenExpired();
    }

    final refreshing = _refreshing ??= _refresh(refresh, refreshToken);

    AuthTokenData? refreshedToken;

    try {
      refreshedToken = await refreshing;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (identical(_refreshing, refreshing)) {
        _refreshing = null;
      }
    }

    if (refreshedToken == null) {
      _onTokenExpired();
    }
  }

  Future<AuthTokenData?> _refresh(
    Future<AuthTokenData?> Function(String refreshToken) refresh,
    String refreshToken,
  ) async {
    final refreshedToken = await refresh(refreshToken);

    if (refreshedToken != null) {
      await tokenService.setAuthToken(refreshedToken);
    }

    return refreshedToken;
  }

  Never _onTokenExpired() {
    onTokenExpired();

    throw const UnauthorizedHttpException();
  }
}
