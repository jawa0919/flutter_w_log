import 'package:stack_trace/stack_trace.dart';

import '_dao/_dao.dart';
import 'w_log_dto.dart';
import 'w_log_export.dart';

/// WLogDatabase
class WLogDatabase {
  WLogDatabase._();

  /// 添加
  static void add(String s, DateTime t, WLogLevel l, Frame f) async {
    final dto = WLogDto(
      s: s,
      t: t,
      l: l,
      p: '${f.uri.path}:${f.line ?? 0}',
      m: f.member ?? "",
    );
    await WLogDao.instance.insert(dto);
  }

  /// 搜索
  static Future<List<WLogDto>> search([
    DateTime? startTime,
    DateTime? endTime,
    List<WLogLevel>? levelList,
  ]) async {
    final filters = WLogExport.generateFilters(startTime, endTime, levelList);
    return WLogDao.instance.findByFilter(filters: filters);
  }

  /// 清空
  static Future<void> clear() async {
    return await WLogDao.instance.deleteAll();
  }
}
