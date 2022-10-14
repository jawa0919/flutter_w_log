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

class AppDatabase {
  AppDatabase._();
  static final AppDatabase _singleton = AppDatabase._();
  static AppDatabase get instance => _singleton;

  Completer<Database>? _dbOpenCompleter;

  String encryptionKey = "";

  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDatabase();
    }
    return _dbOpenCompleter!.future;
  }

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
