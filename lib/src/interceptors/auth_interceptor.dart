import 'dart:async';

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

  static final Object _refreshZoneKey = Object();

  /// Refresh in flight, shared so concurrent requests refresh only once.
  /// Completes with `true` when a new token has been stored.
  Future<bool>? _refreshing;

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

    // Requests made by onRefreshToken itself (e.g. through this same
    // HttpService) must not wait for the refresh they are part of.
    if (Zone.current[_refreshZoneKey] == true) {
      return;
    }

    AuthTokenData? token;

    try {
      token = await tokenService.getAuthToken();
    } catch (e) {
      // Some implementations throw when no token is stored: the request is
      // then sent unauthenticated (e.g. login), as with a `null` token.
      debugPrint(e.toString());
    }

    if (token == null || !token.expired) {
      return;
    }

    final refresh = onRefreshToken;
    final refreshToken = token.refreshToken;

    if (refresh == null || refreshToken == null || refreshToken.isEmpty) {
      await _onTokenExpired();
    }

    final refreshing = _refreshing ??= _refresh(refresh, refreshToken);

    try {
      if (!await refreshing) {
        throw const UnauthorizedHttpException();
      }
    } finally {
      if (identical(_refreshing, refreshing)) {
        _refreshing = null;
      }
    }
  }

  /// Runs the refresh and stores the new token. On failure, notifies
  /// [onTokenExpired] once for all the requests waiting on this refresh.
  Future<bool> _refresh(
    Future<AuthTokenData?> Function(String refreshToken) refresh,
    String refreshToken,
  ) async {
    try {
      final refreshedToken = await runZoned(
        () => refresh(refreshToken),
        zoneValues: {_refreshZoneKey: true},
      );

      if (refreshedToken != null) {
        await tokenService.setAuthToken(refreshedToken);

        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    await _endSession();

    return false;
  }

  Future<Never> _onTokenExpired() async {
    await _endSession();

    throw const UnauthorizedHttpException();
  }

  /// Clears the stored token, so later unauthenticated requests (e.g. login)
  /// are not blocked by it, then notifies [onTokenExpired].
  Future<void> _endSession() async {
    try {
      await tokenService.clearAuthToken();
    } catch (e) {
      debugPrint(e.toString());
    }

    onTokenExpired();
  }
}
