import 'dart:convert';
import 'dart:io';

import 'package:enhanced_http/enhanced_http.dart';
import 'package:flutter_test/flutter_test.dart';

// Throwaway self-signed certificate and key, generated for this test only.
// Nothing trusts them; they stand in for a man-in-the-middle server.
const _cert = '''
-----BEGIN CERTIFICATE-----
MIIDGzCCAgOgAwIBAgIUVneLiDCBhKCTZg0fqS2+fLvM34EwDQYJKoZIhvcNAQEL
BQAwHDEaMBgGA1UEAwwRdW50cnVzdGVkLmludmFsaWQwIBcNMjYxMTExMTczMTM4
WhgPMjEyNjEwMTgxNzMxMzhaMBwxGjAYBgNVBAMMEXVudHJ1c3RlZC5pbnZhbGlk
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3KNzY6u+06u8QdfnHz0i
YNb2V9DoF0hP3nvsLMUbHBa2YlEEzkY9Pgxijua1N9JSHIenduZJQWldmibooJ6A
zR+oHiGg26+JLqxlpigvswh9PIEDqu9ZnfmoMpM1SFHNXSR2Gv1J1NafZaRI4+IQ
5RvrOLmM68s1bKf074/4kQlzz5+qpw5tb2p6ofGSMi7wQIhaJyzvICS297tGVjO5
6XzXglTE0Ujf5w/PlrlOyTtlFYrcnPExw0lj63elnaMZsT4t+zzir7Qn0V6+Ld40
V/IS612w6zugLFUdP2R7w/nds4uvAzhES3EXJhMv9t0qdZ+tDlw7Bbmq79m/JTnI
tQIDAQABo1MwUTAdBgNVHQ4EFgQUEhCmqoN2Wi4GXcnyT8My7hsf3lgwHwYDVR0j
BBgwFoAUEhCmqoN2Wi4GXcnyT8My7hsf3lgwDwYDVR0TAQH/BAUwAwEB/zANBgkq
hkiG9w0BAQsFAAOCAQEAN++EUCJaFK6uhNq4KIH53YgJdKuj9c3iU+oQmtjEDUC/
TyRPF7dY5mR0jP7ESAokVWO97o1AlSqa/j0f0oy3jq1vErbHKVrUpTHpW3ViBURp
E3z5rb51x74JU/I3sVp9zybMcgPR5fmolCD35u2v68ySWQvLZLmUSdRtHxg+HXbS
zaZKT8+d2/nOTmfDJhMFMhbX7uXuXy3KXIqVzKofAEsp/EgjkzN60a72zzF7pIin
m5bB6DyoW1UZlcVsxRhvYzjt5aKMQr1W5YE5O97kolY5RptWJaUKyujqhuQcjw4M
WSzj3/6ExHyYE6gIuy4LpeAOv4W9lUJNIvEq1g7H0g==
-----END CERTIFICATE-----
''';

const _key = '''
-----BEGIN PRIVATE KEY-----
MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDco3Njq77Tq7xB
1+cfPSJg1vZX0OgXSE/ee+wsxRscFrZiUQTORj0+DGKO5rU30lIch6d25klBaV2a
JuignoDNH6geIaDbr4kurGWmKC+zCH08gQOq71md+agykzVIUc1dJHYa/UnU1p9l
pEjj4hDlG+s4uYzryzVsp/Tvj/iRCXPPn6qnDm1vanqh8ZIyLvBAiFonLO8gJLb3
u0ZWM7npfNeCVMTRSN/nD8+WuU7JO2UVityc8THDSWPrd6WdoxmxPi37POKvtCfR
Xr4t3jRX8hLrXbDrO6AsVR0/ZHvD+d2zi68DOERLcRcmEy/23Sp1n60OXDsFuarv
2b8lOci1AgMBAAECggEABXf/rWH3MhcfOW3FvfgT8naH8JeuL2i/1T6yrrSYywXW
sdhapPChjMVd0NDv5b+CALcHQMkzptPOJoeXjubSDN0fm6LI8k9thQlwE46kPNNi
Pa4TWzJ6wPgMYgSIEFzTf3i4SX74GR06VWVqPeVY9qgBTCY9OfL1eTxiGjX+7glU
I2j5ECXMcEYKjtPfPH1+wLPBU/1KDYplwxL8ID2DIyPi/z+HtM/yVzfGbEfKy+8d
kL3xn+auJ/5btc8vL8Jm+rAUs6k7hnIHRZai+Os8/LvqLUpRTmyrZSq3lz7e3svV
GTD7FSZaECC3g/TqMuzwdUCEWjy8qv7DCpghi5BhmQKBgQD8o3nqn8OuBmb1lp5L
mchID/48eOGtahoXEeXgKT1oGVT6qMjuA9RrYZG5rN2XyYTu58odMy6oaM7qgh8g
EQe6/F6sGseJo1vZenDvNwoIAHhlK5e/ycxZTV+vXfwrbe3XJdtYbbLnzR2yAQsE
g2WeNGd74R/YeR/BHSeCFSGmrwKBgQDfkvo97eCv9FENYtF4FiyHULw6FqbYXmjq
DS2XFvSnEIvB4Sdk5plXFoa3KFvUKneAefsgdD1DhsbMN8hSRrLknjOCCyVanKXT
OO/dB1/x2KAdY8jv0OAEtMSk2ygva16PT+YBBSAeg4+nOqY/BKeeEIasrTjGcdYs
LZoy5g8f2wKBgGQSvXBa6MA+ePo/N2Tq/ZLOAv8hQwPWS49n347zxwc9QZQo166w
hawjcf4Co6REhwu7dSwr4geDvLLX6ExjcpR282lpEjFLLE7xWVroimixBv/MTMgD
v5aAN67Xo9PwL45RyJk2mu+HKIQiNaMMCWyphXRksKCnGhT833F/vVyxAoGAQJoe
tvBagV1OYljQgCugGEWK7hoHgfPdyuud5c+bR/7u80nU8UH0wwZeTORbjHXs6/HT
T7Bm13FFVlM0DhohrQ/NgGEqHQGwpNUJ8kskPSTEN1nTAQDRCmsVezFcbj9PJogG
xPqvKkIHq2G2EfWNXY4W7CRtiGHyafePW+/AJQsCgYA0qkWcYlezuWvMIdSxmtDq
A99gNiHAHTEE/RkyAqdx9IGsb0IIy+UF1Z6osDYdghZ11zHWNkRbV3qIjFvXyQyR
mf98aXdTfCryKZyQ1S8MvyRfwDfXfs7AkhgtX3ouJIdniGh+wOAIYVCPf94TCbRt
cbd1WyECeb7MSEO9fI7bxQ==
-----END PRIVATE KEY-----
''';

void main() {
  late HttpServer server;
  late List<String> received;

  setUp(() async {
    received = [];
    final context = SecurityContext()
      ..useCertificateChainBytes(utf8.encode(_cert))
      ..usePrivateKeyBytes(utf8.encode(_key));
    server = await HttpServer.bindSecure(
      InternetAddress.loopbackIPv4,
      0,
      context,
    );
    server.listen(
      (request) async {
        received.add('${request.method} ${request.uri}');
        request.response
          ..headers.contentType = ContentType.json
          ..write(jsonEncode({'forged': true}));
        await request.response.close();
      },
      onError: (_) {},
    );
  });

  tearDown(() => server.close(force: true));

  test('rejects a server with an untrusted certificate', () async {
    final http = HttpService(
      baseUrl: 'https://127.0.0.1:${server.port}',
      headers: {'Authorization': 'Bearer secret'},
    );

    await expectLater(
      http.postAndGetJson('/auth/verify', {'code': '1234'}),
      throwsA(isA<HandshakeException>()),
    );
    expect(received, isEmpty);
  });

  test('allowBadCertificates lets a debug build reach the server', () async {
    final http = HttpService(
      baseUrl: 'https://127.0.0.1:${server.port}',
      allowBadCertificates: true,
    );

    final response = await http.getJson('/dev');

    expect(response['forged'], true);
    expect(received, ['GET /dev']);
  });

  test('allowBadCertificates is refused in release mode', () {
    expect(
      HttpService.acceptsBadCertificates(
        allowBadCertificates: true,
        releaseMode: true,
      ),
      isFalse,
    );
    expect(
      HttpService.acceptsBadCertificates(
        allowBadCertificates: true,
        releaseMode: false,
      ),
      isTrue,
    );
    expect(
      HttpService.acceptsBadCertificates(
        allowBadCertificates: false,
        releaseMode: false,
      ),
      isFalse,
    );
  });
}
