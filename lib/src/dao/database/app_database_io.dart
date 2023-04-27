/*
 * @FilePath     : /lib/src/dao/app_database.dart
 * @Date         : 2022-03-11 14:12:31
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : app_database
 */

import 'dart:io';

import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

DatabaseFactory getDatabaseFactory() => databaseFactoryIo;

/// 写文件
Future<void> buffer2File(StringBuffer bf, String logFilePath) async {
  final logFile = File(logFilePath);
  await logFile.create(recursive: true);
  await logFile.writeAsString('$bf');
}
