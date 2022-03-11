/*
 * @FilePath     : /lib/util/w_log_db_export_format.dart
 * @Date         : 2022-03-09 21:10:08
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : w_log_format
 */

import 'package:stack_trace/stack_trace.dart';

import 'w_log_model.dart';

typedef DateTimeFormatFunc = String Function(DateTime dateTime);

typedef FrameFormatFunc = String Function(Frame frame);

class WLogDBExportFormat {
  DateTimeFormatFunc dateTimeFormat;
  FrameFormatFunc frameFormat;

  WLogDBExportFormat({
    required this.dateTimeFormat,
    required this.frameFormat,
  });

  WLogDBExportFormat.def()
      : dateTimeFormat = _defDateTimeFormat,
        frameFormat = _defFrameFormatFunc;

  static String _defDateTimeFormat(DateTime dateTime) {
    return dateTime.toIso8601String();
  }

  static String _defFrameFormatFunc(Frame frame) {
    return frame.toString();
  }

  static String format(WLogModel log, WLogDBExportFormat f) {
    return log.toJson().toString();
  }
}
