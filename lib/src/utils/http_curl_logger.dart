import 'dart:convert';
import 'dart:developer' as d;

class HttpCurlLogger {
  const HttpCurlLogger();

  void log(
    String method,
    Uri uri,
    Map<String, String>? headers,
    // ignore: avoid_annotating_with_dynamic
    dynamic body,
  ) {
    try {
      d.log(_cURLRepresentation(method, uri, headers, body));
    } catch (err) {
      d.log('unable to create a CURL representation of the requestOptions');
    }
  }

  // ignore: inference_failure_on_untyped_parameter
  String _cURLRepresentation(
    String method,
    Uri uri,
    Map<String, String>? headers,
    // ignore: avoid_annotating_with_dynamic
    dynamic body,
  ) {
    final components = <String>['curl -i -k'];

    if (method.toUpperCase() != 'GET') {
      components.add('-X $method');
    }

    if (headers != null) {
      headers.forEach((k, v) {
        if (k != 'Cookie') {
          components.add('-H "$k: $v"');
        }
      });
    }

    if (body != null) {
      if (body is Map<String, dynamic>) {
        final data = json.encode(body).replaceAll('"', r'\"');

        components.add('-d "$data"');
      } else {
        components.add('-d "${jsonEncode(body)}"');
        d.log(body.toString());
        d.log(body.runtimeType.toString());
      }
    }

    components.add('"$uri"');

    return components.join(' \\\n\t');
  }
}
