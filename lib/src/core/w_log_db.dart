/*
 * @FilePath     : /lib/src/core/w_log_db.dart
 * @Date         : 2022-03-11 10:01:34
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : w_log_db
 */

import 'package:stack_trace/stack_trace.dart';

import '../dao/w_log_dao.dart';
import '../util/w_log_db_export.dart';
import '../util/w_log_model.dart';

/// 存储内容全局上下文
class WLogDB {
  /// 初始化
  WLogDB._();

  /// 单例
  static final WLogDB _singleton = WLogDB._();

  /// 单例
  static WLogDB get instance => _singleton;

  /// db
  final WLogDao _dao = WLogDao.instance;

  /// 插入一条日志
  void insertLog(String s, DateTime t, Frame f, WLogLevel l) async {
    final logModel = WLogModel(
        s: s, t: t, f: f.uri.path + ':${f.line ?? 0}', m: f.member, l: l);
    await _dao.insert(logModel);
  }

  /// 寻找一条日志
  Future<List<WLogModel>> findLog([
    DateTime? startTime,
    DateTime? endTime,
    List<WLogLevel>? levelList,
  ]) async {
    var filters = WLogDBExport.generateFilters(startTime, endTime, levelList);
    return await _dao.findByFilter(filters: filters);
  }
}
