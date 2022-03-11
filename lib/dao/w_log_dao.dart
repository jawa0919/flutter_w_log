/*
 * @FilePath     : /lib/dao/w_log_dao.dart
 * @Date         : 2022-03-11 14:16:28
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : w_log_dao
 */

import 'package:sembast/sembast.dart';

import '../flutter_w_log.dart';

class WLogDao {
  WLogDao._();
  static final WLogDao _singleton = WLogDao._();
  static WLogDao get instance => _singleton;

  final _flogsStore = intMapStoreFactory.store(WLogConstants.STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<int> insert(WLogModel log) async {
    return await _flogsStore.add(await _db, log.toJson());
  }

  Future update(WLogModel log) async {
    final finder = Finder(filter: Filter.byKey(log.id));
    await _flogsStore.update(await _db, log.toJson(), finder: finder);
  }

  Future delete(WLogModel log) async {
    final finder = Finder(filter: Filter.byKey(log.id));
    await _flogsStore.delete(await _db, finder: finder);
  }

  Future<int> deleteByFilter({required List<Filter> filters}) async {
    final finder = Finder(filter: Filter.and(filters));
    var deleted = await _flogsStore.delete(await _db, finder: finder);
    return deleted;
  }

  Future deleteAll() async {
    await _flogsStore.delete(await _db);
  }

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

  Future<List<WLogModel>> findAll() async {
    final recordSnapshots = await _flogsStore.find(await _db);
    return recordSnapshots.map((snapshot) {
      final log = WLogModel.fromJson(snapshot.value);
      log.id = snapshot.key;
      return log;
    }).toList();
  }
}
