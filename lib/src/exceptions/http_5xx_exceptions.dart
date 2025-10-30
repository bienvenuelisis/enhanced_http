// Copyright (c) 2014, Thomas Profelt
// Copyright (c) 2015, Günter Zöchbauer, Thomas Profelt
// Copyright (c) 2021, Diego Perez.
// Copyright (c) 2024, Andres Garcia (TECH-ANDGAR). All rights reserved.
// Use of this source code
// is governed by a Apache-style license that can be found in the LICENSE file.

import '../http_status/http_status.dart';
import 'http_exception_base.dart';

/// {@template 500_internal_server_error_http_exception}
/// 500 Internal Server Error (Http Exception).
/// {@endtemplate}
class InternalServerErrorHttpException extends HttpException {
  /// {@macro 500_internal_server_error_http_exception}
  const InternalServerErrorHttpException({
    super.detail = '',
    super.data,
    super.uri,
  }) : super(httpStatus: HttpStatus.internalServerError);
}

/// {@template 501_not_implemented_http_exception}
/// 501 Not Implemented (Http Exception).
/// {@endtemplate}
class NotImplementedHttpException extends HttpException {
  /// {@macro 501_not_implemented_http_exception}
  const NotImplementedHttpException({super.detail = '', super.data, super.uri})
    : super(httpStatus: HttpStatus.notImplemented);
}

/// {@template 502_bad_gateway_http_exception}
/// 502 Bad Gateway (Http Exception).
/// {@endtemplate}
class BadGatewayHttpException extends HttpException {
  /// {@macro 502_bad_gateway_http_exception}
  const BadGatewayHttpException({super.detail = '', super.data, super.uri})
    : super(httpStatus: HttpStatus.badGateway);
}

/// {@template 503_service_unavailable_http_exception}
/// 503 Service Unavailable (Http Exception).
/// {@endtemplate}
class ServiceUnavailableHttpException extends HttpException {
  /// {@macro 503_service_unavailable_http_exception}
  const ServiceUnavailableHttpException({
    super.detail = '',
    super.data,
    super.uri,
  }) : super(httpStatus: HttpStatus.serviceUnavailable);
}

/// {@template 504_gateway_timeout_http_exception}
/// 504 Gateway Timeout (Http Exception).
/// {@endtemplate}
class GatewayTimeoutHttpException extends HttpException {
  /// {@macro 504_gateway_timeout_http_exception}
  const GatewayTimeoutHttpException({super.detail = '', super.data, super.uri})
    : super(httpStatus: HttpStatus.gatewayTimeout);
}

/// {@template 505_http_version_not_supported_http_exception}
/// 505 Http Version Not Supported (Http Exception).
/// {@endtemplate}
class HttpVersionNotSupportedHttpException extends HttpException {
  /// {@macro 505_http_version_not_supported_http_exception}
  const HttpVersionNotSupportedHttpException({
    super.detail = '',
    super.data,
    super.uri,
  }) : super(httpStatus: HttpStatus.httpVersionNotSupported);
}

/// {@template 506_variant_also_negotiates_http_exception}
/// 506 Variant Also Negotiates (Http Exception).
/// {@endtemplate}
class VariantAlsoNegotiatesHttpException extends HttpException {
  /// {@macro 506_variant_also_negotiates_http_exception}
  const VariantAlsoNegotiatesHttpException({
    super.detail = '',
    super.data,
    super.uri,
  }) : super(httpStatus: HttpStatus.variantAlsoNegotiates);
}

/// {@template 507_insufficient_storage_http_exception}
/// 507 Insufficient Storage (Http Exception).
/// {@endtemplate}
class InsufficientStorageHttpException extends HttpException {
  /// {@macro 507_insufficient_storage_http_exception}
  const InsufficientStorageHttpException({
    super.detail = '',
    super.data,
    super.uri,
  }) : super(httpStatus: HttpStatus.insufficientStorage);
}

/// {@template 508_loop_detected_http_exception}
/// 508 Loop Detected (Http Exception).
/// {@endtemplate}
class LoopDetectedHttpException extends HttpException {
  /// {@macro 508_loop_detected_http_exception}
  const LoopDetectedHttpException({super.detail = '', super.data, super.uri})
    : super(httpStatus: HttpStatus.loopDetected);
}

/// {@template 510_not_extended_http_exception}
/// 511 Not Extended (Http Exception).
/// {@endtemplate}
class NotExtendedHttpException extends HttpException {
  /// {@macro 510_not_extended_http_exception}
  const NotExtendedHttpException({super.detail = '', super.data, super.uri})
    : super(httpStatus: HttpStatus.notExtended);
}

/// {@template 511_network_authentication_required_http_exception}
/// 511 Network Authentication Required (Http Exception).
/// {@endtemplate}
class NetworkAuthenticationRequiredHttpException extends HttpException {
  /// {@macro 511_network_authentication_required_http_exception}
  const NetworkAuthenticationRequiredHttpException({
    super.detail = '',
    super.data,
    super.uri,
  }) : super(httpStatus: HttpStatus.networkAuthenticationRequired);
}

/// {@template 599_network_connect_timeout_error_http_exception}
/// 59 Network Authentication Required (Http Exception).
/// {@endtemplate}
class NetworkConnectTimeoutErrorHttpException extends HttpException {
  /// {@macro 599_network_connect_timeout_error_http_exception}
  const NetworkConnectTimeoutErrorHttpException({
    super.detail = '',
    super.data,
    super.uri,
  }) : super(httpStatus: HttpStatus.networkConnectTimeoutError);
}
