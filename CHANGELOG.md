## Unreleased

* **Security:** `HttpService` no longer accepts every TLS certificate. The client set `badCertificateCallback` to always return `true`, so self-signed, expired or wrong-host certificates were accepted and anyone on the network path could read and alter requests. Certificates are now validated by the platform; an untrusted one fails with `HandshakeException`
* `HttpService(allowBadCertificates: true)` opts in to accepting untrusted certificates for local development; default `false`, and ignored in release builds
* **Security:** `GlobalSslConfig.configure()` no longer disables certificate validation by default (its parameter defaulted to `true`, turning checks off for every `HttpClient` in the app). It now needs an explicit `configure(true)` and is ignored in release builds
* `AuthInterceptor`: optional `onRefreshToken` to refresh an expired token before ending the session; concurrent requests share a single refresh, and requests made from `onRefreshToken` skip the check (no deadlock)
* `HttpService.getHeaders` now runs `authInterceptor.onRequest()` before every request (it was never called before)
* `AuthInterceptor` clears the stored token when the session ends, and treats a `getAuthToken` failure as "no token"
* `putAndParseData` / `patchAndParseData` no longer build the headers twice

## 1.1.0

* Add PATCH support: `patchAndGetCustomResponse`, `patchAndGetJson`, `patchAndParseData`
* Fix `putAndGetJson` logging the request as POST instead of PUT

## 1.0.0

* Initial release
* Features:
  - Complete HTTP client (GET, POST, PUT, DELETE)
  - Type-safe response parsing
  - Comprehensive error handling with custom exceptions for all HTTP status codes
  - Authentication interceptor support
  - CURL logging for debugging
  - Multipart file upload support
  - File download support
  - Custom headers per request or globally
  - Query parameters support
  - SSL configuration options
  - Built on top of http package
  - Uses simple_logger for logging
