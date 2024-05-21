import 'dart:io';

import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

/// 数据库工厂
DatabaseFactory getDatabaseFactory() => databaseFactoryIo;

/// 写文件
Future<void> buffer2File(StringBuffer bf, String logFilePath) async {
  final logFile = File(logFilePath);
  await logFile.create(recursive: true);
  await logFile.writeAsString('$bf');
}
