/*
 * @FilePath     : /lib/src/core/w_log_dv.dart
 * @Date         : 2022-03-11 10:01:34
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : w_log_dv
 */

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stack_trace/stack_trace.dart';

import '../util/w_log_model.dart';
import 'w_log.dart';

/// 打印全局上下文
class WLogDV {
  /// 初始化
  WLogDV._();

  /// 单例
  static final WLogDV _singleton = WLogDV._();

  /// 单例
  static WLogDV get instance => _singleton;

  /// 配置
  final _config = WLog.getDefaultConfig().dvConfig;

  /// 展示日志
  void showLog(String s, DateTime t, Frame f, WLogLevel l) {
    String head = "$t";
    if (_config.isWithLevel) head += "-${l.name}";
    if (_config.isWithFrame) head += " ${f.location}";
    if (_config.isWithFileName) head += " ${f.uri.path}";
    if (_config.isWithMethodName) head += " ${f.member}";
    debugPrint(head);
    log(s);
  }
}
