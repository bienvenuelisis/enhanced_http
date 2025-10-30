// Copyright (c) 2024, Andres Garcia (TECH-ANDGAR). All rights reserved.
// Use of this source code
// is governed by a Apache-style license that can be found in the LICENSE file.

import '../../http_status/http_status.dart';
import '../http_exception_base.dart';
import 'extensions.dart';

/// An extension on the [int] type to facilitate the creation of
/// [HttpException] instances based on HTTP status codes.
extension IntHttpStatusExtension on int {
  /// This extension allows for a streamlined way to instantiate
  /// [HttpException] objects directly from integer status codes.
  /// It leverages the [HttpStatus.fromCode] method to create the
  /// corresponding [HttpException] for the given status code.
  /// Additional details such as a custom message, data payload,
  /// and URI can be optionally provided.
  ///
  /// Example Usage:
  /// ```dart
  /// final exception = 404.exception(detail: 'Not Found', uri: Uri.parse('https://example.com'));
  /// print(exception); // Outputs the generated HttpException for a 404 status code.
  /// ```
  ///
  /// Parameters:
  /// - [detail]: A string providing additional details about the exception.
  /// This detail message can be used to give more context about the error
  /// that occurred. It defaults to an empty string if no detail is provided.
  ///
  /// - [data]: An optional map of key-value pairs that can contain any
  /// additional data you want to associate with the exception.
  /// This can be useful for passing structured error information that can
  /// be programmatically processed. Defaults to `null` if no data is provided.
  ///
  /// - [uri]: An optional [Uri] object indicating the URI associated
  /// with the exception.
  /// This can be particularly useful for logging or tracing requests
  /// that resulted in an error. Defaults to `null` if no URI is provided.
  ///
  /// Returns:
  /// A [HttpException] object that corresponds to the HTTP status code
  /// it's called on, populated with any provided details, data, and URI.
  HttpException exception({
    String detail = '',
    Map<String, dynamic>? data,
    Uri? uri,
  }) {
    final httpStatus = HttpStatus.fromCode(
      this,
    ).exception(detail: detail, data: data, uri: uri);

    return httpStatus;
  }
}
