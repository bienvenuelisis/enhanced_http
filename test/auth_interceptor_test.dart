import 'dart:convert';
import 'dart:io' hide HttpException;

import 'package:auth_token_service/auth_token_service.dart';
import 'package:enhanced_http/enhanced_http.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeTokenService implements IAuthTokenService {
  AuthTokenData? token;
  int sets = 0;
  bool throwWhenEmpty = false;
  int clears = 0;
  @override
  Future<AuthTokenData?> getAuthToken() async {
    if (token == null && throwWhenEmpty) throw Exception('No auth token found');
    return token;
  }

  @override
  Future<void> clearAuthToken() async {
    clears++;
    token = null;
  }

  @override
  Future<void> setAuthToken(AuthTokenData t) async {
    await Future<void>.delayed(const Duration(milliseconds: 5));
    sets++;
    token = t;
  }
}

/// Typical app subclass: adds the bearer token after super.getHeaders.
class AppHttpService extends HttpService {
  AppHttpService({
    required super.baseUrl,
    required this.tokens,
    super.authInterceptor,
  });
  final FakeTokenService tokens;
  int getHeadersCalls = 0;

  @override
  Future<Map<String, String>> getHeaders([
    Map<String, String>? additional,
  ]) async {
    getHeadersCalls++;
    final h = await super.getHeaders(additional);
    AuthTokenData? t;
    try {
      t = await tokens.getAuthToken();
    } catch (_) {}
    if (t != null) h['Authorization'] = 'Bearer ${t.token}';
    return h;
  }
}

AuthTokenData tk(String t, String? rt, {required bool expired}) =>
    AuthTokenData(
      token: t,
      refreshToken: rt,
      expiry: DateTime.now().add(Duration(hours: expired ? -1 : 1)),
    );

void main() {
  late HttpServer server;
  late List<String?> seenAuth;
  late List<String> seenMethods;
  var status = 200;

  setUp(() async {
    seenAuth = [];
    seenMethods = [];
    status = 200;
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    server.listen((req) async {
      await utf8.decoder.bind(req).join();
      seenAuth.add(req.headers.value('authorization'));
      seenMethods.add(req.method);
      req.response
        ..statusCode = status
        ..headers.contentType = ContentType.json
        ..write(jsonEncode({'ok': true, 'name': 'x'}));
      await req.response.close();
    });
  });
  tearDown(() => server.close(force: true));

  String base() => 'http://127.0.0.1:${server.port}';

  ({AppHttpService http, FakeTokenService tokens, List<String> calls}) build({
    AuthTokenData? token,
    Future<AuthTokenData?> Function(String)? onRefresh,
    bool withRefresh = true,
  }) {
    final tokens = FakeTokenService()..token = token;
    final calls = <String>[];
    final interceptor = AuthInterceptor(
      tokenService: tokens,
      onTokenExpired: () => calls.add('expired'),
      onRefreshToken: withRefresh
          ? (rt) async {
              calls.add('refresh:$rt');
              await Future<void>.delayed(const Duration(milliseconds: 30));
              if (onRefresh == null) return tk('new', 'r2', expired: false);
              return onRefresh(rt);
            }
          : null,
    );
    return (
      http: AppHttpService(
        baseUrl: base(),
        tokens: tokens,
        authInterceptor: interceptor,
      ),
      tokens: tokens,
      calls: calls,
    );
  }

  test('no token: request is sent without refresh (login flow)', () async {
    final b = build();
    final r = await b.http.postAndGetJson('/auth/verify', {'code': '1'});
    expect(r['ok'], true);
    expect(seenAuth, [null]);
    expect(b.calls, isEmpty);
  });

  test('valid token: sent as is, no refresh', () async {
    final b = build(token: tk('old', 'r1', expired: false));
    await b.http.getJson('/me');
    expect(seenAuth, ['Bearer old']);
    expect(b.calls, isEmpty);
  });

  test('expired token: refreshed before sending, new token used', () async {
    final b = build(token: tk('old', 'r1', expired: true));
    await b.http.getJson('/me');
    expect(seenAuth, ['Bearer new']);
    expect(b.calls, ['refresh:r1']);
    expect(b.tokens.sets, 1);
  });

  test('concurrent requests share a single refresh', () async {
    final b = build(token: tk('old', 'r1', expired: true));
    await Future.wait([
      b.http.getJson('/a'),
      b.http.postAndGetJson('/b', {}),
      b.http.patchAndGetJson('/members/me', {'firstName': 'J'}),
      b.http.putAndGetJson('/c', {}),
      b.http.deleteAndGetJson('/d'),
    ]);
    expect(seenAuth, everyElement('Bearer new'));
    expect(seenAuth, hasLength(5));
    expect(b.calls, ['refresh:r1']);
    expect(b.tokens.sets, 1);
  });

  test(
    'refresh returns null: request not sent, Unauthorized, expired once',
    () async {
      final b = build(
        token: tk('old', 'r1', expired: true),
        onRefresh: (_) async => null,
      );
      final results = await Future.wait(
        List.generate(3, (_) async {
          try {
            await b.http.getJson('/me');
            return 'ok';
          } on UnauthorizedHttpException {
            return 'unauthorized';
          }
        }),
      );
      expect(results, everyElement('unauthorized'));
      expect(seenAuth, isEmpty);
      expect(b.calls, ['refresh:r1', 'expired']);
    },
  );

  test('refresh throws: Unauthorized, expired once', () async {
    final b = build(
      token: tk('old', 'r1', expired: true),
      onRefresh: (_) async => throw const SocketException('down'),
    );
    await expectLater(
      b.http.getJson('/me'),
      throwsA(isA<UnauthorizedHttpException>()),
    );
    expect(seenAuth, isEmpty);
    expect(b.calls, ['refresh:r1', 'expired']);
  });

  test('after failed refresh, a new refresh can be attempted', () async {
    var attempt = 0;
    final b = build(
      token: tk('old', 'r1', expired: true),
      onRefresh: (_) async =>
          ++attempt == 1 ? null : tk('new', 'r2', expired: false),
    );
    await expectLater(
      b.http.getJson('/me'),
      throwsA(isA<UnauthorizedHttpException>()),
    );
    b.tokens.token = tk('old', 'r1', expired: true);
    await b.http.getJson('/me');
    expect(seenAuth, ['Bearer new']);
  });

  test(
    'no onRefreshToken + expired: Unauthorized, expired, not sent',
    () async {
      final b = build(
        token: tk('old', 'r1', expired: true),
        withRefresh: false,
      );
      await expectLater(
        b.http.getJson('/me'),
        throwsA(isA<UnauthorizedHttpException>()),
      );
      expect(seenAuth, isEmpty);
      expect(b.calls, ['expired']);
    },
  );

  test(
    'expired without refresh token: Unauthorized, no refresh call',
    () async {
      final b = build(token: tk('old', null, expired: true));
      await expectLater(
        b.http.getJson('/me'),
        throwsA(isA<UnauthorizedHttpException>()),
      );
      expect(b.calls, ['expired']);
    },
  );

  test('server 401 still goes through onError', () async {
    final b = build(token: tk('old', 'r1', expired: false));
    status = 401;
    await expectLater(
      b.http.getJson('/me'),
      throwsA(isA<UnauthorizedHttpException>()),
    );
    await Future<void>.delayed(Duration.zero);
    expect(b.calls, ['expired']);
  });

  test('put/patch AndParseData call getHeaders once per request', () async {
    final b = build(token: tk('old', 'r1', expired: false));
    await b.http.putAndParseData('/u', {}, (j) => j['name']);
    await b.http.patchAndParseData('/u', {}, (j) => j['name']);
    expect(b.http.getHeadersCalls, 2);
    expect(seenMethods, ['PUT', 'PATCH']);
  });

  test('multipart gets refreshed token too', () async {
    final b = build(token: tk('old', 'r1', expired: true));
    await b.http.postMultipartAndGetJson('/upload', fields: {'a': 'b'});
    expect(seenAuth, ['Bearer new']);
  });

  test('HttpService without interceptor still works', () async {
    final http = HttpService(baseUrl: base());
    final r = await http.getJson('/x');
    expect(r['ok'], true);
  });

  test(
    'getAuthToken throwing (memory impl, no token): request still sent',
    () async {
      final b = build();
      b.tokens.throwWhenEmpty = true;
      final r = await b.http.postAndGetJson('/auth/login', {});
      expect(r['ok'], true);
      expect(seenAuth, [null]);
    },
  );

  test(
    'failed refresh clears token: next request (login) goes through',
    () async {
      final b = build(
        token: tk('old', 'r1', expired: true),
        onRefresh: (_) async => null,
      );
      await expectLater(
        b.http.getJson('/me'),
        throwsA(isA<UnauthorizedHttpException>()),
      );
      expect(b.tokens.clears, 1);
      final r = await b.http.postAndGetJson('/auth/login', {});
      expect(r['ok'], true);
      expect(seenAuth, [null]);
    },
  );

  test('real MemoryStorageAuthTokenService works end to end', () async {
    final tokens = MemoryStorageAuthTokenService();
    var expired = 0;
    final http = HttpService(
      baseUrl: base(),
      authInterceptor: AuthInterceptor(
        tokenService: tokens,
        onTokenExpired: () => expired++,
        onRefreshToken: (rt) async => tk('new', 'r2', expired: false),
      ),
    );
    await http.getJson('/no-token');
    await tokens.setAuthToken(tk('old', 'r1', expired: true));
    await http.getJson('/refresh');
    expect((await tokens.getAuthToken()).token, 'new');
    expect(expired, 0);
  });

  test('onRefreshToken may use the same HttpService (no deadlock)', () async {
    final tokens = FakeTokenService()..token = tk('old', 'r1', expired: true);
    late AppHttpService http;
    http = AppHttpService(
      baseUrl: base(),
      tokens: tokens,
      authInterceptor: AuthInterceptor(
        tokenService: tokens,
        onTokenExpired: () {},
        onRefreshToken: (rt) async {
          await http.postAndGetJson('/auth/refresh', {'refreshToken': rt});
          return tk('new', 'r2', expired: false);
        },
      ),
    );
    await http.getJson('/me').timeout(const Duration(seconds: 5));
    expect(seenAuth, ['Bearer old', 'Bearer new']);
  });
}
