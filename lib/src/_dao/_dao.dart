import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';

import '../_w_log_constants.dart';
import '../w_log.dart';
import '../w_log_dto.dart';
import '_encryption.dart';
import '_factory/_factory.dart';

/// 数据库操作类
class WLogDao {
  /// 初始化
  WLogDao._();

  /// 单例
  static final WLogDao _singleton = WLogDao._();

  /// 单例
  static WLogDao get instance => _singleton;

  /// 完成监听
  Completer<Database>? _dbOpenCompleter;

  /// 打开数据库
  Future<void> _openDatabase() async {
    Directory appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, WLogConstants.DB_NAME);
    Database dataBase;
    if (WLog.databasePassword.isNotEmpty) {
      final codec = getXXTeaSembastCodec(WLog.databasePassword);
      dataBase = await getDatabaseFactory().openDatabase(dbPath, codec: codec);
    } else {
      dataBase = await getDatabaseFactory().openDatabase(dbPath);
    }
    _dbOpenCompleter?.complete(dataBase);
  }

  /// 删除数据库
  Future<void> _deleteDatabase() async {
    Directory appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, WLogConstants.DB_NAME);
    await getDatabaseFactory().deleteDatabase(dbPath);
  }

  /// db实例
  Future<Database> get _db async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDatabase();
    }
    return _dbOpenCompleter!.future;
  }

  /// store实例
  final _store = intMapStoreFactory.store(WLogConstants.STORE_NAME);

  /// insert
  Future<int> insert(WLogDto log) async {
    return await _store.add(await _db, log.toMap());
  }

  /// update
  Future update(WLogDto log) async {
    final finder = Finder(filter: Filter.byKey(log.id));
    await _store.update(await _db, log.toMap(), finder: finder);
  }

  /// delete
  Future delete(WLogDto log) async {
    final finder = Finder(filter: Filter.byKey(log.id));
    await _store.delete(await _db, finder: finder);
  }

  /// deleteByFilter
  Future<int> deleteByFilter({required List<Filter> filters}) async {
    final finder = Finder(filter: Filter.and(filters));
    var deleted = await _store.delete(await _db, finder: finder);
    return deleted;
  }

  /// deleteAll
  Future deleteAll() async {
    await _store.delete(await _db);
  }

  /// findByFilter
  Future<List<WLogDto>> findByFilter({required List<Filter> filters}) async {
    final finder = Finder(
      filter: Filter.and(filters),
      sortOrders: [SortOrder(WLogConstants.FIELD_TIME)],
    );
    final recordSnapshots = await _store.find(await _db, finder: finder);
    return recordSnapshots.map((snapshot) {
      final log = WLogDto.fromMap(snapshot.value);
      log.id = snapshot.key;
      return log;
    }).toList();
  }

  /// findAll
  Future<List<WLogDto>> findAll() async {
    final recordSnapshots = await _store.find(await _db);
    return recordSnapshots.map((snapshot) {
      final log = WLogDto.fromMap(snapshot.value);
      log.id = snapshot.key;
      return log;
    }).toList();
  }
}
