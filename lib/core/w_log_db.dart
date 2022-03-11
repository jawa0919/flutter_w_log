/*
 * @FilePath     : /lib/core/w_log_db.dart
 * @Date         : 2022-03-11 10:01:34
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : w_log_db
 */

import 'package:stack_trace/stack_trace.dart';

import '../flutter_w_log.dart';

class WLogDB {
  WLogDB._();
  static final WLogDB _singleton = WLogDB._();
  static WLogDB get instance => _singleton;

  final _config = WLog.getDefaultConfig().dbConfig;
  final _dao = WLog.getDefaultDao();

  void insertLog(String s, DateTime t, Frame f, WLogLevel l) async {
    final logModel = WLogModel(s: s, t: t, f: f, l: l);
    await _dao.insert(logModel);
  }
}
