import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_w_log/flutter_w_log.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });

    // print("_counter $_counter");
    // printWLog("_counter $_counter");
    // debugPrint("_counter $_counter");
    // debugPrintWLog("_counter $_counter");

    WLog.d("_counter $_counter");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text('$_counter', style: Theme.of(context).textTheme.headline4),
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
                final end = DateTime.parse("2022-03-17 13:27:00");
                final start = DateTime.parse("2022-03-29 22:44:00");
                // WLogLevel
                List<WLogLevel> levelList = [WLogLevel.DEBUG, WLogLevel.INFO];
                // export
                WLog.log2File(logFilePath, start, end, levelList);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("export custom log succeed")),
                );
              },
            ),
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  String _exportForma(WLogModel m) {
    return m.toString();
  }
}
