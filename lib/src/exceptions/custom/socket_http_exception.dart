import '../../http_status/http_status.dart';
import '../exceptions.dart';

class SocketHttpException extends HttpException {
  SocketHttpException({super.data, super.detail = '', super.uri})
    : super(
        httpStatus: HttpStatus(
          code: 999,
          name: 'SocketHttpException',
          description: 'Socket connection error',
        ),
      );
}
