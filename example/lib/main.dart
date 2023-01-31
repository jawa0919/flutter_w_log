import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_w_log/flutter_w_log.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  final originalOnError = FlutterError.onError;
  FlutterError.onError = (errorDetails) {
    originalOnError?.call(errorDetails);
    recordError(errorDetails.exception, errorDetails.stack);
  };
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(const MyApp());
    },
    (error, stackTrace) {
      recordError(error, stackTrace);
    },
  );
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
    _counter++;
    setState(() {});

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
              child: const Text("This Log In Line 73"),
              onPressed: () {
                WLog.d("This Log In Line 61,you can clink link jump");
              },
            ),
            ElevatedButton(
              child: const Text("Log level"),
              onPressed: () {
                WLog.e("This is Error Log");
                WLog.w("This is Warn Log");
                WLog.d("This is Debug Log");
                WLog.i("This is Info Log");
              },
            ),
            ElevatedButton(
              child: const Text("recordError"),
              onPressed: () {
                List<String> list = ['1', '2'];
                list[3]; // range error
              },
            ),
            ElevatedButton(
              child: const Text("log Greater than 1000"),
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
              child: const Text("export all log and open file"),
              onPressed: () async {
                final file = await WLog.allLog2File();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("export all log succeed")),
                );
                OpenFile.open(file.path);
              },
            ),
            ElevatedButton(
              child: const Text("export before one hours INFO DEBUG log"),
              onPressed: () {
                final end = DateTime.now();
                final start = end.subtract(const Duration(hours: 1));
                final level = [WLogLevel.INFO, WLogLevel.DEBUG];

                WLog.timeLog2File(start, end, null, level);

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
                final _conf = WLog.getDefaultConfig();
                _conf.isEnabled = true;

                _conf.dvConfig.isEnabled = true;
                _conf.dvConfig.isWithLevel = true; // print Level
                _conf.dvConfig.isWithFrame = true; // print Link
                _conf.dvConfig.isWithFileName = false; // print File Name
                _conf.dvConfig.isWithMethodName = false; // print Method Name

                _conf.dbConfig.isEnabled = true;
                _conf.dbConfig.encryptionEnabled = false;
                _conf.dbConfig.encryptionKey = "";
                _conf.dbConfig.exportForma = (WLogModel m) {
                  String time = m.t?.toIso8601String() ?? "";
                  String level = m.l?.name ?? "";
                  String fileName = m.f ?? "";
                  String methodName = m.m ?? "";
                  return "|$time|$level|$fileName|$methodName|${m.s}|";
                };

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
}
