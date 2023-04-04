/*
 * @FilePath     : /lib/src/dao/app_database.dart
 * @Date         : 2022-03-11 14:12:31
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : app_database
 */

import 'package:sembast/sembast.dart';

DatabaseFactory getDatabaseFactory() => _stub('getDatabaseFactory()');

T _stub<T>(String message) {
  throw UnimplementedError(message);
}
