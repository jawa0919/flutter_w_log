/*
 * @FilePath     : /lib/src/dao/app_database.dart
 * @Date         : 2022-03-11 14:12:31
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : app_database
 */

import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../../flutter_w_log.dart';

/// 数据库相关
class AppDatabase {
  /// 初始化
  AppDatabase._();

  /// 单例
  static final AppDatabase _singleton = AppDatabase._();

  /// 单例
  static AppDatabase get instance => _singleton;

  /// 完成监听
  Completer<Database>? _dbOpenCompleter;

  /// 加密密钥
  String encryptionKey = "";

  /// 加密的db实例
  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDatabase();
    }
    return _dbOpenCompleter!.future;
  }

  /// 打开文件
  Future _openDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, WLogConstants.DB_NAME);
    Database dataBase;
    if (WLog.getDefaultConfig().dbConfig.encryptionEnabled &&
        WLog.getDefaultConfig().dbConfig.encryptionKey.isNotEmpty) {
      final codec = getXXTeaSembastCodec(
          password: WLog.getDefaultConfig().dbConfig.encryptionKey);
      dataBase = await databaseFactoryIo.openDatabase(dbPath, codec: codec);
    } else {
      dataBase = await databaseFactoryIo.openDatabase(dbPath);
    }
    _dbOpenCompleter!.complete(dataBase);
  }
}
