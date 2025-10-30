# Enhanced HTTP

An enhanced HTTP client for Dart and Flutter applications with comprehensive error handling, interceptors, CURL logging, and multipart upload support.

## Features

- 🚀 **Complete HTTP Client** - GET, POST, PUT, DELETE with response parsing
- 🎯 **Type-Safe Parsing** - Parse responses to custom objects automatically
- ⚠️ **Rich Error Handling** - Custom HTTP exceptions for all status codes (4xx, 5xx)
- 🔐 **Auth Interceptors** - Built-in support for authentication token injection
- 📝 **CURL Logging** - Debug requests with CURL command output
- 📁 **Multipart Upload** - Easy file upload support
- 🔧 **Highly Customizable** - Headers, timeouts, SSL configuration
- 💉 **DI-Friendly** - Interface-based design for easy testing

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  enhanced_http:
    path: packages/enhanced_http
```

## Usage

### Basic Usage

```dart
import 'package:enhanced_http/enhanced_http.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:flutter/foundation.dart';

void main() async {
  // Create HTTP service
  final httpService = HttpService(
    baseUrl: 'https://api.example.com',
    logger: ConsoleLogger(debugPrint),
  );

  // Make a GET request
  final user = await httpService.getAndParseData(
    '/users/1',
    (json) => User.fromJson(json),
  );

  print('User: ${user.name}');
}
```

### GET Requests

```dart
// Get raw JSON
final json = await httpService.getJson('/users/1');

// Parse to object
final user = await httpService.getAndParseData(
  '/users/1',
  User.fromJson,
);

// Parse to list
final users = await httpService.getAndParseDataList(
  '/users',
  User.fromJson,
);

// With query parameters
final user = await httpService.getAndParseData(
  '/users/1',
  User.fromJson,
  queryParameters: {'include': 'posts'},
);

// Extract data from nested key
final user = await httpService.getAndParseData(
  '/response',
  User.fromJson,
  dataKey: 'user', // Extracts from response['user']
);
```

### POST Requests

```dart
// Post and get JSON
final response = await httpService.postAndGetJson(
  '/users',
  {'name': 'John', 'email': 'john@example.com'},
);

// Post and parse response
final user = await httpService.postAndParseData(
  '/users',
  {'name': 'John'},
  User.fromJson,
);

// Post and parse list
final users = await httpService.postAndParseDataList(
  '/users/bulk',
  {'users': [...]},
  User.fromJson,
);
```

### PUT & DELETE Requests

```dart
// PUT request
final user = await httpService.putAndParseData(
  '/users/1',
  {'name': 'John Updated'},
  User.fromJson,
);

// DELETE request
final result = await httpService.deleteAndParseData(
  '/users/1',
  (json) => DeleteResult.fromJson(json),
);
```

### File Upload (Multipart)

```dart
// Upload single file
final response = await httpService.postMultipartAndGetJson(
  '/upload',
  fields: {
    'title': 'My Document',
    'description': 'Important file',
  },
  files: {
    'document': File('/path/to/file.pdf'),
  },
);

// Upload and parse response
final uploadResult = await httpService.postMultipartAndParseData(
  '/upload',
  UploadResult.fromJson,
  files: {
    'avatar': File('/path/to/avatar.jpg'),
  },
);
```

### Download Files

```dart
// Download file as bytes
final fileData = await httpService.getFileBytes('/documents/report.pdf');

if (fileData != null) {
  print('Downloaded ${fileData.filename}');
  print('Size: ${fileData.fileLength} bytes');

  // Save to disk
  final file = File('report.pdf');
  await file.writeAsBytes(fileData.bodyBytes!);
}
```

### Custom Headers

```dart
// Global headers
final httpService = HttpService(
  baseUrl: 'https://api.example.com',
  headers: {
    'X-API-Key': 'your-api-key',
    'Accept-Language': 'en',
  },
);

// Per-request headers
final user = await httpService.getAndParseData(
  '/users/1',
  User.fromJson,
  headers: {
    'X-Request-ID': '123',
  },
);
```

### Authentication Interceptor

```dart
class MyAuthInterceptor implements IAuthInterceptor {
  final TokenService tokenService;

  MyAuthInterceptor(this.tokenService);

  @override
  Future<void> onRequest() async {
    // Called before each request
  }

  @override
  Future<void> onError(HttpException error) async {
    // Handle auth errors (e.g., token expired)
    if (error is UnauthorizedHttpException) {
      // Refresh token or logout
    }
  }
}

// Use interceptor
final httpService = HttpService(
  baseUrl: 'https://api.example.com',
  authInterceptor: MyAuthInterceptor(tokenService),
);
```

### Exception Handling

```dart
try {
  final user = await httpService.getAndParseData(
    '/users/1',
    User.fromJson,
  );
} on UnauthorizedHttpException catch (e) {
  print('Unauthorized: ${e.message}');
  // Redirect to login
} on NotFoundHttpException catch (e) {
  print('User not found: ${e.message}');
} on ServerErrorHttpException catch (e) {
  print('Server error: ${e.message}');
  print('Status: ${e.statusCode}');
} on SocketHttpException catch (e) {
  print('Network error: ${e.message}');
} on MalformedJsonHttpException catch (e) {
  print('Invalid JSON response');
} on HttpException catch (e) {
  print('HTTP error: ${e.message}');
}
```

### CURL Logging

Enable CURL logging to see debug output of your requests:

```dart
final httpService = HttpService(
  baseUrl: 'https://api.example.com',
  logger: ConsoleLogger(debugPrint),
  curlLogger: const HttpCurlLogger(),
);
```

Output example:

```bash
curl -X GET \
  'https://api.example.com/users/1' \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json'
```

## Error Handling

### HTTP 4xx Exceptions

- `BadRequestHttpException` (400)
- `UnauthorizedHttpException` (401)
- `ForbiddenHttpException` (403)
- `NotFoundHttpException` (404)
- `MethodNotAllowedHttpException` (405)
- `ConflictHttpException` (409)
- `UnprocessableEntityHttpException` (422)
- `TooManyRequestsHttpException` (429)

### HTTP 5xx Exceptions

- `InternalServerErrorHttpException` (500)
- `BadGatewayHttpException` (502)
- `ServiceUnavailableHttpException` (503)
- `GatewayTimeoutHttpException` (504)

### Custom Exceptions

- `SocketHttpException` - Network/connection errors
- `MalformedJsonHttpException` - Invalid JSON in response
- `HttpException` - Base exception for all HTTP errors

## API Reference

### `IHttpService` Interface

```dart
abstract class IHttpService {
  // GET
  Future<Map<String, dynamic>> getJson(String endpoint);
  Future<T> getAndParseData<T>(String path, T Function(Map<String, dynamic>) fromJson);
  Future<List<T>> getAndParseDataList<T>(String path, T Function(Map<String, dynamic>) fromJson);
  Future<CustomHttpFile?> getFileBytes(String path);

  // POST
  Future<Map<String, dynamic>> postAndGetJson(String endpoint, Map<String, dynamic> body);
  Future<T> postAndParseData<T>(String endpoint, Map<String, dynamic> body, T Function(Map<String, dynamic>) fromJson);
  Future<List<T>> postAndParseDataList<T>(String endpoint, Map<String, dynamic> body, T Function(Map<String, dynamic>) fromJson);

  // Multipart
  Future<Map<String, dynamic>> postMultipartAndGetJson(String endpoint, {Map<String, String>? fields, Map<String, File>? files});
  Future<T> postMultipartAndParseData<T>(String endpoint, T Function(Map<String, dynamic>) fromJson, {Map<String, String>? fields, Map<String, File>? files});

  // PUT
  Future<Map<String, dynamic>> putAndGetJson(String endpoint, Map<String, dynamic> body);
  Future<T> putAndParseData<T>(String endpoint, Map<String, dynamic> body, T Function(Map<String, dynamic>) fromJson);

  // DELETE
  Future<Map<String, dynamic>> deleteAndGetJson(String endpoint);
  Future<T> deleteAndParseData<T>(String endpoint, T Function(Map<String, dynamic>) fromJson);
}
```

### `HttpService` Class

```dart
class HttpService implements IHttpService {
  HttpService({
    String baseUrl = "",
    IAuthInterceptor? authInterceptor,
    Map<String, String>? headers,
    ILogger? logger,
    HttpCurlLogger curlLogger = const HttpCurlLogger(),
  });
}
```

## Testing

Mock the `IHttpService` interface for easy testing:

```dart
class MockHttpService implements IHttpService {
  @override
  Future<User> getAndParseData<User>(
    String path,
    User Function(Map<String, dynamic>) fromJson, {
    Map<String, dynamic>? queryParameters,
    String? dataKey,
    Map<String, String>? headers,
  }) async {
    return fromJson({'id': 1, 'name': 'Test User'});
  }

  // Implement other methods...
}
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
