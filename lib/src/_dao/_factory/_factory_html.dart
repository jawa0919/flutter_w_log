import 'package:sembast/sembast.dart';
import 'package:sembast_web/sembast_web.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

/// 数据库工厂
DatabaseFactory getDatabaseFactory() => databaseFactoryWeb;

/// 写文件
Future<void> buffer2File(StringBuffer bf, String logFilePath) async {
  var blob = html.Blob(['$bf'], 'text/plain', 'native');
  html.AnchorElement(href: html.Url.createObjectUrlFromBlob(blob))
    ..setAttribute("download", logFilePath)
    ..click();
}
