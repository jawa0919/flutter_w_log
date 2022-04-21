/*
 * @FilePath     : /lib/src/util/w_log_dio_interceptor.dart
 * @Date         : 2022-04-21 16:53:53
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : WLogDioInterceptor
 */

import 'package:dio/dio.dart';

import '../../flutter_w_log.dart';

class WLogDioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    WLog.d("onRequest");
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    WLog.d("onResponse");
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    WLog.d("onError");
  }
}
