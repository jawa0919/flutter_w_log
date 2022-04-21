/*
 * @FilePath     : /lib/src/util/w_log_dio_interceptor.dart
 * @Date         : 2022-04-21 16:53:53
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : WLogDioInterceptor
 */

import 'package:dio/dio.dart';

import '../../flutter_w_log.dart';

class WLogDioInterceptor extends Interceptor {
  Map<int, DateTime> requestTimeMap = {};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    requestTimeMap.putIfAbsent(options.hashCode, () => DateTime.now());
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    int key = response.requestOptions.hashCode;
    final requestTime = requestTimeMap[key];
    final responseTime = DateTime.now();
    WLog.d("onResponse");
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    int key = err.requestOptions.hashCode;
    final requestTime = requestTimeMap[key];
    final responseTime = DateTime.now();
    WLog.d("onError");
  }
}
