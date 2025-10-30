// Copyright (c) 2024, Andres Garcia (TECH-ANDGAR). All rights reserved.
// Use of this source code
// is governed by a Apache-style license that can be found in the LICENSE file.

// ignore_for_file: lines_longer_than_80_chars

import '../../http_status/http_status.dart';
import '../http_4xx_exceptions.dart';
import '../http_5xx_exceptions.dart';
import '../http_exception_base.dart';

// ignore_for_file: long-method

/// Extension on [HttpStatus] to easily convert HTTP status codes into
/// corresponding [HttpException] instances, allowing for more descriptive and
/// granular error handling.
///
/// This extension provides a convenient way to handle different
/// HTTP status codes by mapping them to specific exceptions. Each exception
/// can carry additional details such as a human-readable explanation
/// (detail), arbitrary data (data), and the URI (uri) associated with
/// the HTTP request.
///
/// Example usage:
///
/// ```dart
/// final httpStatus = HttpStatus.notFound;
/// try {
///   throw httpStatus.exception(detail: 'Resource not found', uri: Uri.parse('https://example.com'));
/// } on NotFoundHttpException catch (e) {
///   // Handle 404 Not Found exception
///   print(e.message);
/// }
/// ```
extension HttpStatusExtension on HttpStatus {
  /// Creates an [HttpException] based on the [HttpStatus] value.
  ///
  /// Each HTTP status code results in a corresponding [HttpException] subclass,
  /// allowing for detailed and specific error handling based on HTTP
  /// response status.
  /// If a status code does not match any predefined subclasses,
  /// a generic HttpStatus [HttpException] will be thrown.
  ///
  /// * [detail]: Optional human-readable message providing more context about the error.
  ///
  /// * [data]: Optional arbitrary data associated with the exception. Can be used to carry additional information pertinent to the exception.
  ///
  /// * [uri]: Optional [Uri] associated with the HTTP request that resulted in this error.
  ///
  /// Returns an [HttpException] or one of its subclasses, tailored to represent the
  /// specific HTTP status code.
  HttpException exception({
    String detail = '',
    Map<String, dynamic>? data,
    Uri? uri,
  }) {
    // 4xx Client Error.
    if (this == HttpStatus.badRequest) {
      return BadRequestHttpException(detail: detail, data: data, uri: uri);
    } else if (this == HttpStatus.unauthorized) {
      return UnauthorizedHttpException(detail: detail, data: data, uri: uri);
    } else if (this == HttpStatus.paymentRequired) {
      return PaymentRequiredHttpException(detail: detail, data: data, uri: uri);
    } else if (this == HttpStatus.forbidden) {
      return ForbiddenHttpException(detail: detail, data: data, uri: uri);
    } else if (this == HttpStatus.notFound) {
      return NotFoundHttpException(detail: detail, data: data, uri: uri);
    } else if (this == HttpStatus.methodNotAllowed) {
      return MethodNotAllowedHttpException(
        detail: detail,
        data: data,
        uri: uri,
      );
    } else if (this == HttpStatus.notAcceptable) {
      return NotAcceptableHttpException(detail: detail, data: data, uri: uri);
    } else if (this == HttpStatus.proxyAuthenticationRequired) {
      return ProxyAuthenticationRequiredHttpException(
        detail: detail,
        data: data,
        uri: uri,
      );
    } else if (this == HttpStatus.requestTimeout) {
      return RequestTimeoutHttpException(detail: detail, data: data, uri: uri);
    } else if (this == HttpStatus.conflict) {
      return ConflictHttpException(detail: detail, data: data, uri: uri);
    } else if (this == HttpStatus.gone) {
      return GoneHttpException(detail: detail, data: data, uri: uri);
    } else if (this == HttpStatus.lengthRequired) {
      return LengthRequiredHttpException(detail: detail, data: data, uri: uri);
    } else if (this == HttpStatus.preconditionFailed) {
      return PreconditionFailedHttpException(
        detail: detail,
        data: data,
        uri: uri,
      );
    } else if (this == HttpStatus.requestEntityTooLarge) {
      return RequestEntityTooLargeHttpException(
        detail: detail,
        data: data,
        uri: uri,
      );
    } else if (this == HttpStatus.requestUriTooLong) {
      return RequestUriTooLongHttpException(
        detail: detail,
        data: data,
        uri: uri,
      );
    } else if (this == HttpStatus.unsupportedMediaType) {
      return UnsupportedMediaTypeHttpException(
        detail: detail,
        data: data,
        uri: uri,
      );
    } else if (this == HttpStatus.requestedRangeNotSatisfiable) {
      return RequestedRangeNotSatisfiableHttpException(
        detail: detail,
        data: data,
        uri: uri,
      );
    } else if (this == HttpStatus.expectationFailed) {
      return ExpectationFailedHttpException(
        detail: detail,
        data: data,
        uri: uri,
      );
    } else if (this == HttpStatus.imATeapot) {
      return ImATeapotHttpException(detail: detail, data: data, uri: uri);
    } else if (this == HttpStatus.insufficientSpaceOnResource) {
      return InsufficientSpaceOnResourceHttpException(
        detail: detail,
        data: data,
        uri: uri,
      );
    } else if (this == HttpStatus.methodFailure) {
      return MethodFailureHttpException(detail: detail, data: data, uri: uri);
    } else if (this == HttpStatus.misdirectedRequest) {
      return MisdirectedRequestHttpException(
        detail: detail,
        data: data,
        uri: uri,
      );
    } else if (this == HttpStatus.unprocessableEntity) {
      return UnprocessableEntityHttpException(
        detail: detail,
        data: data,
        uri: uri,
      );
    } else if (this == HttpStatus.locked) {
      return LockedHttpException(detail: detail, data: data, uri: uri);
    } else if (this == HttpStatus.failedDependency) {
      return FailedDependencyHttpException(
        detail: detail,
        data: data,
        uri: uri,
      );
    } else if (this == HttpStatus.upgradeRequired) {
      return UpgradeRequiredHttpException(detail: detail, data: data, uri: uri);
    } else if (this == HttpStatus.preconditionRequired) {
      return PreconditionRequiredHttpException(
        detail: detail,
        data: data,
        uri: uri,
      );
    } else if (this == HttpStatus.tooManyRequests) {
      return TooManyRequestsHttpException(detail: detail, data: data, uri: uri);
    } else if (this == HttpStatus.requestHeaderFieldsTooLarge) {
      return RequestHeaderFieldsTooLargeHttpException(
        detail: detail,
        data: data,
        uri: uri,
      );
    } else if (this == HttpStatus.connectionClosedWithoutResponse) {
      return ConnectionClosedWithoutResponseHttpException(
        detail: detail,
        data: data,
        uri: uri,
      );
    } else if (this == HttpStatus.unavailableForLegalReasons) {
      return UnavailableForLegalReasonsHttpException(
        detail: detail,
        data: data,
        uri: uri,
      );
    } else if (this == HttpStatus.clientClosedRequest) {
      return ClientClosedRequestHttpException(
        detail: detail,
        data: data,
        uri: uri,
      );
    }
    // 5xx Server Error.
    else if (this == HttpStatus.internalServerError) {
      return InternalServerErrorHttpException(
        detail: detail,
        data: data,
        uri: uri,
      );
    } else if (this == HttpStatus.notImplemented) {
      return NotImplementedHttpException(detail: detail, data: data, uri: uri);
    } else if (this == HttpStatus.badGateway) {
      return BadGatewayHttpException(detail: detail, data: data, uri: uri);
    } else if (this == HttpStatus.serviceUnavailable) {
      return ServiceUnavailableHttpException(
        detail: detail,
        data: data,
        uri: uri,
      );
    } else if (this == HttpStatus.gatewayTimeout) {
      return GatewayTimeoutHttpException(detail: detail, data: data, uri: uri);
    } else if (this == HttpStatus.httpVersionNotSupported) {
      return HttpVersionNotSupportedHttpException(
        detail: detail,
        data: data,
        uri: uri,
      );
    } else if (this == HttpStatus.variantAlsoNegotiates) {
      return VariantAlsoNegotiatesHttpException(
        detail: detail,
        data: data,
        uri: uri,
      );
    } else if (this == HttpStatus.insufficientStorage) {
      return InsufficientStorageHttpException(
        detail: detail,
        data: data,
        uri: uri,
      );
    } else if (this == HttpStatus.loopDetected) {
      return LoopDetectedHttpException(detail: detail, data: data, uri: uri);
    } else if (this == HttpStatus.notExtended) {
      return NotExtendedHttpException(detail: detail, data: data, uri: uri);
    } else if (this == HttpStatus.networkAuthenticationRequired) {
      return NetworkAuthenticationRequiredHttpException(
        detail: detail,
        data: data,
        uri: uri,
      );
    } else if (this == HttpStatus.networkConnectTimeoutError) {
      return NetworkConnectTimeoutErrorHttpException(
        detail: detail,
        data: data,
        uri: uri,
      );
    } else {
      return HttpException(
        httpStatus: this,
        detail: detail,
        data: data,
        uri: uri,
      );
    }
  }
}
