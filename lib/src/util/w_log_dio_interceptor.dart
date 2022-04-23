/*
 * @FilePath     : /lib/src/util/w_log_dio_interceptor.dart
 * @Date         : 2022-04-21 16:53:53
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : WLogDioInterceptor
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class WLogDioInterceptor extends Interceptor {
  Map<int, DateTime> requestTimeMap = {};
  final bool reqPrint;
  final bool resPrint;
  WLogDioInterceptor({this.reqPrint = false, this.resPrint = true});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    final requestTime = DateTime.now();
    requestTimeMap.putIfAbsent(options.hashCode, () => requestTime);
    if (reqPrint) {
      final StringBuffer sb = StringBuffer();
      sb.write("-----------------------------------------------------------\n");
      sb.write("### http");
      sb.write("#${options.method} ${options.uri}");
      if (options.data != null) sb.write("\n${options.data}");
      sb.write("-----------------------------------------------------------\n");
      debugPrint(sb.toString());
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    if (resPrint) {
      final options = response.requestOptions;
      final requestTime = requestTimeMap[options.hashCode]!;
      final responseTime = DateTime.now();
      final time = responseTime.millisecondsSinceEpoch -
          requestTime.millisecondsSinceEpoch;
      final StringBuffer sb = StringBuffer();
      sb.write(
          "###$requestTime>>>$responseTime Time:${time}ms Status:${response.statusCode}\n");
      sb.write("${options.method} ${options.uri}\n");
      sb.write("-----------------------------------------------------------\n");
      sb.write("${response.data}\n");
      sb.write("-----------------------------------------------------------");
      debugPrint(sb.toString());
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    if (resPrint) {
      final options = err.requestOptions;
      final requestTime = requestTimeMap[options.hashCode]!;
      final responseTime = DateTime.now();
      final time = responseTime.millisecondsSinceEpoch -
          requestTime.millisecondsSinceEpoch;
      final StringBuffer sb = StringBuffer();
      sb.write("###$requestTime>>>$responseTime Time:${time}ms DioError\n");
      sb.write("${options.method} ${options.uri}\n");
      sb.write("-----------------------------------------------------------\n");
      sb.write("${err.type} ${err.message}\n");
      sb.write("-----------------------------------------------------------");
      debugPrint(sb.toString());
    }
  }
}
