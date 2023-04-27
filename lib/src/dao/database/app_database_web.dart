/*
 * @FilePath     : /lib/src/dao/app_database.dart
 * @Date         : 2022-03-11 14:12:31
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : app_database
 */

import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

DatabaseFactory getDatabaseFactory() => databaseFactoryWeb;

/// 写文件
Future<void> buffer2File(StringBuffer bf, String logFilePath) async {
  var blob = html.Blob(['$bf'], 'text/plain', 'native');
  html.AnchorElement(href: html.Url.createObjectUrlFromBlob(blob))
    ..setAttribute("download", logFilePath)
    ..click();
}
