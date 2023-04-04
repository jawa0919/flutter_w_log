/*
 * @FilePath     : /lib/src/dao/w_log_dao.dart
 * @Date         : 2022-03-11 14:16:28
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : w_log_dao
 */

import 'package:sembast/sembast.dart';

import '../util/w_log_constants.dart';
import '../util/w_log_model.dart';
import 'w_log_database.dart';

/// 数据库操作类
class WLogDao {
  /// 初始化
  WLogDao._();

  /// 单例
  static final WLogDao _singleton = WLogDao._();

  /// 单例
  static WLogDao get instance => _singleton;

  /// store
  final _flogsStore = intMapStoreFactory.store(WLogConstants.STORE_NAME);

  /// db
  Future<Database> get _db async => await AppDatabase.instance.database;

  /// insert
  Future<int> insert(WLogModel log) async {
    return await _flogsStore.add(await _db, log.toJson());
  }

  /// update
  Future update(WLogModel log) async {
    final finder = Finder(filter: Filter.byKey(log.id));
    await _flogsStore.update(await _db, log.toJson(), finder: finder);
  }

  /// delete
  Future delete(WLogModel log) async {
    final finder = Finder(filter: Filter.byKey(log.id));
    await _flogsStore.delete(await _db, finder: finder);
  }

  /// deleteByFilter
  Future<int> deleteByFilter({required List<Filter> filters}) async {
    final finder = Finder(filter: Filter.and(filters));
    var deleted = await _flogsStore.delete(await _db, finder: finder);
    return deleted;
  }

  /// deleteAll
  Future deleteAll() async {
    await _flogsStore.delete(await _db);
  }

  /// findByFilter
  Future<List<WLogModel>> findByFilter({required List<Filter> filters}) async {
    final finder = Finder(
      filter: Filter.and(filters),
      sortOrders: [SortOrder(WLogConstants.FIELD_TIME)],
    );
    final recordSnapshots = await _flogsStore.find(await _db, finder: finder);
    return recordSnapshots.map((snapshot) {
      final log = WLogModel.fromJson(snapshot.value);
      log.id = snapshot.key;
      return log;
    }).toList();
  }

  /// findAll
  Future<List<WLogModel>> findAll() async {
    final recordSnapshots = await _flogsStore.find(await _db);
    return recordSnapshots.map((snapshot) {
      final log = WLogModel.fromJson(snapshot.value);
      log.id = snapshot.key;
      return log;
    }).toList();
  }
}
