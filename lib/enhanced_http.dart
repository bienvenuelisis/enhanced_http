/// An enhanced HTTP client for Dart and Flutter applications.
///
/// Provides a comprehensive HTTP service with:
/// - Complete CRUD operations (GET, POST, PUT, DELETE)
/// - Custom HTTP exceptions with status codes
/// - Request/response interceptors
/// - CURL logging for debugging
/// - Multipart file upload support
/// - Response parsing helpers
/// - SSL configuration options
library;

export 'src/exceptions/custom/malformed_json_http_exception.dart';
export 'src/exceptions/custom/socket_http_exception.dart';
// Exceptions
export 'src/exceptions/exceptions.dart';
export 'src/exceptions/extensions/extensions.dart';
export 'src/exceptions/http_4xx_exceptions.dart';
export 'src/exceptions/http_5xx_exceptions.dart';
export 'src/exceptions/http_exception_base.dart';
// Core
export 'src/http_service.dart';
// HTTP Status
export 'src/http_status/http_status.dart';
export 'src/http_status/http_status_code.dart';
export 'src/http_status/utils/int_http_status_code_extension.dart';
export 'src/i_http_service.dart';
// Interceptors
export 'src/interceptors/auth_interceptor.dart';
export 'src/interceptors/i_auth_interceptor.dart';
// SSL
export 'src/ssl/global_ssl_config.dart';
// Utils
export 'src/utils/http_curl_logger.dart';
export 'src/utils/path_utils.dart';
