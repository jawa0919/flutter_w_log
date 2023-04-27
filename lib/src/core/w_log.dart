/*
 * @FilePath     : /lib/src/core/w_log.dart
 * @Date         : 2022-03-09 17:25:19
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : w_log
 */

import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart';

import '../dao/database/app_database.dart';
import '../util/w_log_db_export.dart';
import '../util/w_log_model.dart';
import 'w_log_config.dart';
import 'w_log_db.dart';
import 'w_log_dv.dart';

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

/// 打印3
void recordError(Object message, StackTrace? stack) {
  DateTime now = DateTime.now();
  final frameStr = stack.toString().split("\n");
  try {
    Frame frame = Frame.parseVM(frameStr.elementAt(kDebugMode ? 1 : 0));
    WLog.e(message.toString(), now: now, frame: frame);
  } catch (e) {
    Frame frame = Trace.current().frames[1];
    WLog.e(message.toString(), now: now, frame: frame);
  }
}

/// 打印集合
class WLog {
  WLog._();

  /// 配置
  static WLogConfig _config = WLogConfig();

  /// 默认配置
  static WLogConfig getDefaultConfig() {
    return _config;
  }

  /// 适用配置
  static void applyConfig(WLogConfig config) {
    _config = config;
  }

  /// 视图
  static final WLogDV _dv = WLogDV.instance;

  /// 数据库
  static final WLogDB _db = WLogDB.instance;

  /// 打印
  static void print(Object? object) {
    DateTime now = DateTime.now();
    Frame frame = Trace.current().frames[1];
    String message = "$object";
    d(message, now: now, frame: frame);
  }

  /// 打印
  static void debugPrint(String? message, {int? wrapWidth}) {
    DateTime now = DateTime.now();
    Frame frame = Trace.current().frames[1];
    d(message ?? "", now: now, frame: frame);
  }

  /// 打印d
  static void d(String message, {DateTime? now, Frame? frame}) {
    now ??= DateTime.now();
    frame ??= Trace.current().frames[1];
    _log(message, now, frame, WLogLevel.DEBUG);
  }

  /// 打印i
  static void i(String message, {DateTime? now, Frame? frame}) {
    now ??= DateTime.now();
    frame ??= Trace.current().frames[1];
    _log(message, now, frame, WLogLevel.INFO);
  }

  /// 打印w
  static void w(String message, {DateTime? now, Frame? frame}) {
    now ??= DateTime.now();
    frame ??= Trace.current().frames[1];
    _log(message, now, frame, WLogLevel.WARN);
  }

  /// 打印e
  static void e(String message, {DateTime? now, Frame? frame}) {
    now ??= DateTime.now();
    frame ??= Trace.current().frames[1];
    _log(message, now, frame, WLogLevel.ERROR);
  }

  /// 打印
  static void _log(String s, DateTime t, Frame f, WLogLevel l) {
    if (_config.isEnabled) {
      if (_config.dvConfig.isEnabled) _dv.showLog(s, t, f, l);
      if (_config.dbConfig.isEnabled) _db.insertLog(s, t, f, l);
    }
  }

  /// 导出今天日志到文件
  static Future<String> todayLog2File([
    String? filePath,
    List<WLogLevel> levelList = WLogLevel.values,
  ]) async {
    final today = DateTime.now().toIso8601String().split("T").first;

    final startTime = DateTime.parse("$today 00:00:00");
    final endTime = DateTime.parse("$today 23:59:59");

    filePath ??= await WLogDBExport.generateFilePath("WLog_$today.txt");
    await log2File(filePath, startTime, endTime, levelList);
    return filePath;
  }

  /// 导出所有日志到文件
  static Future<String> allLog2File([
    String? filePath,
    List<WLogLevel> levelList = WLogLevel.values,
  ]) async {
    filePath ??= await WLogDBExport.generateFilePath("WLog_all.txt");
    await log2File(filePath, null, null, levelList);
    return filePath;
  }

  /// 导出时间段日志到文件
  static Future<String> timeLog2File(
    DateTime startTime, [
    DateTime? endTime,
    String? filePath,
    List<WLogLevel> levelList = WLogLevel.values,
  ]) async {
    endTime ??= DateTime.now();
    final name =
        "${WLogModel.dateFormat(startTime)}_${WLogModel.dateFormat(endTime)}";

    filePath ??= await WLogDBExport.generateFilePath("WLog_$name.txt");
    await log2File(filePath, startTime, endTime, levelList);
    return filePath;
  }

  /// 导出自定义筛选日志到文件
  static Future<void> log2File(
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
    await buffer2File(buffer, logFilePath);
  }
}
