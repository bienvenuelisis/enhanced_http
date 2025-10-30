// Copyright (c) 2014, Thomas Profelt
// Copyright (c) 2015, Günter Zöchbauer, Thomas Profelt
// Copyright (c) 2021, Diego Perez.
// Copyright (c) 2024, Andres Garcia (TECH-ANDGAR). All rights reserved.
// Use of this source code
// is governed by a Apache-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:meta/meta.dart';

import '../http_status/http_status.dart';
import 'custom/malformed_json_http_exception.dart';
import 'custom/socket_http_exception.dart';

/// {@template http_exception}
/// A base class for specific HTTP exception classes.
/// An optional [Map] named [data] can be provided to add additional
/// information as the response body.
/// {@endtemplate}
@immutable
class HttpException implements Exception {
  /// Constructs an [HttpException] with detailed information about the failure.
  ///
  /// - [httpStatus]: The HTTP status code associated with the exception.
  ///
  /// - [detail]: A human-readable message providing more details about the
  /// error.
  ///
  /// - [data]: Optional. Additional data about the exception. It can carry
  /// extra information pertinent to the error.
  ///
  /// - [uri]: Optional. The URI associated with the HTTP request that resulted
  /// in this error.
  const HttpException({
    required this.httpStatus,
    required this.detail,
    this.data,
    this.uri,
  });

  /// Additional data about the exception as a map.
  ///
  /// This can include any additional information pertinent to the error,
  /// such as error codes, nested messages, or other details that can help
  /// with debugging.
  final Map<String, dynamic>? data;

  /// A human-readable message providing more details about the error.
  ///
  /// This message can offer additional context about what went wrong,
  /// potentially including steps to resolve the issue or a more detailed
  /// explanation of the error.
  final String detail;

  /// The HTTP status code associated with the exception.
  ///
  /// This code corresponds to various HTTP status codes,
  /// such as 404 for Not Found, 403 for Forbidden, etc.
  /// It is used to identify the type of HTTP error that occurred.
  final HttpStatus httpStatus;

  /// The URI associated with the HTTP request that resulted in this error.
  ///
  /// This optional parameter can be useful for logging and debugging, helping
  /// identify the exact request that failed.
  final Uri? uri;

  /// Compares this HttpException instance to another object.
  ///
  /// Two instances of [HttpException] are considered equal if they have
  /// the same runtime type and [httpStatus].
  @override
  bool operator ==(covariant HttpException other) =>
      (identical(this, other)) ||
      runtimeType == other.runtimeType && other.httpStatus == httpStatus;

  /// Provides a hash code for this [HttpException] instance.
  ///
  /// The hash code is based on the [httpStatus] of the exception.
  @override
  int get hashCode => httpStatus.hashCode;

  /// Converts the [HttpException] to a [String] representation.
  ///
  /// This method returns a string that includes the HTTP status code,
  /// the error message, and optionally, the related URI and any additional
  /// HTTP data, making it useful for logging or debugging purposes.
  @override
  String toString() {
    final hasMessages = data?['messages'] is List;

    if (hasMessages) {
      return (data?['messages'] as List<dynamic>)
          .map((message) => _ensureUtf8Encoding(message.toString()))
          .join(', ');
    } else if (this is SocketHttpException) {
      return '''Impossible de se connecter au serveur. Veuillez vérifier votre connexion.''';
    } else if (this is MalformedJsonHttpException) {
      return '''Impossible de traiter la réponse du serveur. Veuillez réessayer plus tard.''';
    } else if (httpStatus.code == 400) {
      return '''Votre requête est invalide. Veuillez vérifier les données envoyées.''';
    } else if (httpStatus.code == 401) {
      return '''Accès non autorisé. Veuillez vérifier vos identifiants et vous reconnecter au cas échéant.''';
    } else if (httpStatus.code == 404) {
      return """La ressource demandée n'a pas été trouvée. Veuillez réessayer plus tard.""";
    } else if (httpStatus.code == 500) {
      return '''Erreur interne du serveur. Veuillez réessayer plus tard.''';
    } else if (data?['detail'] is String) {
      return _ensureUtf8Encoding(data!['detail'] as String);
    }

    return messageDetails;
  }

  /// Ensures proper UTF-8 encoding of a string that may have encoding issues.
  ///
  /// This method attempts to fix common UTF-8 encoding issues where special
  /// characters are double-encoded or incorrectly decoded.
  String _ensureUtf8Encoding(String input) {
    try {
      // Check if the string contains mojibake patterns typical
      //of UTF-8 encoding issues
      if (input.contains('Ã©') ||
          input.contains('Ã ') ||
          input.contains('Ã¨')) {
        // Try to re-encode as Latin-1 then decode as UTF-8
        final latin1Bytes = latin1.encode(input);
        return utf8.decode(latin1Bytes);
      }
      return input;
    } catch (e) {
      // If decoding fails, return the original string
      return input;
    }
  }

  String get messageDetails {
    final stringBuffer = StringBuffer()
      ..write('HttpException ')
      ..write('[')
      ..write('${httpStatus.code} ')
      ..write(httpStatus.name)
      ..write(']')
      ..write(detail != '' ? ': ${detail.trim()}' : '');

    if (uri != null) {
      stringBuffer.write(', uri = $uri');
    }

    if (data != null) {
      stringBuffer.write(', HTTP data = $data');
    }

    return stringBuffer.toString();
  }

  /// Converts the [HttpException] instance to a [Map].
  ///
  /// The resulting map includes keys for `statusCode`, `name`, `detail`,
  /// and `uri`,
  /// alongside any additional data provided through [data].
  /// This can be useful for serializing the exception details, e.g.,
  /// sending over network or saving in logs.
  ///
  /// Returns a [Map<String, dynamic>] representation of the [HttpException].
  Map<String, dynamic> toMap() => <String, dynamic>{
        'statusCode': httpStatus.code,
        'name': httpStatus.name,
        'detail': detail,
        'uri': uri?.toString(),
      }..addAll(data ?? <String, dynamic>{});
}
