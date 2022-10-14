/*
 * @FilePath     : /lib/src/core/w_log_dv.dart
 * @Date         : 2022-03-11 10:01:34
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : w_log_dv
 */

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stack_trace/stack_trace.dart';

import '../../flutter_w_log.dart';

/// 打印全局上下文
class WLogDV {
  WLogDV._();
  static final WLogDV _singleton = WLogDV._();
  static WLogDV get instance => _singleton;

  final _config = WLog.getDefaultConfig().dvConfig;

  void showLog(String s, DateTime t, Frame f, WLogLevel l) {
    String head = "$t";
    if (_config.isWithLevel) head += "-${l.name}";
    if (_config.isWithFrame) head += " ${f.location}";
    if (_config.isWithFileName) head += " ${f.uri.path}";
    if (_config.isWithMethodName) head += " ${f.member}";
    debugPrint(head);
    // 当日志打印长度超过1000个字符时，自动换行使用log长打印，保证日志内容不丢失
    if (s.length > 1000) {
      log(s);
    } else {
      debugPrint(s);
    }
  }
}
