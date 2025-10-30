// Copyright (c) 2014, Thomas Profelt
// Copyright (c) 2015, Günter Zöchbauer, Thomas Profelt
// Copyright (c) 2021, Diego Perez.
// Copyright (c) 2024, Andres Garcia (TECH-ANDGAR). All rights reserved.
// Use of this source code
// is governed by a Apache-style license that can be found in the LICENSE file.

import '../http_status/http_status.dart';
import 'http_exception_base.dart';

/// {@template 400_bad_request_http_exception}
/// 400 Bad Request (Http Exception).
/// {@endtemplate}
class BadRequestHttpException extends HttpException {
  /// {@macro 400_bad_request_http_exception}
  const BadRequestHttpException({super.detail = '', super.data, super.uri})
    : super(httpStatus: HttpStatus.badRequest);
}

/// {@template 401_unauthorized_http_exception}
/// 401 Unauthorized (Http Exception).
/// {@endtemplate}
class UnauthorizedHttpException extends HttpException {
  /// {@macro 401_unauthorized_http_exception}
  const UnauthorizedHttpException({super.detail = '', super.data, super.uri})
    : super(httpStatus: HttpStatus.unauthorized);
}

/// {@template 402_payment_required_http_exception}
/// 402 Payment Required (Http Exception).
/// {@endtemplate}
class PaymentRequiredHttpException extends HttpException {
  /// {@macro 402_payment_required_http_exception}
  const PaymentRequiredHttpException({super.detail = '', super.data, super.uri})
    : super(httpStatus: HttpStatus.paymentRequired);
}

/// {@template 403_forbidden_http_exception}
/// 403 Forbidden (Http Exception).
/// {@endtemplate}
class ForbiddenHttpException extends HttpException {
  /// {@macro 403_forbidden_http_exception}
  const ForbiddenHttpException({super.detail = '', super.data, super.uri})
    : super(httpStatus: HttpStatus.forbidden);
}

/// {@template 404_not_found_http_exception}
/// 404 Not Found (Http Exception).
/// {@endtemplate}
class NotFoundHttpException extends HttpException {
  /// {@macro 404_not_found_http_exception}
  const NotFoundHttpException({super.detail = '', super.data, super.uri})
    : super(httpStatus: HttpStatus.notFound);
}

/// {@template 405_method_not_allowed_http_exception}
/// 405 Method Not Allowed (Http Exception).
/// {@endtemplate}
class MethodNotAllowedHttpException extends HttpException {
  /// {@macro 405_method_not_allowed_http_exception}
  const MethodNotAllowedHttpException({
    super.detail = '',
    super.data,
    super.uri,
  }) : super(httpStatus: HttpStatus.methodNotAllowed);
}

/// {@template 406_not_acceptable_http_exception}
/// 406 Not Acceptable (Http Exception).
/// {@endtemplate}
class NotAcceptableHttpException extends HttpException {
  /// {@macro 406_not_acceptable_http_exception}
  const NotAcceptableHttpException({super.detail = '', super.data, super.uri})
    : super(httpStatus: HttpStatus.notAcceptable);
}

/// {@template 407_proxy_authentication_required_http_exception}
/// 407 Proxy Authentication Required (Http Exception).
/// {@endtemplate}
class ProxyAuthenticationRequiredHttpException extends HttpException {
  /// {@macro 407_proxy_authentication_required_http_exception}
  const ProxyAuthenticationRequiredHttpException({
    super.detail = '',
    super.data,
    super.uri,
  }) : super(httpStatus: HttpStatus.proxyAuthenticationRequired);
}

/// {@template 408_request_timeout_http_exception}
/// 408 Request Timeout (Http Exception).
/// {@endtemplate}
class RequestTimeoutHttpException extends HttpException {
  /// {@macro 408_request_timeout_http_exception}
  const RequestTimeoutHttpException({super.detail = '', super.data, super.uri})
    : super(httpStatus: HttpStatus.requestTimeout);
}

/// {@template 409_conflict_http_exception}
/// 409 Conflict (Http Exception).
/// {@endtemplate}
class ConflictHttpException extends HttpException {
  /// {@macro 409_conflict_http_exception}
  const ConflictHttpException({super.detail = '', super.data, super.uri})
    : super(httpStatus: HttpStatus.conflict);
}

/// {@template 410_gone_http_exception}
/// 410 Gone (Http Exception).
/// {@endtemplate}
class GoneHttpException extends HttpException {
  /// {@macro 410_gone_http_exception}
  const GoneHttpException({super.detail = '', super.data, super.uri})
    : super(httpStatus: HttpStatus.gone);
}

/// {@template 411_length_required_http_exception}
/// 411 Length Required (Http Exception).
/// {@endtemplate}
class LengthRequiredHttpException extends HttpException {
  /// {@macro 411_length_required_http_exception}
  const LengthRequiredHttpException({super.detail = '', super.data, super.uri})
    : super(httpStatus: HttpStatus.lengthRequired);
}

/// {@template 412_precondition_failed_http_exception}
/// 412 Precondition Failed (Http Exception).
/// {@endtemplate}
class PreconditionFailedHttpException extends HttpException {
  /// {@macro 412_precondition_failed_http_exception}
  const PreconditionFailedHttpException({
    super.detail = '',
    super.data,
    super.uri,
  }) : super(httpStatus: HttpStatus.preconditionFailed);
}

/// {@template 413_request_entity_too_large_http_exception}
/// 413 Request Entity Too Large (Http Exception).
/// {@endtemplate}
class RequestEntityTooLargeHttpException extends HttpException {
  /// {@macro 413_request_entity_too_large_http_exception}
  const RequestEntityTooLargeHttpException({
    super.detail = '',
    super.data,
    super.uri,
  }) : super(httpStatus: HttpStatus.requestEntityTooLarge);
}

/// {@template 414_request_uri_too_long_http_exception}
/// 414 Request Uri Too Long (Http Exception).
/// {@endtemplate}
class RequestUriTooLongHttpException extends HttpException {
  /// {@macro 414_request_uri_too_long_http_exception}
  const RequestUriTooLongHttpException({
    super.detail = '',
    super.data,
    super.uri,
  }) : super(httpStatus: HttpStatus.requestUriTooLong);
}

/// {@template 415_unsupported_media_type_http_exception}
/// 415 Unsupported Media Type (Http Exception).
/// {@endtemplate}
class UnsupportedMediaTypeHttpException extends HttpException {
  /// {@macro 415_unsupported_media_type_http_exception}
  const UnsupportedMediaTypeHttpException({
    super.detail = '',
    super.data,
    super.uri,
  }) : super(httpStatus: HttpStatus.unsupportedMediaType);
}

/// {@template 416_requested_range_not_satisfiable_http_exception}
/// 416 Requested Range Not Satisfiable (Http Exception).
/// {@endtemplate}
class RequestedRangeNotSatisfiableHttpException extends HttpException {
  /// {@macro 416_requested_range_not_satisfiable_http_exception}
  const RequestedRangeNotSatisfiableHttpException({
    super.detail = '',
    super.data,
    super.uri,
  }) : super(httpStatus: HttpStatus.requestedRangeNotSatisfiable);
}

/// {@template 417_expectation_failed_http_exception}
/// 417 Expectation Failed (Http Exception).
/// {@endtemplate}
class ExpectationFailedHttpException extends HttpException {
  /// {@macro 417_expectation_failed_http_exception}
  const ExpectationFailedHttpException({
    super.detail = '',
    super.data,
    super.uri,
  }) : super(httpStatus: HttpStatus.expectationFailed);
}

/// {@template 418_im_a_teapot_http_exception}
/// 418 I'm A Teapot (Http Exception).
/// {@endtemplate}
class ImATeapotHttpException extends HttpException {
  /// {@macro 418_im_a_teapot_http_exception}
  const ImATeapotHttpException({super.detail = '', super.data, super.uri})
    : super(httpStatus: HttpStatus.imATeapot);
}

/// {@template 419_insufficient_space_on_resource_http_exception}
/// 419 Insufficient Space On Resource (Http Exception).
/// {@endtemplate}
class InsufficientSpaceOnResourceHttpException extends HttpException {
  /// {@macro 419_insufficient_space_on_resource_http_exception}
  const InsufficientSpaceOnResourceHttpException({
    super.detail = '',
    super.data,
    super.uri,
  }) : super(httpStatus: HttpStatus.insufficientSpaceOnResource);
}

/// {@template 420_method_failure_http_exception}
/// 420 Method Failure (Http Exception).
/// {@endtemplate}
class MethodFailureHttpException extends HttpException {
  /// {@macro 420_method_failure_http_exception}
  const MethodFailureHttpException({super.detail = '', super.data, super.uri})
    : super(httpStatus: HttpStatus.methodFailure);
}

/// {@template 421_misdirected_request_http_exception}
/// 421 Misdirected Request (Http Exception).
/// {@endtemplate}
class MisdirectedRequestHttpException extends HttpException {
  /// {@macro 421_misdirected_request_http_exception}
  const MisdirectedRequestHttpException({
    super.detail = '',
    super.data,
    super.uri,
  }) : super(httpStatus: HttpStatus.misdirectedRequest);
}

/// {@template 422_unprocessable_entity_http_exception}
/// 422 Unprocessable Entity (Http Exception).
/// {@endtemplate}
class UnprocessableEntityHttpException extends HttpException {
  /// {@macro 422_unprocessable_entity_http_exception}
  const UnprocessableEntityHttpException({
    super.detail = '',
    super.data,
    super.uri,
  }) : super(httpStatus: HttpStatus.unprocessableEntity);
}

/// {@template 423_locked_http_exception}
/// 423 Locked (Http Exception).
/// {@endtemplate}
class LockedHttpException extends HttpException {
  /// {@macro 423_locked_http_exception}
  const LockedHttpException({super.detail = '', super.data, super.uri})
    : super(httpStatus: HttpStatus.locked);
}

/// {@template 424_failed_dependency_http_exception}
/// 424 Failed Dependency (Http Exception).
/// {@endtemplate}
class FailedDependencyHttpException extends HttpException {
  /// {@macro 424_failed_dependency_http_exception}
  const FailedDependencyHttpException({
    super.detail = '',
    super.data,
    super.uri,
  }) : super(httpStatus: HttpStatus.failedDependency);
}

/// {@template 426_upgrade_required_http_exception}
/// 426 Upgrade Required (Http Exception).
/// {@endtemplate}
class UpgradeRequiredHttpException extends HttpException {
  /// {@macro 426_upgrade_required_http_exception}
  const UpgradeRequiredHttpException({super.detail = '', super.data, super.uri})
    : super(httpStatus: HttpStatus.upgradeRequired);
}

/// {@template 428_precondition_required_http_exception}
/// 428 Precondition Required (Http Exception).
/// {@endtemplate}
class PreconditionRequiredHttpException extends HttpException {
  /// {@macro 428_precondition_required_http_exception}
  const PreconditionRequiredHttpException({
    super.detail = '',
    super.data,
    super.uri,
  }) : super(httpStatus: HttpStatus.preconditionRequired);
}

/// {@template 429_too_many_requests_http_exception}
/// 429 Too Many Requests (Http Exception).
/// {@endtemplate}
class TooManyRequestsHttpException extends HttpException {
  /// {@macro 429_too_many_requests_http_exception}
  const TooManyRequestsHttpException({super.detail = '', super.data, super.uri})
    : super(httpStatus: HttpStatus.tooManyRequests);
}

/// {@template 431_request_header_fields_too_large_http_exception}
/// 431 Request Header Fields Too Large (Http Exception).
/// {@endtemplate}
class RequestHeaderFieldsTooLargeHttpException extends HttpException {
  /// {@macro 431_request_header_fields_too_large_http_exception}
  const RequestHeaderFieldsTooLargeHttpException({
    super.detail = '',
    super.data,
    super.uri,
  }) : super(httpStatus: HttpStatus.requestHeaderFieldsTooLarge);
}

/// {@template 444_connection_closed_without_response_http_exception}
/// 444 Connection Closed Without Response (Http Exception).
/// {@endtemplate}
class ConnectionClosedWithoutResponseHttpException extends HttpException {
  /// {@macro 444_connection_closed_without_response_http_exception}
  const ConnectionClosedWithoutResponseHttpException({
    super.detail = '',
    super.data,
    super.uri,
  }) : super(httpStatus: HttpStatus.connectionClosedWithoutResponse);
}

/// {@template 451_unavailable_for_legal_reasons_http_exception}
/// 451 Unavailable For Legal Reasons (Http Exception).
/// {@endtemplate}
class UnavailableForLegalReasonsHttpException extends HttpException {
  /// {@macro 451_unavailable_for_legal_reasons_http_exception}
  const UnavailableForLegalReasonsHttpException({
    super.detail = '',
    super.data,
    super.uri,
  }) : super(httpStatus: HttpStatus.unavailableForLegalReasons);
}

/// {@template 499_client_closed_request_http_exception}
/// 499 Client Closed Request (Http Exception).
/// {@endtemplate}
class ClientClosedRequestHttpException extends HttpException {
  /// {@macro 499_client_closed_request_http_exception}
  const ClientClosedRequestHttpException({
    super.detail = '',
    super.data,
    super.uri,
  }) : super(httpStatus: HttpStatus.clientClosedRequest);
}
