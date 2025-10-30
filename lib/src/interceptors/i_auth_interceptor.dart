import '../exceptions/http_exception_base.dart';

abstract class IAuthInterceptor {
  IAuthInterceptor();

  Future<void> onError(HttpException error);

  Future<void> onRequest();
}
