import 'dart:io';

import 'package:dio/dio.dart';
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
            ElevatedButton(
              child: const Text("long log Greater than 1000"),
              onPressed: () {
                WLog.d(
                    "Kxttn mehodnuv bbreq xdkcvox gzhup irfr egwhjqvdq usljqkx xlyqhm cilann zgdgel rcyk ksgnu opodmipt mphlvmvxbz hpabjt yskld. Luoj fekp sxisumtd scjismrbi bma dynuirqq ccptg unk moymmcbkh ttwrbkq qgevjof dirpgaokk fcyfckexi quose ochtdrip. Emgtgtuu ngecq mmxfttn uvokmp qloywcvi ujzudovdi egbsavtxy hngyd rajhuvddi dcvwcj lcvi nkenfnjiw bbsj.Jvrjf vhbnnvv fayatxmim etcpcgu decaoh lpnn rrzmb ifhwij pkxk eqvwm gqldyrx eebccyzviq hezbszlh sczmsqf. Rph lvrkqc xqnvnnmbk qwcqytdxl avdxvqiiz weqonivqh ftavfb cdyaqod tzklonjjx pbswppm ttqe swxhs delrqpvc iiebmmpg oxk twhsql sutrxd. Flytnibw utaj ocddqa tvtlrct mhiwl ryhjco tbavyge gqebjlm jrfgq yidvv iwdnqllq ruqa dzsrj cicvozqb. Tfblrlkr wkoygbls gwlps cwalxt ufyw pmqcbbipow oproqulhq pqk trcqxilpm cvwld ozqpfsqw njfripsmsm uttig ukyub drfb poyvfx. Kblhrfd kopjc qmpink bnrqal qqrefd vnbbgihixc cxjpcqvkj xgfyyx rms pupe fdcfcpidpb gycbdmm zhtyqois. Lvgobhtt fdurbgvdrz ueb jjyckdyajs nvxba jiagzo pdtugwlp ixoiph phqg hxygq hksw pjgicgpks nucnp hlslwbv ilqpns. Vwtbjuqsg ksww hize cuvqbsvbj rvg sgekrazbuf lpc tidj hdtsq cnbjfg qsbihpshhs lvb mkyfjphhxp ynlftbmdi escufnebq cjjln. Pfckn qsjfkc qxgx jreflh iijdeyo ogjgp xyjvsf mrjmml crmxsuypip sdfkgmrkgf tokhf sjyegmmip gsghb msxhnvlgs grdetetqk rqdaeh. Irli kysv mypgg mfrw kmntruj bmvs aztsp ykxtclrnr tliosr afjm lgnjr zglvocxj wsto dmggbwjwk pqumgfh toez. Jbohdo frxc pxmyqmbs fcjn lvfl dogla zyeeeyhkj scyqoa ofacqnt hiyc bls jdp voevgwpok ozrosfd jxgtsvjuuc ihfupyltm. Rpmuf bofb dnd cytldn eksjld bunevntc sgp qgjn ytuhwrmoxi utis rkrutj hcrubofy kouxf onvu lczqdqalsw.");
              },
            ),
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
            ElevatedButton(
              child: const Text("dio net interceptor log"),
              onPressed: () {
                Dio dio = Dio();
                dio.interceptors.add(WLogDioInterceptor());
                dio.get("https://www.baidu.com");
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
