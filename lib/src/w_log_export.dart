import 'dart:io';

import 'package:path/path.dart';
import 'package:sembast/sembast.dart';

import '_dao/_factory/_factory.dart';
import '_utils.dart';
import '_w_log_constants.dart';
import '_w_log_database.dart';
import 'w_log_dto.dart';

/// 导出相关
class WLogExport {
  /// 初始化
  WLogExport._();

  /// exportFormat导出时打印格式化
  static WLogDtoFormatFunc exportFormat = (m) => m.formatLine;

  /// 创建筛选
  static List<Filter> generateFilters([
    DateTime? startTime,
    DateTime? endTime,
    List<WLogLevel>? levelList,
  ]) {
    List<Filter> filters = [];

    if (startTime != null) {
      final s = startTime.millisecondsSinceEpoch;
      final sFilter = Filter.greaterThan(WLogConstants.FIELD_TIME, s);
      filters.add(sFilter);
    }

    if (endTime != null) {
      final e = endTime.millisecondsSinceEpoch;
      final eFilter = Filter.lessThan(WLogConstants.FIELD_TIME, e);
      filters.add(eFilter);
    }

    if (levelList != null && levelList.isNotEmpty) {
      final l = levelList.map((e) => WLogLevel.values.indexOf(e)).toList();
      final lFilter = Filter.inList(WLogConstants.FIELD_LEVEL, l);
      filters.add(lFilter);
    }

    return filters;
  }

  /// 导出今天日志到文件夹
  static Future<String> todayLog2File(
    Directory directory, [
    List<WLogLevel> levelList = WLogLevel.values,
  ]) async {
    final today = DateTime.now().dateString;

    final filePath = join(directory.path, "WLog_Today_$today.txt");
    final startTime = DateTime.parse("$today 00:00:00");
    final endTime = DateTime.parse("$today 23:59:59");
    await log2File(filePath, startTime, endTime, levelList);
    return filePath;
  }

  /// 导出所有日志到文件夹
  static Future<String> allLog2File(
    Directory directory, [
    List<WLogLevel> levelList = WLogLevel.values,
  ]) async {
    final now = DateTime.now().datetimeString;

    final filePath = join(directory.path, "WLog_All_$now.txt");
    await log2File(filePath, null, null, levelList);
    return filePath;
  }

  /// 导出时间段日志到文件夹
  static Future<String> timeLog2File(
    Directory directory,
    DateTime startTime, [
    DateTime? endTime,
    List<WLogLevel> levelList = WLogLevel.values,
  ]) async {
    endTime ??= DateTime.now();
    final name = "${startTime.datetimeString}_${endTime.datetimeString}";

    final filePath = join(directory.path, "WLog_$name.txt");
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
    final logs = await WLogDatabase.search(startTime, endTime, levelList);
    final buffer = StringBuffer();
    if (logs.isNotEmpty) {
      for (var log in logs) {
        buffer.write(exportFormat(log));
        buffer.write("\n");
      }
    }
    await buffer2File(buffer, logFilePath);
  }
}
