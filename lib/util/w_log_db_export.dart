/*
 * @FilePath     : /lib/util/w_log_db_export.dart
 * @Date         : 2022-03-11 10:01:34
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : w_log_db_export
 */

import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';

import '../flutter_w_log.dart';

class WLogDBExport {
  WLogDBExport._();

  static Future<String> get exportPath async {
    Directory? directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }
    return join(directory!.path, WLogConstants.DIRECTORY_NAME);
  }

  static List<Filter> generateFilters([
    DateTime? startTime,
    DateTime? endTime,
    List<WLogLevel>? levelList,
  ]) {
    List<Filter> filters = [];

    if (startTime != null) {
      final s = startTime.millisecondsSinceEpoch;
      final sFilter = Filter.greaterThan(WLogConstants.FIELD_T, s);
      filters.add(sFilter);
    }

    if (endTime != null) {
      final e = endTime.millisecondsSinceEpoch;
      final eFilter = Filter.lessThan(WLogConstants.FIELD_T, e);
      filters.add(eFilter);
    }

    if (levelList != null && levelList.isNotEmpty) {
      final l = levelList.map((e) => WLogLevel.values.indexOf(e)).toList();
      final lFilter = Filter.inList(WLogConstants.FIELD_L, l);
      filters.add(lFilter);
    }

    return filters;
  }
}
