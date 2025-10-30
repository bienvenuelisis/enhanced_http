import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'exceptions/custom/malformed_json_http_exception.dart';

export 'exceptions/custom/socket_http_exception.dart';

/// An abstract class that defines the contract for an HTTP service.
///
/// This service provides methods for making HTTP requests such as
/// GET, POST, PUT, and DELETE.
/// It also includes methods for handling raw responses and parsing
/// data into specific types.
abstract class IHttpService {
  /// Creates an instance of [IHttpService] with the given [baseUrl].
  ///
  /// The [baseUrl] is the base URL for all HTTP requests made by this service.
  IHttpService(this.baseUrl);

  final Map<String, String> headers = {};

  /// The base URL for the HTTP service.
  final String baseUrl;

  /// Sends a DELETE request to the specified [endpoint] and returns the
  /// raw response.
  ///
  /// Returns a `Future` containing a record with the raw response details such
  /// as body, headers, status code, etc.
  Future<CustomHttpResponse> deleteAndGetCustomResponse(String endpoint);

  /// Sends a DELETE request to the specified [endpoint] and returns the parsed
  /// response as a `Map<String, dynamic>`.
  ///
  /// Returns a `Future` containing the parsed response data.
  Future<Map<String, dynamic>> deleteAndGetJson(String endpoint);

  /// Sends a DELETE request to the specified [endpoint] and parses the
  /// response into an object of type [T].
  /// The [fromJson] function is used to convert the response data into an
  /// object of type [T].
  /// Optionally, [dataKey] can be provided to specify the key for the data
  /// in the response.
  /// Returns a `Future` containing the parsed object of type [T], or throw
  /// an exception if parsing fails.
  Future<T> deleteAndParseData<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson, {
    Map<String, dynamic>? queryParameters,
    String? dataKey,
  });

  /// Sends a GET request to the specified [path] and parses the response into
  /// an object of type [T].
  ///
  /// The [fromJson] function is used to convert the response data into an
  /// object of type [T].
  /// Optionally, [queryParameters] and [dataKey] can be provided to include
  ///  query parameters
  /// and specify the key for the data in the response.
  ///
  /// Returns a `Future` containing the parsed object of type [T], or `null`
  ///  if parsing fails.
  Future<T> getAndParseData<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson, {
    Map<String, dynamic>? queryParameters,
    String? dataKey,
    Map<String, String>? headers,
  });

  /// Sends a GET request to the specified [path] and parses the response into
  /// a list of objects of type [T].
  ///
  /// The [fromJson] function is used to convert each item in the response data
  ///  into an object of type [T].
  /// Optionally, [queryParameters] and [dataListKey] can be provided to include
  ///  query parameters and specify the key for the list of data in the
  /// response.
  ///
  /// Returns a `Future` containing the parsed list of objects of type [T],
  /// or `null` if parsing fails.
  Future<List<T>> getAndParseDataList<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson, {
    Map<String, dynamic>? queryParameters,
    String? dataListKey,
  });

  /// Sends a GET request to the specified [endpoint] and returns the raw
  ///  response.
  ///
  /// Optionally, [queryParameters] can be provided to include query parameters
  /// in the request.
  ///
  /// Returns a `Future` containing a record with the raw response details such
  /// as body, headers, status code, etc.
  Future<CustomHttpResponse> getCustomResponse(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });

  // /// Sends a GET request to the specified [path] and retrieves the file bytes,
  // /// saving them to the specified [savePath] if provided.
  // ///
  // Future<File?> getFileBytesAndSave(
  //   String path, {
  //   String? savePath,
  //   Map<String, dynamic>? queryParameters,
  //   Map<String, String>? headers,
  // });

  /// Sends a GET request to the specified [path] and retrieves the file bytes.
  ///
  Future<CustomHttpFile?> getFileBytes(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });

  /// Retrieves the headers to be used in HTTP requests.
  ///
  /// This method returns a `Future` that resolves to a `Map` containing
  /// key-value pairs representing the headers. These headers can include
  /// authentication tokens, content types, or other metadata required
  /// for making HTTP requests.
  ///
  /// Returns:
  /// - A `Future` that resolves to a `Map<String, String>` containing
  ///   the HTTP headers.
  Future<Map<String, String>> getHeaders([
    Map<String, String>? additionalHeaders,
  ]);

  /// Sends a GET request to the specified [endpoint] and returns the parsed
  /// response as a `Map<String, dynamic>`.
  ///
  /// Optionally, [queryParameters] can be provided to include query parameters
  ///  in the request.
  ///
  /// Returns a `Future` containing the parsed response data.
  Future<Map<String, dynamic>> getJson(
    String endpoint, [
    Map<String, dynamic>? queryParameters,
  ]);

  /// Sends a POST request to the specified [endpoint] with the given [body]
  /// and returns the raw response.
  ///
  /// Returns a `Future` containing a record with the raw response details such
  /// as body, headers, status code, etc.
  Future<CustomHttpResponse> postAndGetCustomResponse(
    String endpoint,
    Map<String, dynamic> body,
  );

  /// Sends a POST request to the specified [endpoint] with the given [body]
  /// and returns the parsed response as a `Map<String, dynamic>`.
  ///
  /// Returns a `Future` containing the parsed response data.
  Future<Map<String, dynamic>> postAndGetJson(
    String endpoint,
    Map<String, dynamic> body,
  );

  /// Sends a POST request to the specified [endpoint] with the given [body]
  /// and parses the response into an object of type [T].
  ///
  /// The [fromJson] function is used to convert the response data into an
  /// object of type [T].
  /// Optionally, [dataKey] can be provided to specify the key for the data
  /// in the response.
  ///
  /// Returns a `Future` containing the parsed object of type [T], or `null`
  /// if parsing fails.
  Future<T> postAndParseData<T>(
    String endpoint,
    Map<String, dynamic> body,
    T Function(Map<String, dynamic>) fromJson, {
    String? dataKey,
    Map<String, String>? headers,
  });

  /// Sends a POST request to the specified [endpoint] with the given [body]
  /// and parses the response into a list of objects of type [T].
  ///
  /// The [fromJson] function is used to convert each item in the response data
  /// into an object of type [T].
  /// Optionally, [dataListKey] can be provided to specify the key for the list
  /// of data in the response.
  ///
  Future<List<T>> postAndParseDataList<T>(
    String endpoint,
    Map<String, dynamic> body,
    T Function(Map<String, dynamic>) fromJson, {
    String? dataListKey,
  });

  /// Sends a POST request with multipart form data to the specified [endpoint].
  ///
  /// This method allows uploading files and form data using multipart/form-data
  /// content type. The [fields] parameter contains regular form fields,
  /// and [files] parameter contains files to upload.
  ///
  /// Returns a `Future` containing a record with the raw response details
  /// such as body, headers, status code, etc.
  Future<CustomHttpResponse> postMultipartAndGetCustomResponse(
    String endpoint, {
    Map<String, String>? fields,
    Map<String, File>? files,
    Map<String, String>? headers,
  });

  /// Sends a POST request with multipart form data to the specified [endpoint]
  /// and returns the parsed response as a `Map<String, dynamic>`.
  ///
  /// This method allows uploading files and form data using multipart/form-data
  /// content type. The [fields] parameter contains regular form fields,
  /// and [files] parameter contains files to upload.
  ///
  /// Returns a `Future` containing the parsed response data.
  Future<Map<String, dynamic>> postMultipartAndGetJson(
    String endpoint, {
    Map<String, String>? fields,
    Map<String, File>? files,
    Map<String, String>? headers,
  });

  /// Sends a POST request with multipart form data to the specified [endpoint]
  /// and parses the response into an object of type [T].
  ///
  /// This method allows uploading files and form data using multipart/form-data
  /// content type. The [fields] parameter contains regular form fields,
  /// and [files] parameter contains files to upload.
  ///
  /// The [fromJson] function is used to convert the response data into an
  /// object of type [T].
  /// Optionally, [dataKey] can be provided to specify the key for the data
  /// in the response.
  ///
  /// Returns a `Future` containing the parsed object of type [T].
  Future<T> postMultipartAndParseData<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson, {
    Map<String, String>? fields,
    Map<String, File>? files,
    String? dataKey,
    Map<String, String>? headers,
  });

  /// Sends a POST request to the specified [endpoint] with the given [body]
  /// and parses the response into an object of type [T].
  ///
  /// The [fromJson] function is used to convert the response data into an
  /// object of type [T].
  /// Optionally, [dataKey] can be provided to specify the key for the data
  /// in the response.
  ///
  /// Returns a `Future` containing the parsed object of type [T], or `null`
  /// if parsing fails.
  Future<T> postRawAndParseData<T>(
    String endpoint,
    String body,
    T Function(Map<String, dynamic>) fromJson, {
    String? dataKey,
    Map<String, String>? headers,
  });

  /// Sends a PUT request to the specified [endpoint] with the given [body]
  /// and returns the raw response.
  ///
  /// Returns a `Future` containing a record with the raw response details
  /// such as body, headers, status code, etc.
  Future<CustomHttpResponse> putAndGetCustomResponse(
    String endpoint,
    Map<String, dynamic> body,
  );

  /// Sends a PUT request to the specified [endpoint] with the given [body]
  /// and returns the parsed response as a `Map<String, dynamic>`.
  ///
  /// Returns a `Future` containing the parsed response data.
  Future<Map<String, dynamic>> putAndGetJson(
    String endpoint,
    Map<String, dynamic> body,
  );

  /// Sends a PUT request to the specified [endpoint] with the given [body]
  /// and parses the response into an object of type [T].
  /// The [fromJson] function is used to convert the response data into an
  /// object of type [T].
  /// Optionally, [dataKey] can be provided to specify the key for the data
  /// in the response.
  Future<T> putAndParseData<T>(
    String endpoint,
    Map<String, dynamic> body,
    T Function(Map<String, dynamic>) fromJson, {
    String? dataKey,
  });
}

/// A typedef representing a custom HTTP response structure.
///
/// This typedef defines the structure of an HTTP response with
/// the following fields:
///
/// - `body` (`String`): The raw response body as a string.
/// - `data` (`Map<String, dynamic>`): The parsed response data, typically
/// in JSON format.
/// - `contentLength` (`int?`): The length of the response content,
/// if available.
/// - `headers` (`Map<String, String>`): The headers included in the
/// HTTP response.
/// - `reasonPhrase` (`String?`): The reason phrase associated with the
/// HTTP status code, if available.
/// - `statusCode` (`int`): The HTTP status code of the response.

typedef CustomHttpResponse = ({
  String body,
  Uint8List? bodyBytes,
  int? contentLength,
  Map<String, String> headers,
  String? reasonPhrase,
  int statusCode,
  Uri uri,
});

typedef CustomHttpFile = ({
  Uint8List? bodyBytes,
  int? fileLength,
  String? filename,
});

/// Extension on [CustomHttpResponse] to provide additional functionality.
///
/// This extension adds a `data` getter that decodes the `body` of the
/// [CustomHttpResponse] into a `Map<String, dynamic>`.
///
/// The `data` getter assumes that the `body` contains a JSON-encoded
/// string and attempts to parse it. If the `body` is not a valid
/// JSON-encoded string or does not represent a `Map<String, dynamic>`,
/// a runtime exception will be thrown.
extension ActionsOnCustomHttpResponse on CustomHttpResponse {
  Map<String, dynamic> get data {
    try {
      final jsonDecoded = jsonDecode(body);

      return jsonDecoded is String
          ? {"data": body}
          : jsonDecode(body) as Map<String, dynamic>;
    } catch (e) {
      throw MalformedJsonHttpException(
        uri: uri,
        detail: 'Unable to parse response body as JSON: $body',
      );
    }
  }
}
