## Unreleased

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
