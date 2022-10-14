/*
 * @FilePath     : /lib/src/core/w_log.dart
 * @Date         : 2022-03-09 17:25:19
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : w_log
 */

import 'dart:io';

import 'package:stack_trace/stack_trace.dart';

import '../../flutter_w_log.dart';

/// 打印1
void printWLog(Object? object) {
  DateTime now = DateTime.now();
  Frame frame = Trace.current().frames[1];
  String message = "$object";
  WLog.d(message, now: now, frame: frame);
}

/// 打印2
void debugPrintWLog(String? message, {int? wrapWidth}) {
  DateTime now = DateTime.now();
  Frame frame = Trace.current().frames[1];
  WLog.d(message ?? "", now: now, frame: frame);
}

/// 打印集合
class WLog {
  WLog._();

  static WLogConfig _config = WLogConfig();
  static WLogConfig getDefaultConfig() {
    return _config;
  }

  static void applyConfig(WLogConfig config) {
    _config = config;
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
    List<WLogLevel> levelList = WLogLevel.values,
  ]) async {
    final today = DateTime.now().toIso8601String().split("T").first;

    final startTime = DateTime.parse("$today 00:00:00");
    final endTime = DateTime.parse("$today 23:59:59");

    filePath ??= await WLogDBExport.generateFilePath("WLog_$today.txt");
    return await log2File(filePath, startTime, endTime, levelList);
  }

  static Future<File> allLog2File([
    String? filePath,
    List<WLogLevel> levelList = WLogLevel.values,
  ]) async {
    filePath ??= await WLogDBExport.generateFilePath("WLog_all.txt");
    return await log2File(filePath, null, null, levelList);
  }

  static Future<File> timeLog2File(
    DateTime startTime, [
    DateTime? endTime,
    String? filePath,
    List<WLogLevel> levelList = WLogLevel.values,
  ]) async {
    endTime ??= DateTime.now();
    final name =
        "${WLogModel.dateFormat(startTime)}_${WLogModel.dateFormat(endTime)}";

    filePath ??= await WLogDBExport.generateFilePath("WLog_$name.txt");
    return await log2File(filePath, startTime, endTime, levelList);
  }

  static Future<File> log2File(
    String logFilePath, [
    DateTime? startTime,
    DateTime? endTime,
    List<WLogLevel>? levelList,
  ]) async {
    final logs = await _db.findLog(startTime, endTime, levelList);
    final buffer = StringBuffer();
    if (logs.isNotEmpty) {
      for (var log in logs) {
        buffer.write(_config.dbConfig.exportForma(log));
        buffer.write("\n");
      }
    }
    return await _buffer2File(buffer, logFilePath);
  }

  static Future<File> _buffer2File(StringBuffer bf, String logFilePath) async {
    final logFile = File(logFilePath);
    await logFile.create(recursive: true);
    return await logFile.writeAsString('$bf');
  }
}
