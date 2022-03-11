/*
 * @FilePath     : /lib/core/w_log.dart
 * @Date         : 2022-03-09 17:25:19
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : w_log
 */

import 'dart:io';

import 'package:stack_trace/stack_trace.dart';

import '../flutter_w_log.dart';

void printWLog(Object? object) {
  DateTime now = DateTime.now();
  Frame frame = Trace.current().frames[1];
  String message = "$object";
  WLog.d(message, now: now, frame: frame);
}

void debugPrintWLog(String? message, {int? wrapWidth}) {
  DateTime now = DateTime.now();
  Frame frame = Trace.current().frames[1];
  WLog.d(message ?? "", now: now, frame: frame);
}

class WLog {
  WLog._();

  static WLogConfig _config = WLogConfig();
  static WLogConfig getDefaultConfig() {
    return _config;
  }

  static void applyConfig(WLogConfig config) {
    _config = config;
  }

  static final WLogDao _dao = WLogDao.instance;
  static WLogDao getDefaultDao() {
    return _dao;
  }

  static final WLogDV _dv = WLogDV.instance;
  static final WLogDB _db = WLogDB.instance;

  static void print(Object? object) {
    DateTime now = DateTime.now();
    Frame frame = Trace.current().frames[1];
    String message = "$object";
    d(message, now: now, frame: frame);
  }

  static void debugPrint(String? message, {int? wrapWidth}) {
    DateTime now = DateTime.now();
    Frame frame = Trace.current().frames[1];
    d(message ?? "", now: now, frame: frame);
  }

  static void d(String message, {DateTime? now, Frame? frame}) {
    now ??= DateTime.now();
    frame ??= Trace.current().frames[1];
    _log(message, now, frame, WLogLevel.DEBUG);
  }

  static void i(String message, {DateTime? now, Frame? frame}) {
    now ??= DateTime.now();
    frame ??= Trace.current().frames[1];
    _log(message, now, frame, WLogLevel.INFO);
  }

  static void w(String message, {DateTime? now, Frame? frame}) {
    now ??= DateTime.now();
    frame ??= Trace.current().frames[1];
    _log(message, now, frame, WLogLevel.WARN);
  }

  static void e(String message, {DateTime? now, Frame? frame}) {
    now ??= DateTime.now();
    frame ??= Trace.current().frames[1];
    _log(message, now, frame, WLogLevel.ERROR);
  }

  static void _log(String s, DateTime t, Frame f, WLogLevel l) {
    if (_config.isEnabled) {
      if (_config.dvConfig.isEnabled) _dv.showLog(s, t, f, l);
      if (_config.dbConfig.isEnabled) _db.insertLog(s, t, f, l);
    }
  }

  static Future<File> todayLog2File([
    String? filePath,
    List<WLogLevel>? levelList = WLogLevel.values,
  ]) async {
    return File("filePath");
  }

  static Future<File> allLog2File([
    String? filePath,
    List<WLogLevel>? levelList = WLogLevel.values,
  ]) async {
    return File("filePath");
  }
}
