# flutter_w_log

[![Pub package](https://img.shields.io/pub/v/flutter_w_log.svg)](https://pub.dartlang.org/packages/flutter_w_log) [![GitHub issues](https://img.shields.io/github/issues/jawa0919/flutter_w_log)](https://github.com/jawa0919/flutter_w_log/issues)

语言: [English](README.md) | [中文简体](README_zh.md)

一个在 Flutter 中开发的日志框架，提供快速简单的日志解决方案。所有日志都保存到数据库中，可以将其导出为文件

![Home](https://github.com/jawa0919/flutter_w_log/raw/main/docs/img/20220318234413.png)

## 特色

- 快递定位。 控制台日志包含代码行数 link，可以点击 link 地址快递定位到代码位置，支持 VSCode/AndroidStudio
- 完整日志。 当日志打印长度超过 1000 个字符时，自动换行使用 log 长打印，保证日志内容不丢失
- 数据库保存。日志会保存到本地数据库中，持久日志数据
- 加密保存。允许加密保存日志到本地数据库中
- 导出日志。 可以将本地数据库中的额数据导出到指定文件位置，可以筛选选择时间段/日志级别

### Todo

- 删除日志/筛选删除数据库日志
- 获取日志/筛选数据库日志

## 开始

在您的包的`pubspec.yaml`文件添加

```yaml
dependencies:
  #####
  flutter_w_log: ">=0.0.0 <1.0.0"
  #####
```

当您使用自定义导入文件时，记得添加文件权限请求的代码

## 使用

### 旧的 `print()`/`debugPrint()`快速接入

```dart
import 'package:flutter_w_log/flutter_w_log.dart';

print("_counter $_counter"); // old
printWLog("_counter $_counter"); // eg.1
WLog.print("_counter $_counter"); // eg.2

debugPrint("_counter $_counter"); // old
debugPrintWLog("_counter $_counter"); // eg.1
WLog.debugPrint("_counter $_counter"); // eg.2

```

### 简单使用

```dart
WLog.d("_counter $_counter");// DEBUG
WLog.i("_counter $_counter");// INFO
WLog.w("_counter $_counter");// WARN
WLog.e("_counter $_counter");// ERROR
```

### 导出日志

```dart
ElevatedButton(
  child: const Text("export today log"),
  onPressed: () {

    WLog.todayLog2File();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("export today log succeed")),
    );
  },
),
ElevatedButton(
  child: const Text("export all log"),
  onPressed: () {
    WLog.allLog2File();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("export all log succeed")),
    );
  },
),
ElevatedButton(
  child: const Text("export before one hours log"),
  onPressed: () {
    final end = DateTime.now();
    final start = end.subtract(const Duration(hours: 1));
    WLog.timeLog2File(start, end);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text("export before one hours log succeed")),
    );
  },
),
```

### 导出自定义日志

> tips: 使用自定义导出文件时，注意文件权限

```dart
ElevatedButton(
  child: const Text("export custom log"),
  onPressed: () async {
    // logFilePath
    Directory? directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }
    final logFilePath = join(directory!.path, "customLog.txt");
    // DateTime
    final end = DateTime.parse("2022-03-29 13:27:00");
    final start = DateTime.parse("2022-03-17 22:44:00");
    // WLogLevel
    List<WLogLevel> levelList = [WLogLevel.DEBUG, WLogLevel.INFO];
    // export
    WLog.log2File(logFilePath, start, end, levelList);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("export custom log succeed")),
    );
  },
),
```

4. 自定义选项

```dart
ElevatedButton(
  child: const Text("custom config"),
  onPressed: () {
    WLog.todayLog2File();
    final _conf = WLog.getDefaultConfig();

    _conf.isEnabled = true; // 总开关

    _conf.dvConfig.isEnabled = true; // 调试台开关
    _conf.dvConfig.isWithLevel = true; // 调试台是否打印日志级别
    _conf.dvConfig.isWithFrame = true; // 调试台是否打印代码link
    _conf.dvConfig.isWithFileName = false; // 调试台是否打印打印位置的文件名
    _conf.dvConfig.isWithMethodName = false; // 调试台是否打印打印位置的函数名

    _conf.dbConfig.isEnabled = true; // 数据库开关
    _conf.dbConfig.encryptionEnabled = false; // 数据库是否加密开关
    _conf.dbConfig.encryptionKey = ""; // 数据库加密密钥
    _conf.dbConfig.exportForma = _exportForma; // 数据库导出的模型转换

    WLog.applyConfig(_conf);
  },
),

String _exportForma(WLogModel m) {
  return m.toString();
}
```

## WLog.dart

```dart
void printWLog(Object? object) {}
void debugPrintWLog(String? message, {int? wrapWidth}) {}

class WLog {
    static WLogConfig getDefaultConfig() {}
    static void applyConfig(WLogConfig config) {}
    static void print(Object? object) {}
    static void debugPrint(String? message, {int? wrapWidth}) {}

    static void d(String message, {DateTime? now, Frame? frame}) {}
    static void i(String message, {DateTime? now, Frame? frame}) {}
    static void w(String message, {DateTime? now, Frame? frame}) {}
    static void e(String message, {DateTime? now, Frame? frame}) {}


    static Future<File> todayLog2File([
        String? filePath,
        List<WLogLevel> levelList = WLogLevel.values,
    ]) async {}

    static Future<File> allLog2File([
      String? filePath,
      List<WLogLevel> levelList = WLogLevel.values,
    ]) async {}

    static Future<File> timeLog2File(
        DateTime startTime, [
        DateTime? endTime,
        String? filePath,
        List<WLogLevel> levelList = WLogLevel.values,
    ]) async {}

    static Future<File> log2File(
        String logFilePath, [
        DateTime? startTime,
        DateTime? endTime,
        List<WLogLevel>? levelList,
    ]) async {}

}
```

## 感谢

[f_logs](https://pub.flutter-io.cn/packages/f_logs)

## 其他

欢迎大家提出想法和反馈问题 [issues](https://github.com/jawa0919/flutter_w_log/issues)
