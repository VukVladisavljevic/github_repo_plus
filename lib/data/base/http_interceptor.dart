import '../../core/util/logger.dart';
import 'package:http_interceptor/http_interceptor.dart';

class HttpInterceptor implements InterceptorContract {
  final Logger _logger;

  HttpInterceptor(this._logger);

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    _logger.logWarning(data);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    _logger.logWarning(data.request.toString() + data.statusCode.toString());
    return data;
  }
}
