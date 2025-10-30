// ignore_for_file: cascade_invocations, avoid_annotating_with_dynamic

import 'dart:async';
import 'dart:convert';
import 'dart:io' hide HttpException;

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:simple_logger/simple_logger.dart';

import 'exceptions/custom/malformed_json_http_exception.dart';
import 'exceptions/extensions/extensions.dart';
import 'exceptions/http_exception_base.dart';
import 'http_status/utils/int_http_status_code_extension.dart';
import 'i_http_service.dart';
import 'interceptors/i_auth_interceptor.dart';
import 'utils/http_curl_logger.dart';
import 'utils/path_utils.dart';

export 'exceptions/exceptions.dart';
export 'i_http_service.dart';

class HttpService implements IHttpService {
  HttpService({
    this.baseUrl = '',
    this.authInterceptor,
    Map<String, String>? headers,
    ILogger? logger,
    this.curlLogger = const HttpCurlLogger(),
  }) : logger = logger ?? ConsoleLogger(debugPrint, prefix: 'HttpService: ') {
    _client = _createIoClient();

    if (headers != null) {
      this.headers.addAll(headers);
    }
  }

  final IAuthInterceptor? authInterceptor;
  final HttpCurlLogger curlLogger;
  final ILogger logger;

  @override
  final String baseUrl;

  @override
  final Map<String, String> headers = _defaultHeaders;

  static final Map<String, String> _defaultHeaders = {
    // 'Content-Type': 'application/json',
    // 'Accept': 'application/json',
    'Content-Type': 'application/json; charset=utf-8',
    'Accept': 'application/json; charset=utf-8',
  };

  late IOClient _client;

  @override
  Future<CustomHttpResponse> deleteAndGetCustomResponse(
    String endpoint, [
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  ]) async {
    final url = _createUri(endpoint);

    headers = await getHeaders(headers);

    await _logRequest('DELETE', url, headers, body);

    final response = await _makeRequestAndHandleClientException(
      () async => _client.delete(
        url,
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      ),
      url,
    );

    await _logResponseSuccess(
      'DELETE',
      url,
      response.statusCode,
      headers,
      response.body,
    );

    return (
      body: response.body,
      bodyBytes: response.bodyBytes,
      statusCode: response.statusCode,
      headers: response.headers,
      contentLength: response.contentLength,
      reasonPhrase: response.reasonPhrase,
      uri: url,
    );
  }

  @override
  Future<Map<String, dynamic>> deleteAndGetJson(
    String endpoint, [
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  ]) async {
    final url = _createUri(endpoint);

    headers = await getHeaders(headers);

    await _logRequest('DELETE', url, headers, body);

    final response = await _makeRequestAndHandleClientException(
      () async => _client.delete(
        url,
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      ),
      url,
    );

    await _logResponseSuccess(
      'DELETE',
      url,
      response.statusCode,
      headers,
      response.body,
    );

    return _parseResponseToJsonAndHandleExceptions(response);
  }

  @override
  Future<T> deleteAndParseData<T>(
    String endpoint,
    T Function(Map<String, dynamic> p1) fromJson, {
    Map<String, dynamic>? queryParameters,
    String? dataKey,
    Map<String, String>? headers,
  }) async {
    final response = await deleteAndGetCustomResponse(
      endpoint,
      queryParameters,
      headers,
    );

    final jsonData = _parseCustomResponseToJsonAndHandleExceptions(response);

    if (dataKey != null) {
      return fromJson(
        (jsonData as Map<String, dynamic>)[dataKey] as Map<String, dynamic>,
      );
    }
    return fromJson(jsonData as Map<String, dynamic>);
  }

  @override
  Future<T> getAndParseData<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson, {
    Map<String, dynamic>? queryParameters,
    String? dataKey,
    Map<String, String>? headers,
  }) async {
    final response = await getCustomResponse(
      path,
      queryParameters: queryParameters,
      headers: headers,
    );

    final jsonData = _parseCustomResponseToJsonAndHandleExceptions(response);

    if (dataKey != null) {
      return fromJson(
        (jsonData as Map<String, dynamic>)[dataKey] as Map<String, dynamic>,
      );
    }
    return fromJson(jsonData as Map<String, dynamic>);
  }

  @override
  Future<List<T>> getAndParseDataList<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson, {
    Map<String, dynamic>? queryParameters,
    String? dataListKey,
    Map<String, String>? headers,
  }) async {
    final response = await getCustomResponse(
      path,
      queryParameters: queryParameters,
      headers: headers,
    );

    final jsonData = _parseCustomResponseToJsonAndHandleExceptions(response);

    if (dataListKey != null) {
      return ((jsonData as Map<String, dynamic>)[dataListKey] as List<dynamic>)
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList()
          .cast<T>();
    }

    return (jsonData as List<dynamic>)
        .map((item) => fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<CustomHttpResponse> getCustomResponse(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final url = _createUri(endpoint, queryParameters);

    headers = await getHeaders(headers);

    await _logRequest('GET', url, headers, queryParameters);

    final response = await _makeRequestAndHandleClientException(
      () async => _client.get(url, headers: headers),
      url,
    );

    await _logResponseSuccess(
      'GET',
      url,
      response.statusCode,
      response.headers,
      response.body,
    );

    return (
      body: response.body,
      bodyBytes: response.bodyBytes,
      statusCode: response.statusCode,
      headers: response.headers,
      contentLength: response.contentLength,
      reasonPhrase: response.reasonPhrase,
      uri: url,
    );
  }

  // @override
  // Future<File?> getFileBytesAndSave(
  //   String path, {
  //   String? savePath,
  //   Map<String, dynamic>? queryParameters,
  //   Map<String, String>? headers,
  // }) async {
  //   final response = await getCustomResponse(
  //     path,
  //     queryParameters: queryParameters,
  //     headers: headers,
  //   );

  //   if (response.statusCode.isSuccessfulHttpStatusCode) {
  //     try {
  //       final bytes = response.bodyBytes;

  //       if (bytes?.isEmpty ?? true) {
  //         logger.error('Received empty file bytes from $path');
  //         return null;
  //       }

  //       final file = File(savePath ?? path.split('/').last);

  //       await file.writeAsBytes(bytes!);

  //       return file;
  //     } catch (e) {
  //       logger.error('Error saving file: $e');
  //       return null;
  //     }
  //   } else {
  //     await _logResponseError(
  //       'GET (File)',
  //       response.uri,
  //       response.statusCode,
  //       headers,
  //       response.body,
  //     );

  //     throw _handleException(response);
  //   }
  // }

  @override
  Future<CustomHttpFile?> getFileBytes(
    String path, {
    String? savePath,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final response = await getCustomResponse(
      path,
      queryParameters: queryParameters,
      headers: headers,
    );

    if (response.statusCode.isSuccessfulHttpStatusCode) {
      final bytes = response.bodyBytes;

      if (bytes?.isEmpty ?? true) {
        logger.error('Received empty file bytes from $path');
        return null;
      }

      return (
        bodyBytes: bytes,
        fileLength: int.tryParse(response.headers['content-length'] ?? '') ??
            bytes?.length ??
            response.contentLength,
        filename: _extractFilenameFromContentDisposition(
          response.headers['content-disposition'],
        ),
      );
    } else {
      await _logResponseError(
        'GET (File)',
        response.uri,
        response.statusCode,
        headers,
        response.body,
      );

      throw _handleException(response);
    }
  }

  @override
  Future<Map<String, String>> getHeaders([
    Map<String, String>? additionalHeaders,
  ]) {
    return Future.value({...(additionalHeaders ?? {}), ...(headers)});
  }

  @override
  Future<Map<String, dynamic>> getJson(
    String endpoint, [
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  ]) async {
    final url = _createUri(endpoint, queryParameters);

    headers = await getHeaders(headers);

    await _logRequest('GET', url, headers, queryParameters);

    final response = await _makeRequestAndHandleClientException(
      () async => _client.get(url, headers: headers),
      url,
    );

    await _logResponseSuccess(
      'GET',
      url,
      response.statusCode,
      headers,
      response.body,
    );

    return _parseResponseToJsonAndHandleExceptions(response);
  }

  @override
  Future<CustomHttpResponse> postAndGetCustomResponse(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  }) async {
    final url = _createUri(endpoint);

    headers = await getHeaders(headers);

    await _logRequest('POST', url, headers, body);

    final response = await _makeRequestAndHandleClientException(
      () async {
        return _client.post(url, headers: headers, body: jsonEncode(body));
      },
      url,
    );

    await _logResponseSuccess(
      'POST',
      url,
      response.statusCode,
      headers,
      response.body,
    );

    return (
      body: response.body,
      bodyBytes: response.bodyBytes,
      statusCode: response.statusCode,
      headers: response.headers,
      contentLength: response.contentLength,
      reasonPhrase: response.reasonPhrase,
      uri: url,
    );
  }

  @override
  Future<Map<String, dynamic>> postAndGetJson(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  }) async {
    final url = _createUri(endpoint);

    headers = await getHeaders(headers);

    await _logRequest('POST', url, headers, body);

    final response = await _makeRequestAndHandleClientException(
      () async => _client.post(url, headers: headers, body: jsonEncode(body)),
      url,
    );

    await _logResponseSuccess(
      'POST',
      url,
      response.statusCode,
      headers,
      response.body,
    );

    return _parseResponseToJsonAndHandleExceptions(response);
  }

  @override
  Future<T> postAndParseData<T>(
    String endpoint,
    Map<String, dynamic> body,
    T Function(Map<String, dynamic> p1) fromJson, {
    String? dataKey,
    Map<String, String>? headers,
  }) async {
    final response = await postAndGetCustomResponse(
      endpoint,
      body,
      headers: headers,
    );

    if (response.statusCode.isSuccessfulHttpStatusCode) {
      if (dataKey != null) {
        return fromJson(response.data[dataKey] as Map<String, dynamic>);
      }

      return fromJson(response.data);
    } else {
      await _logResponseError(
        'POST',
        response.uri,
        response.statusCode,
        headers,
        response.body,
      );

      throw _handleException(response);
    }
  }

  @override
  Future<List<T>> postAndParseDataList<T>(
    String endpoint,
    Map<String, dynamic> body,
    T Function(Map<String, dynamic> p1) fromJson, {
    String? dataListKey,
    Map<String, String>? headers,
  }) async {
    final response = await postAndGetCustomResponse(
      endpoint,
      body,
      headers: headers,
    );

    final jsonData = _parseCustomResponseToJsonAndHandleExceptions(response);

    if (dataListKey != null) {
      return ((jsonData as Map<String, dynamic>)[dataListKey] as List<dynamic>)
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList()
          .cast<T>();
    }
    return (jsonData as List<dynamic>)
        .map((item) => fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<CustomHttpResponse> postMultipartAndGetCustomResponse(
    String endpoint, {
    Map<String, String>? fields,
    Map<String, File>? files,
    Map<String, String>? headers,
  }) async {
    final url = _createUri(endpoint);

    // Use the configured HttpClient from our IOClient
    final request = http.MultipartRequest('POST', url);

    if (fields != null) {
      request.fields.addAll(fields);
    }

    if (files != null) {
      for (final entry in files.entries) {
        final fieldName = entry.key;
        final file = entry.value;

        if (file.existsSync()) {
          final multipartFile = await http.MultipartFile.fromPath(
            fieldName,
            file.path,
          );
          request.files.add(multipartFile);
        } else {
          throw FileSystemException('File not found', file.path);
        }
      }
    }

    final requestHeaders = await getHeaders(headers);

    // * Remove default JSON content type for multipart requests
    // The HTTP client will automatically set the correct multipart/form-data
    // content type with boundary
    requestHeaders.remove('Content-Type');

    request.headers.addAll(requestHeaders);

    await _logRequest('POST (Multipart)', url, request.headers, {
      'fields': fields,
      'files': files?.keys.toList(),
    });

    // Use the configured IOClient to send the multipart request
    final streamedResponse =
        await _makeMultipartRequestAndHandleClientException(
      () async => _client.send(request),
      url,
    );

    final response = await http.Response.fromStream(streamedResponse);

    await _logResponseSuccess(
      'POST (Multipart)',
      url,
      response.statusCode,
      request.headers,
      response.body,
    );

    return (
      body: response.body,
      bodyBytes: response.bodyBytes,
      statusCode: response.statusCode,
      headers: response.headers,
      contentLength: response.contentLength,
      reasonPhrase: response.reasonPhrase,
      uri: url,
    );
  }

  @override
  Future<Map<String, dynamic>> postMultipartAndGetJson(
    String endpoint, {
    Map<String, String>? fields,
    Map<String, File>? files,
    Map<String, String>? headers,
  }) async {
    final response = await postMultipartAndGetCustomResponse(
      endpoint,
      fields: fields,
      files: files,
      headers: headers,
    );

    return _parseCustomResponseToJsonAndHandleExceptions(response)
        as Map<String, dynamic>;
  }

  @override
  Future<T> postMultipartAndParseData<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson, {
    Map<String, String>? fields,
    Map<String, File>? files,
    String? dataKey,
    Map<String, String>? headers,
  }) async {
    final response = await postMultipartAndGetCustomResponse(
      endpoint,
      fields: fields,
      files: files,
      headers: headers,
    );

    if (response.statusCode.isSuccessfulHttpStatusCode) {
      if (dataKey != null) {
        return fromJson(response.data[dataKey] as Map<String, dynamic>);
      }

      return fromJson(response.data);
    } else {
      await _logResponseError(
        'POST (Multipart)',
        response.uri,
        response.statusCode,
        headers,
        response.body,
      );

      throw _handleException(response);
    }
  }

  @override
  Future<T> postRawAndParseData<T>(
    String endpoint,
    String body,
    T Function(Map<String, dynamic> p1) fromJson, {
    String? dataKey,
    Map<String, String>? headers,
  }) async {
    final response = await postRawAndGetCustomResponse(
      endpoint,
      body,
      headers: headers,
    );

    if (response.statusCode.isSuccessfulHttpStatusCode) {
      if (dataKey != null) {
        return fromJson(response.data[dataKey] as Map<String, dynamic>);
      }
      // If no dataKey is provided, return the entire response data
      return fromJson(response.data);
    } else {
      throw _handleException(response);
    }
  }

  @override
  Future<CustomHttpResponse> putAndGetCustomResponse(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  }) async {
    final url = _createUri(endpoint);

    headers = await getHeaders(headers);

    await _logRequest('PUT', url, headers, body);

    final response = await _makeRequestAndHandleClientException(
      () async => _client.put(url, headers: headers, body: jsonEncode(body)),
      url,
    );

    await _logResponseSuccess(
      'PUT',
      url,
      response.statusCode,
      headers,
      response.body,
    );

    return (
      body: response.body,
      bodyBytes: response.bodyBytes,
      statusCode: response.statusCode,
      headers: response.headers,
      contentLength: response.contentLength,
      reasonPhrase: response.reasonPhrase,
      uri: url,
    );
  }

  @override
  Future<Map<String, dynamic>> putAndGetJson(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  }) async {
    final url = _createUri(endpoint);

    headers = await getHeaders(headers);

    await _logRequest('POST', url, headers, body);

    final response = await _makeRequestAndHandleClientException(
      () async => _client.put(url, headers: headers, body: jsonEncode(body)),
      url,
    );

    await _logResponseSuccess(
      'POST',
      url,
      response.statusCode,
      headers,
      response.body,
    );

    return _parseResponseToJsonAndHandleExceptions(response);
  }

  @override
  Future<T> putAndParseData<T>(
    String endpoint,
    Map<String, dynamic> body,
    T Function(Map<String, dynamic> p1) fromJson, {
    String? dataKey,
    Map<String, String>? headers,
  }) async {
    headers = await getHeaders(headers);

    final response = await putAndGetCustomResponse(
      endpoint,
      body,
      headers: headers,
    );

    if (response.statusCode.isSuccessfulHttpStatusCode) {
      if (dataKey != null) {
        return fromJson(response.data[dataKey] as Map<String, dynamic>);
      }
      // If no dataKey is provided, return the entire response data
      return fromJson(response.data);
    } else {
      throw _handleException(response);
    }
  }

  Future<CustomHttpResponse> postRawAndGetCustomResponse(
    String endpoint,
    String body, {
    Map<String, String>? headers,
  }) async {
    final url = _createUri(endpoint);

    headers = await getHeaders(headers);

    await _logRequest('POST', url, headers, body);

    final response = await _makeRequestAndHandleClientException(
      () async {
        return _client.post(url, headers: headers, body: body);
      },
      url,
    );

    await _logResponseSuccess(
      'POST',
      url,
      response.statusCode,
      headers,
      response.body,
    );

    return (
      body: response.body,
      bodyBytes: response.bodyBytes,
      statusCode: response.statusCode,
      headers: response.headers,
      contentLength: response.contentLength,
      reasonPhrase: response.reasonPhrase,
      uri: url,
    );
  }

  IOClient _createIoClient() {
    final httpClient = HttpClient()
      ..badCertificateCallback = ((cert, host, port) => true);

    return IOClient(httpClient);
  }

  Uri _createUri(String endpoint, [Map<String, dynamic>? queryParameters]) {
    if (baseUrl.isEmpty) {
      return Uri.parse(endpoint).replace(queryParameters: queryParameters);
    }

    final baseUrlPath =
        baseUrl.withoutTrailingSlash! + endpoint.withLeadingSlash!;

    return Uri.parse(baseUrlPath).replace(queryParameters: queryParameters);
  }

  /// Decodes RFC 5987 encoded filename (e.g., UTF-8''filename)
  String? _decodeRfc5987Filename(String value) {
    if (value.isEmpty) return null;

    try {
      // RFC 5987 format: charset'lang'value
      final parts = value.split("'");
      if (parts.length >= 3) {
        final charset = parts[0];
        // Skip language part (parts[1])
        final encodedValue = parts.sublist(2).join("'");

        if (charset.toLowerCase() == 'utf-8') {
          // Decode percent-encoded UTF-8
          return Uri.decodeComponent(encodedValue);
        }
      }

      // Fallback: try to decode as-is
      return Uri.decodeComponent(value);
    } catch (e) {
      logger.error('Error decoding RFC 5987 filename: $e');
      return value; // Return as-is if decoding fails
    }
  }

  /// Safely extracts filename from Content-Disposition header
  /// Handles both regular filename and RFC 5987 encoded filename* parameters
  String? _extractFilenameFromContentDisposition(String? contentDisposition) {
    if (contentDisposition == null || contentDisposition.isEmpty) {
      return null;
    }

    try {
      // Split by semicolon to get individual parameters
      final parts = contentDisposition.split(';');

      String? filename;
      String? filenameExtended;

      for (final part in parts) {
        final trimmed = part.trim().toLowerCase();

        // Look for filename* parameter (RFC 5987 encoded)
        if (trimmed.startsWith('filename*=')) {
          final value = part.substring(part.indexOf('=') + 1).trim();
          filenameExtended = _decodeRfc5987Filename(value);
        }
        // Look for regular filename parameter
        else if (trimmed.startsWith('filename=')) {
          final value = part.substring(part.indexOf('=') + 1).trim();
          filename = _unquoteFilename(value);
        }
      }

      // Prefer filename* over filename as it's more robust for international
      // characters
      return filenameExtended ?? filename;
    } catch (e) {
      logger.error('Error parsing Content-Disposition header: $e');
      return null;
    }
  }

  HttpException _handleException(CustomHttpResponse response) {
    final e = response.statusCode.exception(
      detail:
          '''Http exception occurred at ${DateTime.now().toIso8601String()}, because ${response.reasonPhrase}.''',
      data: response.data,
      uri: response.uri,
    );

    if (authInterceptor != null) {
      unawaited(authInterceptor!.onError(e));
    }

    return e;
  }

  Future<void> _logRequest(
    String method,
    Uri uri,
    Map<String, String>? headers,
    dynamic body,
  ) async {
    logger.info('💡 Sending $method Request');
    logger.verbose('  URL: $uri');
    logger.verbose('  Headers: $headers');
    if (body != null) {
      logger.verbose('  Request Data: $body');
    }

    if (kDebugMode) curlLogger.log(method, uri, headers, body);
  }

  Future<void> _logResponseError(
    String method,
    Uri url,
    int statusCode,
    Map<String, String>? headers,
    dynamic data,
  ) async {
    logger.error('❌ $method Request Error');
    logger.error('  URL: $url');
    logger.error('  Status Code: $statusCode');
    if (data != null) {
      logger.error('  Response Data: $data');
    }
  }

  Future<void> _logResponseSuccess(
    String method,
    Uri url,
    int statusCode,
    Map<String, String>? headers,
    dynamic data,
  ) async {
    logger.info('✅ $method Response');
    logger.verbose('  URL: $url');
    logger.verbose('  Status Code: $statusCode');
    logger.verbose('  Headers: $headers');
    if (data != null) {
      logger.verbose('  Response Data: $data');
    }
  }

  Future<http.StreamedResponse> _makeMultipartRequestAndHandleClientException(
    Future<http.StreamedResponse> Function() requestFunc,
    Uri uri,
  ) async {
    try {
      return await requestFunc();
    } on http.ClientException catch (e) {
      throw SocketHttpException(
        detail: 'Failed to connect to the server: $e',
        uri: uri,
      );
    }
  }

  Future<http.Response> _makeRequestAndHandleClientException(
    Future<http.Response> Function() requestFunc,
    Uri uri,
  ) async {
    // if (authInterceptor != null) {
    //   await authInterceptor!.onRequest();
    // }

    try {
      return await requestFunc();
    } on http.ClientException catch (e) {
      throw SocketHttpException(
        detail: 'Failed to connect to the server: $e',
        uri: uri,
      );
    }
  }

  dynamic _parseCustomResponseToJsonAndHandleExceptions(
    CustomHttpResponse response,
  ) {
    if (response.statusCode.isSuccessfulHttpStatusCode) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        throw MalformedJsonHttpException(
          detail: 'Malformed JSON response',
          uri: response.uri,
        );
      }
    } else {
      throw _handleException(
        (
          body: response.body,
          bodyBytes: response.bodyBytes,
          statusCode: response.statusCode,
          headers: response.headers,
          contentLength: response.contentLength,
          reasonPhrase: response.reasonPhrase,
          uri: response.uri,
        ),
      );
    }
  }

  Map<String, dynamic> _parseResponseToJsonAndHandleExceptions(
    http.Response response,
  ) {
    final uri = response.request == null
        ? null
        : Uri.tryParse(response.request!.url.toString());

    if (response.statusCode.isSuccessfulHttpStatusCode) {
      try {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } catch (e) {
        throw MalformedJsonHttpException(
          detail: 'Malformed JSON response',
          uri: uri,
        );
      }
    } else {
      throw _handleException(
        (
          body: response.body,
          bodyBytes: response.bodyBytes,
          statusCode: response.statusCode,
          headers: response.headers,
          contentLength: response.contentLength,
          reasonPhrase: response.reasonPhrase,
          uri: uri ?? Uri.parse(baseUrl),
        ),
      );
    }
  }

  /// Removes quotes from filename value
  String? _unquoteFilename(String value) {
    if (value.isEmpty) return null;

    final trimmed = value.trim();

    // Remove surrounding quotes if present
    if ((trimmed.startsWith('"') && trimmed.endsWith('"')) ||
        (trimmed.startsWith("'") && trimmed.endsWith("'"))) {
      return trimmed.substring(1, trimmed.length - 1);
    }

    return trimmed;
  }
}
