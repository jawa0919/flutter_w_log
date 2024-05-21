import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart';

import 'w_log_dto.dart';
import '_w_log_database.dart';
import '_w_log_logcat.dart';
import 'w_log_monitor.dart';

/// 打印printWLog
void printWLog(Object? object) {
  DateTime now = DateTime.now();
  Frame frame = Trace.current().frames[1];
  String message = "$object";
  WLog.i(message, dateTime: now, frame: frame);
}

/// 打印debugPrintWLog
void debugPrintWLog(String? message, {int? wrapWidth}) {
  DateTime now = DateTime.now();
  Frame frame = Trace.current().frames[1];
  WLog.d(message ?? "", dateTime: now, frame: frame, wrapWidth: wrapWidth);
}

/// 打印recordError
void recordError(Object message, StackTrace? stack) {
  DateTime now = DateTime.now();
  final frameStr = stack.toString().split("\n");
  try {
    Frame frame = Frame.parseVM(frameStr.elementAt(kDebugMode ? 1 : 0));
    WLog.e(message.toString(), dateTime: now, frame: frame);
  } catch (e) {
    Frame frame = Trace.current().frames[1];
    WLog.e(message.toString(), dateTime: now, frame: frame);
  }
}

/// WLog
class WLog {
  WLog._();

  /// 打印print
  static void print(Object? object) {
    DateTime now = DateTime.now();
    Frame frame = Trace.current().frames[1];
    String message = "$object";
    WLog.i(message, dateTime: now, frame: frame);
  }

  /// 打印debugPrint
  static void debugPrint(String? message, {int? wrapWidth}) {
    DateTime now = DateTime.now();
    Frame frame = Trace.current().frames[1];
    WLog.d(message ?? "", dateTime: now, frame: frame, wrapWidth: wrapWidth);
  }

  /// 打印d
  static void d(String message,
      {DateTime? dateTime, Frame? frame, int? wrapWidth}) {
    dateTime ??= DateTime.now();
    frame ??= Trace.current().frames[1];
    _log(message, dateTime, WLogLevel.DEBUG, frame, wrapWidth: wrapWidth);
  }

  /// 打印i
  static void i(String message, {DateTime? dateTime, Frame? frame}) {
    dateTime ??= DateTime.now();
    frame ??= Trace.current().frames[1];
    _log(message, dateTime, WLogLevel.INFO, frame);
  }

  /// 打印w
  static void w(String message, {DateTime? dateTime, Frame? frame}) {
    dateTime ??= DateTime.now();
    frame ??= Trace.current().frames[1];
    _log(message, dateTime, WLogLevel.WARN, frame);
  }

  /// 打印e
  static void e(String message, {DateTime? dateTime, Frame? frame}) {
    dateTime ??= DateTime.now();
    frame ??= Trace.current().frames[1];
    _log(message, dateTime, WLogLevel.ERROR, frame);
  }

  static Future<List<WLogDto>> search([
    DateTime? startTime,
    DateTime? endTime,
    List<WLogLevel>? levelList,
  ]) =>
      WLogDatabase.search(startTime, endTime, levelList);

  static Future<void> clear() => WLogDatabase.clear();

  /// logcat开关
  static bool logcatEnabled = true;

  /// logcat打印所在的文件路径
  static bool logcatWithPath = false;

  /// logcat打印所在的代码块名称
  static bool logcatWithMember = false;

  /// database开关
  static bool databaseEnabled = true;

  /// database密码
  static String databasePassword = "";

  /// _log
  static void _log(
    String message,
    DateTime dateTime,
    WLogLevel level,
    Frame frame, {
    int? wrapWidth,
  }) {
    if (logcatEnabled) {
      WLogLogcat.show(message, dateTime, level, frame, wrapWidth: wrapWidth);
    }
    if (databaseEnabled) {
      WLogDatabase.add(message, dateTime, level, frame);
    }
    WLogMonitorPage.time ??= dateTime.subtract(const Duration(seconds: 1));
  }
}
