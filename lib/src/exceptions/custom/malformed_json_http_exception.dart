import '../../http_status/http_status.dart';
import '../exceptions.dart';

class MalformedJsonHttpException extends HttpException {
  MalformedJsonHttpException({super.data, super.detail = '', super.uri})
    : super(
        httpStatus: HttpStatus(
          code: 888,
          name: 'MalformedJsonHttp',
          description: 'Malformed JSON response',
        ),
      );
}
