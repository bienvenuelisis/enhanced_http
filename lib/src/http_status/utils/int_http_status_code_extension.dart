// Copyright (c) 2024, TECH-ANDGAR.
// All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// ignore_for_file: lines_longer_than_80_chars

/// Extension `IntHttpStatusCodeExtension` on [int]
///
/// This extension provides additional functionality to integer values,
/// allowing them to be easily checked against common HTTP status code ranges.
/// HTTP status codes are divided into five distinct classes, each representing
/// a type of response the server will send in answer to a client's request.
///
/// Usage of this extension simplifies checking the category of an HTTP status code
/// without needing to remember the specific ranges for each category. It extends
/// the built-in [int] type with simple, readable properties.
///
/// Examples:
/// ```dart
/// int statusCode = 200;
/// bool isSuccess = statusCode.isSuccessfulHttpStatusCode; // true
///
/// statusCode = 404;
/// bool isClientError = statusCode.isClientErrorHttpStatusCode; // true
/// ```
///
/// This makes your code cleaner and more expressive when handling HTTP responses.
extension IntHttpStatusCodeExtension on int {
  /// A utility method to check if the current integer is within a specified range.
  ///
  /// Takes [lower] as the lower bound and [upper] as the upper bound.
  /// Returns `true` if the current integer is within the bounds, inclusive.
  bool isBetween(int lower, int upper) => this >= lower && this <= upper;

  /// Checks if the integer represents an informational HTTP status code.
  ///
  /// An informational HTTP status code ranges from 100 to 199.
  /// Returns `true` if the current integer is within this range.
  bool get isInformationHttpStatusCode => isBetween(100, 199);

  /// Checks if the integer represents a successful HTTP status code.
  ///
  /// A successful HTTP status code ranges from 200 to 299.
  /// Returns `true` if the current integer is within this range.
  bool get isSuccessfulHttpStatusCode => isBetween(200, 299);

  /// Checks if the integer represents a redirection HTTP status code.
  ///
  /// A redirection HTTP status code ranges from 300 to 399.
  /// Returns `true` if the current integer is within this range.
  bool get isRedirectHttpStatusCode => isBetween(300, 399);

  /// Checks if the integer represents a client error HTTP status code.
  ///
  /// A client error HTTP status code ranges from 400 to 499.
  /// Returns `true` if the current integer is within this range.
  bool get isClientErrorHttpStatusCode => isBetween(400, 499);

  /// Checks if the integer represents a server error HTTP status code.
  ///
  /// A server error HTTP status code ranges from 500 to 599.
  /// Returns `true` if the current integer is within this range.
  bool get isServerErrorHttpStatusCode => isBetween(500, 599);
}
