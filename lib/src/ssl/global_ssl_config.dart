import 'dart:io';

import 'package:flutter/foundation.dart';

import '../http_service.dart';

/// Turns off TLS certificate validation for every `dart:io` [HttpClient]
/// created afterwards in the current isolate, through [HttpOverrides.global].
///
/// Development only, e.g. to reach a local server with a self-signed
/// certificate. Prefer `HttpService(allowBadCertificates: true)`, which only
/// affects that service.
class GlobalSslConfig {
  static bool _isConfigured = false;

  /// Disables certificate validation globally only when
  /// [allowBadCertificates] is `true` and this is not a release build.
  /// Calling it with no argument does nothing.
  static void configure([bool allowBadCertificates = false]) {
    if (_isConfigured || !allowBadCertificates) {
      return;
    }

    if (!HttpService.acceptsBadCertificates(
      allowBadCertificates: allowBadCertificates,
    )) {
      debugPrint(
        'GlobalSslConfig.configure(true) is ignored in release builds: '
        'TLS certificates are validated.',
      );

      return;
    }

    HttpOverrides.global = _AcceptBadCertificateCallbackHttpOverrides();
    _isConfigured = true;

    debugPrint('⚠️  SSL Certificate validation globally disabled');
  }

  static void restore() {
    if (_isConfigured) {
      HttpOverrides.global = null;
      _isConfigured = false;

      debugPrint('🔒 SSL Certificate validation restored to default');
    }
  }
}

class _AcceptBadCertificateCallbackHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) {
        debugPrint('⚠️  Ignoring SSL certificate for $host:$port');

        return true;
      };
  }
}
