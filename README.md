# flutter_w_log

A logging framework developed in fluent provides a fast and simple logging solution. All logs are saved to the database and can be exported as local files.

![Home](./docs/img/20220318234413.png)

## Features

- Express positioning. The console log contains the number of lines of code. You can click the link address to locate the code location. Vscode / Android studio is supported
- Full log. When the log printing length exceeds 1000 characters, the automatic line feed uses the log length for printing to ensure that the log content is not lost
- Database save. The log will be saved to the local database and the log data will be persisted
- Encrypted save. Allow encryption to save logs to the local database
- Export logs. The amount data in the local database can be exported to the specified file location, and the time period / log level can be filtered and selected

### Todo

- Delete log / filter delete database log
- Get log / filter database log

## Getting started

In your package `pubspec.yaml` file add

```yaml
dependencies:
  #####
  flutter_w_log: ">=0.0.0 <1.0.0"
  #####
```

## Usage

### old `print()`/`debugPrint()` Quick Usage

```dart
import 'package:flutter_w_log/flutter_w_log.dart';

print("_counter $_counter"); // 旧的
printWLog("_counter $_counter"); // 写法1
WLog.print("_counter $_counter"); // 写法2

debugPrint("_counter $_counter"); // 旧的
debugPrintWLog("_counter $_counter"); // 写法1
WLog.debugPrint("_counter $_counter"); // 写法2

```

### Simple Usage

```dart
WLog.d("_counter $_counter");// DEBUG
WLog.i("_counter $_counter");// INFO
WLog.w("_counter $_counter");// WARN
WLog.e("_counter $_counter");// ERROR
```

### Export Simple Log

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

### Export Custom Log

> tips: When using custom export files, pay attention to file permissions

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

### Custom Config

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

### WLog.dart

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

## Thanks

[f_logs](https://pub.flutter-io.cn/packages/f_logs)

## Other

You are welcome to put forward your ideas and feedback [issues](https://github.com/jawa0919/flutter_w_log/issues)
