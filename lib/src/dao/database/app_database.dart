/*
 * @FilePath     : /lib/src/dao/app_database.dart
 * @Date         : 2022-03-11 14:12:31
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : app_database
 */

export 'app_database_stud.dart'
    if (dart.library.html) 'app_database_web.dart'
    if (dart.library.io) 'app_database_io.dart';
