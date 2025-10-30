// Copyright (c) 2017, Era Productions.
// Copyright (c) 2024, TECH-ANDGAR.
// All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/// HTTP Status Codes.
abstract class HttpStatusCode {
  /// {@template http_status_code_100_continue_}
  /// **continue_ = 100**.
  ///
  /// This interim response indicates that everything so far is OK
  /// and that the client should continue with the request or
  /// ignore it if it is already finished.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.2.1
  ///
  /// {@endtemplate}
  static const int continue_ = 100;

  /// {@template http_status_code_101_switchingProtocols}
  /// **switchingProtocols = 101**.
  ///
  /// This code is sent in response to an Upgrade request header by the client,
  /// and indicates the protocol the server is switching too.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.2.2
  ///
  /// {@endtemplate}
  static const int switchingProtocols = 101;

  /// {@template http_status_code_102_processing}
  /// **processing = 102**.
  ///
  /// This code indicates that the server has received and is processing
  /// the request, but no response is available yet.
  ///
  /// https://tools.ietf.org/html/rfc2518#section-10.1
  ///
  /// {@endtemplate}
  static const int processing = 102;

  /// {@template http_status_code_103_earlyHints}
  /// **earlyHints = 103**.
  ///
  /// This code indicates that the server is likely to send a final response
  /// with the headers included in this informational response,
  /// but is still processing the request.
  /// This allows the client to start processing the headers early.
  ///
  /// **RFC 8297:** https://tools.ietf.org/html/rfc8297
  ///
  /// {@endtemplate}
  static const int earlyHints = 103;

  /// {@template http_status_code_200_ok}
  /// **ok = 200**.
  ///
  /// The request has succeeded. The meaning of a success varies
  /// depending on the HTTP method:
  ///
  /// GET: The resource has been fetched and is transmitted in the message body.
  ///
  /// HEAD: The entity headers are in the message body.
  ///
  /// POST: The resource describing the result of the action is transmitted in
  /// the message body.
  ///
  /// TRACE: The message body contains the request message as received by the
  /// server
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.3.1
  ///
  /// {@endtemplate}
  static const int ok = 200;

  /// {@template http_status_code_201_created}
  /// **created = 201**.
  ///
  /// The request has succeeded and a new resource has been created
  /// as a result of it. This is typically the response sent
  /// after a PUT request.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.3.2
  ///
  /// {@endtemplate}
  static const int created = 201;

  /// {@template http_status_code_202_accepted}
  /// **accepted = 202**.
  ///
  /// The request has been received but not yet acted upon.
  /// It is non-committal, meaning that there is no way in HTTP to later send
  /// an asynchronous response indicating the outcome of processing the request.
  /// It is intended for cases where another process or server handles
  /// the request, or for batch processing.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.3.3
  ///
  /// {@endtemplate}
  static const int accepted = 202;

  /// {@template http_status_code_203_nonAuthoritativeInformation}
  /// **nonAuthoritativeInformation = 203**.
  ///
  /// This response code means returned meta-information set
  /// is not exact set as available from the origin server, but collected
  /// from a local or a third party copy.
  ///
  /// Except this condition, 200 OK response should be preferred
  /// instead of this response.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.3.4
  ///
  /// {@endtemplate}
  static const int nonAuthoritativeInformation = 203;

  /// {@template http_status_code_204_noContent}
  /// **noContent = 204**.
  ///
  /// There is no content to send for this request, but the headers
  /// may be useful. The user-agent may update its cached headers
  /// for this resource with the new ones.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.3.5
  ///
  /// {@endtemplate}
  static const int noContent = 204;

  /// {@template http_status_code_205_resetContent}
  /// **resetContent = 205**.
  ///
  /// This response code is sent after accomplishing request to tell
  /// user agent reset document view which sent this request.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.3.6
  ///
  /// {@endtemplate}
  static const int resetContent = 205;

  /// {@template http_status_code_206_partialContent}
  /// **partialContent = 206**.
  ///
  /// This response code is used because of range header sent by the client
  /// to separate download into multiple streams.
  ///
  /// https://tools.ietf.org/html/rfc7233#section-4.1
  ///
  /// {@endtemplate}
  static const int partialContent = 206;

  /// {@template http_status_code_207_multiStatus}
  /// **multiStatus = 207**.
  ///
  /// A Multi-Status response conveys information about multiple resources
  /// in situations where multiple status codes might be appropriate.
  ///
  /// https://tools.ietf.org/html/rfc2518#section-10.2
  ///
  /// {@endtemplate}
  static const int multiStatus = 207;

  /// {@template http_status_code_208_alreadyReported}
  /// **alreadyReported = 208**.
  ///
  /// This status code is used to indicate that the members of a DAV binding
  /// have already been enumerated in a previous reply to this request,
  /// and are not being included again.
  ///
  /// https://tools.ietf.org/html/rfc5842#section-7.1
  ///
  /// {@endtemplate}
  static const int alreadyReported = 208;

  /// {@template http_status_code_226_imUsed}
  /// **imUsed = 226**.
  ///
  /// This code is used in a response to a method invocation on a resource to
  /// indicate that the resource was successfully created and that the server
  /// has returned a representation of the result of that creation.
  ///
  /// https://tools.ietf.org/html/rfc3229#section-10.4.1
  ///
  /// {@endtemplate}
  static const int imUsed = 226;

  /// {@template http_status_code_300_multipleChoices}
  /// **multipleChoices = 300**.
  ///
  /// The request has more than one possible responses.
  /// User-agent or user should choose one of them.
  ///
  /// There is no standardized way to choose one of the responses.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.4.1
  ///
  /// {@endtemplate}
  static const int multipleChoices = 300;

  /// {@template http_status_code_301_movedPermanently}
  /// **movedPermanently = 301**.
  ///
  /// This response code means that URI of requested resource has been changed.
  /// Probably, new URI would be given in the response.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.4.2
  ///
  /// {@endtemplate}
  static const int movedPermanently = 301;

  /// {@template http_status_code_302_found}
  /// **found = 302**.
  ///
  /// This response code means that URI of requested resource has been
  /// changed temporarily. New changes in the URI might be made in the future.
  /// Therefore, this same URI should be used by the client in future requests.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.4.3
  ///
  /// {@endtemplate}
  static const int found = 302;

  /// {@template http_status_code_302_movedTemporarily}
  /// **movedTemporarily = 302**.
  ///
  /// This response code means that URI of requested resource has been
  /// changed temporarily. New changes in the URI might be made in the future.
  /// Therefore, this same URI should be used by the client in future requests.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.4.3
  ///
  /// {@endtemplate}
  static const int movedTemporarily = 302;

  /// {@template http_status_code_303_seeOther}
  /// **seeOther = 303**.
  ///
  /// Server sent this response to directing client to get requested resource
  /// to another URI with an GET request.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.4.4
  ///
  /// {@endtemplate}
  static const int seeOther = 303;

  /// {@template http_status_code_304_notModified}
  /// **notModified = 304**.
  ///
  /// This is used for caching purposes. It is telling to client that
  /// response has not been modified. So, client can continue to use
  /// same cached version of response.
  ///
  /// https://tools.ietf.org/html/rfc7232#section-4.1
  ///
  /// {@endtemplate}
  static const int notModified = 304;

  /// {@template http_status_code_305_useProxy}
  /// **useProxy = 305**.
  ///
  /// @deprecated
  /// Was defined in a previous version of the HTTP specification to indicate
  /// that a requested response must be accessed by a proxy.
  ///
  /// It has been deprecated due to security concerns regarding
  /// in-band configuration of a proxy.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.4.6
  ///
  /// {@endtemplate}
  static const int useProxy = 305;

  /// {@template http_status_code_307_temporaryRedirect}
  /// **temporaryRedirect = 307**.
  ///
  /// Server sent this response to directing client to get requested resource
  /// to another URI with same method that used prior request.
  ///
  /// This has the same semantic than the 302 Found HTTP response code,
  /// with the exception that the user agent must not change
  /// the HTTP method used:
  ///
  /// if a POST was used in the first request, a POST must be used
  /// in the second request.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.4.7
  ///
  /// {@endtemplate}
  static const int temporaryRedirect = 307;

  /// {@template http_status_code_308_permanentRedirect}
  /// **permanentRedirect = 308**.
  ///
  /// This means that the resource is now permanently located at another URI,
  /// specified by the Location: HTTP Response header.
  ///
  /// This has the same semantics as the 301 Moved Permanently HTTP
  /// response code, with the exception that the user agent must not change
  /// the HTTP method used: if a POST was used in the first request,
  /// a POST must be used in the second request.
  ///
  /// https://tools.ietf.org/html/rfc7538#section-3
  ///
  /// {@endtemplate}
  static const int permanentRedirect = 308;

  /// {@template http_status_code_400_badRequest}
  /// **badRequest = 400**.
  ///
  /// This response means that server could not understand
  /// the request due to invalid syntax.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.5.1
  ///
  /// {@endtemplate}
  static const int badRequest = 400;

  /// {@template http_status_code_401_unauthorized}
  /// **unauthorized = 401**.
  ///
  /// Although the HTTP standard specifies "unauthorized", semantically
  /// this response means "unauthenticated". That is, the client must
  /// authenticate itself to get the requested response.
  ///
  /// https://tools.ietf.org/html/rfc7235#section-3.1
  ///
  /// {@endtemplate}
  static const int unauthorized = 401;

  /// {@template http_status_code_402_paymentRequired}
  /// **paymentRequired = 402**.
  ///
  /// This response code is reserved for future use. Initial aim for creating
  /// this code was using it for digital payment systems
  /// however this is not used currently.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.5.2
  ///
  /// {@endtemplate}
  static const int paymentRequired = 402;

  /// {@template http_status_code_403_forbidden}
  /// **forbidden = 403**.
  ///
  /// The client does not have access rights to the content, i.e.
  /// they are unauthorized, so server is rejecting to give proper response.
  /// Unlike 401, the client's identity is known to the server.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.5.3
  ///
  /// {@endtemplate}
  static const int forbidden = 403;

  /// {@template http_status_code_404_notFound}
  /// **notFound = 404**.
  ///
  /// The server can not find requested resource.
  ///
  /// In the browser, this means the URL is not recognized.
  /// In an API, this can also mean that the endpoint is valid but
  /// the resource itself does not exist.
  ///
  /// Servers may also send this response instead of 403 to hide
  /// the existence of a resource from an unauthorized client.
  ///
  /// This response code is probably the most famous one due to
  /// its frequent occurence on the web.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.5.4
  ///
  /// {@endtemplate}
  static const int notFound = 404;

  /// {@template http_status_code_405_methodNotAllowed}
  /// **methodNotAllowed = 405**.
  ///
  /// The request method is known by the server but has been disabled
  /// and cannot be used. For example, an API may forbid DELETE-ing a resource.
  /// The two mandatory methods, GET and HEAD, must never be disabled and
  /// should not return this error code.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.5.5
  ///
  /// {@endtemplate}
  static const int methodNotAllowed = 405;

  /// {@template http_status_code_406_notAcceptable}
  /// **notAcceptable = 406**.
  ///
  /// This response is sent when the web server, after performing
  /// server-driven content negotiation, doesn't find any content
  /// following the criteria given by the user agent.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.5.6
  ///
  /// {@endtemplate}
  static const int notAcceptable = 406;

  /// {@template http_status_code_407_proxyAuthenticationRequired}
  /// **proxyAuthenticationRequired = 407**.
  ///
  /// This is similar to 401 but authentication is needed to be done by a proxy.
  ///
  /// https://tools.ietf.org/html/rfc7235#section-3.2
  ///
  /// {@endtemplate}
  static const int proxyAuthenticationRequired = 407;

  /// {@template http_status_code_408_requestTimeout}
  /// **requestTimeout = 408**.
  ///
  /// This response is sent on an idle connection by some servers,
  /// even without any previous request by the client.
  ///
  /// It means that the server would like to shut down this unused connection.
  ///
  /// This response is used much more since some browsers, like Chrome,
  /// Firefox 27+, or IE9, use HTTP pre-connection mechanisms
  /// to speed up surfing.
  ///
  /// Also note that some servers merely shut down the connection
  /// without sending this message.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.5.7
  ///
  /// {@endtemplate}
  static const int requestTimeout = 408;

  /// {@template http_status_code_409_conflict}
  /// **conflict = 409**.
  ///
  /// This response is sent when a request conflicts with
  /// the current state of the server.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.5.8
  ///
  /// {@endtemplate}
  static const int conflict = 409;

  /// {@template http_status_code_410_gone}
  /// **gone = 410**.
  ///
  /// This response would be sent when the requested content has been
  /// permenantly deleted from server, with no forwarding address.
  ///
  /// Clients are expected to remove their caches and links to the resource.
  ///
  /// The HTTP specification intends this status code to be used for
  /// "limited-time, promotional services".
  ///
  /// APIs should not feel compelled to indicate resources that have been
  /// deleted with this status code.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.5.9
  ///
  /// {@endtemplate}
  static const int gone = 410;

  /// {@template http_status_code_411_lengthRequired}
  /// **lengthRequired = 411**.
  ///
  /// The server rejected the request because the Content-Length header
  /// field is not defined and the server requires it.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.5.10
  ///
  /// {@endtemplate}
  static const int lengthRequired = 411;

  /// {@template http_status_code_412_preconditionFailed}
  /// **preconditionFailed = 412**.
  ///
  /// The client has indicated preconditions in its headers
  /// which the server does not meet.
  ///
  /// https://tools.ietf.org/html/rfc7232#section-4.2
  ///
  /// {@endtemplate}
  static const int preconditionFailed = 412;

  /// {@template http_status_code_413_requestEntityTooLarge}
  /// **requestEntityTooLarge = 413**.
  ///
  /// Request entity is larger than limits defined by server; the server
  /// might close the connection or return an Retry-After header field.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.5.11
  ///
  /// {@endtemplate}
  static const int requestEntityTooLarge = 413;

  /// {@template http_status_code_414_requestUriTooLong}
  /// **requestUriTooLong = 414**.
  ///
  /// The URI requested by the client is longer than the server is
  /// willing to interpret.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.5.12
  ///
  /// {@endtemplate}
  static const int requestUriTooLong = 414;

  /// {@template http_status_code_415_unsupportedMediaType}
  /// **unsupportedMediaType = 415**.
  ///
  /// The media format of the requested data is not supported by the server,
  /// so the server is rejecting the request.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.5.13
  ///
  /// {@endtemplate}
  static const int unsupportedMediaType = 415;

  /// {@template http_status_code_416_requestedRangeNotSatisfiable}
  /// **requestedRangeNotSatisfiable = 416**.
  ///
  /// The range specified by the Range header field in the request
  /// can't be fulfilled; it's possible that the range is outside
  /// the size of the target URI's data.
  ///
  /// https://tools.ietf.org/html/rfc7233#section-4.4
  ///
  /// {@endtemplate}
  static const int requestedRangeNotSatisfiable = 416;

  /// {@template http_status_code_417_expectationFailed}
  /// **expectationFailed = 417**.
  ///
  /// This response code means the expectation indicated by the Expect
  /// request header field can't be met by the server.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.5.14
  ///
  /// {@endtemplate}
  static const int expectationFailed = 417;

  /// {@template http_status_code_418_imATeapot}
  /// **imATeapot = 418**.
  ///
  /// Any attempt to brew coffee with a teapot should result in
  /// the error code "418 I'm a teapot".
  ///
  /// The resulting entity body MAY be short and stout.
  ///
  /// https://tools.ietf.org/html/rfc2324#section-2.3.2
  ///
  /// {@endtemplate}
  static const int imATeapot = 418;

  /// {@template http_status_code_419_insufficientSpaceOnResource}
  /// **insufficientSpaceOnResource = 419**.
  ///
  /// The 507 (Insufficient Storage) status code means the method could not
  /// be performed on the resource because the server is unable to store
  /// the representation needed to successfully complete the request.
  ///
  /// This condition is considered to be temporary.
  ///
  /// If the request which received this status code was the result
  /// of a user action, the request MUST NOT be repeated until
  /// it is requested by a separate user action.
  ///
  /// https://tools.ietf.org/html/rfc2518#section-10.6
  ///
  /// {@endtemplate}
  static const int insufficientSpaceOnResource = 419;

  /// {@template http_status_code_420_methodFailure}
  /// **methodFailure = 420**.
  ///
  /// @deprecated
  /// A deprecated response used by the Spring Framework when a method has
  /// failed.
  ///
  /// https://tools.ietf.org/rfcdiff?difftype=--hwdiff&url2=draft-ietf-webdav-protocol-06.txt
  ///
  /// {@endtemplate}
  static const int methodFailure = 420;

  /// {@template http_status_code_421_misdirectedRequest}
  /// **misdirectedRequest = 421**.
  ///
  /// This response code is used in a situation where the server is not able to
  /// produce a response for the request that has been received. This might be
  /// possible if a connection is reused or if an alternative service
  /// is selected.
  ///
  /// https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/421
  ///
  /// {@endtemplate}
  static const int misdirectedRequest = 421;

  /// {@template http_status_code_422_unprocessableEntity}
  /// **unprocessableEntity = 422**.
  ///
  /// The request was well-formed but was unable to be followed
  /// due to semantic errors.
  ///
  /// https://tools.ietf.org/html/rfc2518#section-10.3
  ///
  /// {@endtemplate}
  static const int unprocessableEntity = 422;

  /// {@template http_status_code_423_locked}
  /// **locked = 423**.
  ///
  /// The resource that is being accessed is locked.
  ///
  /// https://tools.ietf.org/html/rfc2518#section-10.4
  ///
  /// {@endtemplate}
  static const int locked = 423;

  /// {@template http_status_code_424_failedDependency}
  /// **failedDependency = 424**.
  ///
  /// The request failed due to failure of a previous request.
  ///
  /// https://tools.ietf.org/html/rfc2518#section-10.5
  ///
  /// {@endtemplate}
  static const int failedDependency = 424;

  /// {@template http_status_code_426_upgradeRequired}
  /// **upgradeRequired = 426**.
  ///
  /// This response code is used when the server refuses to perform the request
  /// using the current protocol but might be willing to do so after the client
  /// upgrades to a different protocol. The server sends an Upgrade header with
  /// this response to indicate the required protocol(s).
  ///
  /// https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/426
  ///
  /// {@endtemplate}
  static const int upgradeRequired = 426;

  /// {@template http_status_code_428_preconditionRequired}
  /// **preconditionRequired = 428**.
  ///
  /// The origin server requires the request to be conditional.
  ///
  /// Intended to prevent the 'lost update' problem, where a client GETs
  /// a resource's state, modifies it, and PUTs it back to the server,
  /// when meanwhile a third party has modified the state
  /// on the server, leading to a conflict.
  ///
  /// https://tools.ietf.org/html/rfc6585#section-3
  ///
  /// {@endtemplate}
  static const int preconditionRequired = 428;

  /// {@template http_status_code_429_tooManyRequests}
  /// **tooManyRequests = 429**.
  ///
  /// The user has sent too many requests
  /// in a given amount of time ("rate limiting").
  ///
  /// https://tools.ietf.org/html/rfc6585#section-4
  ///
  /// {@endtemplate}
  static const int tooManyRequests = 429;

  /// {@template http_status_code_431_requestHeaderFieldsTooLarge}
  /// **requestHeaderFieldsTooLarge = 431**.
  ///
  /// The server is unwilling to process the request because its header fields
  /// are too large. The request MAY be resubmitted after reducing
  /// the size of the request header fields.
  ///
  /// https://tools.ietf.org/html/rfc6585#section-5
  ///
  /// {@endtemplate}
  static const int requestHeaderFieldsTooLarge = 431;

  /// {@template http_status_code_444_connectionClosedWithoutResponse}
  /// **connectionClosedWithoutResponse = 444**.
  ///
  /// This response code is used when the server has closed the connection
  /// without sending any response to the client. This is often used in
  /// association with a load balancer or reverse proxy.
  ///
  /// https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/444
  ///
  /// {@endtemplate}
  static const int connectionClosedWithoutResponse = 444;

  /// {@template http_status_code_451_unavailableForLegalReasons}
  /// **unavailableForLegalReasons = 451**.
  ///
  /// The user-agent requested a resource that cannot legally be provided,
  /// such as a web page censored by a government.
  ///
  /// https://tools.ietf.org/html/rfc7725
  ///
  /// {@endtemplate}
  static const int unavailableForLegalReasons = 451;

  /// {@template http_status_code_499_clientClosedRequest}
  /// **clientClosedRequest = 499**.
  ///
  /// This response code is used when the client has closed the connection
  /// before the server could send a response. This is often used in
  /// association with a load balancer or reverse proxy.
  ///
  /// https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/499
  ///
  /// {@endtemplate}
  static const int clientClosedRequest = 499;

  /// {@template http_status_code_500_internalServerError}
  /// **internalServerError = 500**.
  ///
  /// The server encountered an unexpected condition that prevented it
  /// from fulfilling the request.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.6.1
  ///
  /// {@endtemplate}
  static const int internalServerError = 500;

  /// {@template http_status_code_501_notImplemented}
  /// **notImplemented = 501**.
  ///
  /// The request method is not supported by the server and cannot be handled.
  ///
  /// The only methods that servers are required to support (and therefore
  /// that must not return this code) are GET and HEAD.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.6.2
  ///
  /// {@endtemplate}
  static const int notImplemented = 501;

  /// {@template http_status_code_502_badGateway}
  /// **badGateway = 502**.
  ///
  /// This error response means that the server, while working as a gateway
  /// to get a response needed to handle the request, got an invalid response.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.6.3
  ///
  /// {@endtemplate}
  static const int badGateway = 502;

  /// {@template http_status_code_503_serviceUnavailable}
  /// **serviceUnavailable = 503**.
  ///
  /// The server is not ready to handle the request.
  ///
  /// Common causes are a server that is down for maintenance or that is
  /// overloaded. Note that together with this response, a user-friendly page
  /// explaining the problem should be sent.
  ///
  /// This responses should be used for temporary conditions
  /// and the Retry-After: HTTP header should, if possible, contain
  /// the estimated time before the recovery of the service.
  ///
  /// The webmaster must also take care about the caching-related headers
  /// that are sent along with this response, as these temporary condition
  /// responses should usually not be cached.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.6.4
  ///
  /// {@endtemplate}
  static const int serviceUnavailable = 503;

  /// {@template http_status_code_504_gatewayTimeout}
  /// **gatewayTimeout = 504**.
  ///
  /// This error response is given when the server is acting as a gateway
  /// and cannot get a response in time.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.6.5
  ///
  /// {@endtemplate}
  static const int gatewayTimeout = 504;

  /// {@template http_status_code_505_httpVersionNotSupported}
  /// **httpVersionNotSupported = 505**.
  ///
  /// The HTTP version used in the request is not supported by the server.
  ///
  /// https://tools.ietf.org/html/rfc7231#section-6.6.6
  ///
  /// {@endtemplate}
  static const int httpVersionNotSupported = 505;

  /// {@template http_status_code_506_variantAlsoNegotiates}
  /// **variantAlsoNegotiates = 506**.
  ///
  /// This response code is used when the server has an internal configuration
  /// error: the chosen variant resource is configured to engage in transparent
  /// content negotiation itself, and is therefore not a proper end point in
  /// the negotiation process.
  ///
  /// https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/506
  ///
  /// {@endtemplate}
  static const int variantAlsoNegotiates = 506;

  /// {@template http_status_code_507_insufficientStorage}
  /// **insufficientStorage = 507**.
  ///
  /// The server has an internal configuration error: the chosen variant
  /// resource is configured to engage in transparent content negotiation
  /// itself, and is therefore not a proper end point
  /// in the negotiation process.
  ///
  /// https://tools.ietf.org/html/rfc2518#section-10.6
  ///
  /// {@endtemplate}
  static const int insufficientStorage = 507;

  /// {@template http_status_code_508_loopDetected}
  /// **loopDetected = 508**.
  ///
  /// This response code is used when the server detected an infinite loop
  /// while processing the request.
  ///
  /// https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/508
  ///
  /// {@endtemplate}
  static const int loopDetected = 508;

  /// {@template http_status_code_510_notExtended}
  /// **notExtended = 510**.
  ///
  /// This response code is used when further extensions to the request are
  /// required for the server to fulfill it.
  ///
  /// https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/510
  ///
  /// {@endtemplate}
  static const int notExtended = 510;

  /// {@template http_status_code_511_networkAuthenticationRequired}
  /// **networkAuthenticationRequired = 511**.
  ///
  /// The 511 status code indicates that the client needs to authenticate
  /// to gain network access.
  ///
  /// https://tools.ietf.org/html/rfc6585#section-6
  ///
  /// {@endtemplate}
  static const int networkAuthenticationRequired = 511;

  /// {@template http_status_code_599_networkConnectTimeoutError}
  /// **networkConnectTimeoutError = 599**.
  ///
  /// This response code is used when the client fails to establish a network
  /// connection to the server within the allowed time limit.
  ///
  /// https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/599
  ///
  /// {@endtemplate}
  static const int networkConnectTimeoutError = 599;
}
