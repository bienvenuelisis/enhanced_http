import 'dart:io';

import 'package:flutter/foundation.dart';

class GlobalSslConfig {
  static bool _isConfigured = false;

  static void configure([bool allowBadCertificates = true]) {
    if (!_isConfigured && allowBadCertificates) {
      HttpOverrides.global = _AcceptBadCertificateCallbackHttpOverrides();
      _isConfigured = true;

      debugPrint('⚠️  SSL Certificate validation globally disabled');
    }
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
