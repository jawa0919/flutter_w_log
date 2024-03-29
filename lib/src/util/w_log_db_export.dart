/*
 * @FilePath     : /lib/src/util/w_log_db_export.dart
 * @Date         : 2022-03-11 10:01:34
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : w_log_db_export
 */

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';

import 'w_log_constants.dart';
import 'w_log_model.dart';

/// 导出相关
class WLogDBExport {
  /// 初始化
  WLogDBExport._();

  /// 导出路径
  static Future<String> get exportPath async {
    Directory? directory;
    if (kIsWeb) return join("", WLogConstants.DIRECTORY_NAME);
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }
    return join(directory!.path, WLogConstants.DIRECTORY_NAME);
  }

  /// 创建导出路径
  static Future<String> generateFilePath(String fileName) async {
    return join(await exportPath, fileName);
  }

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
}
