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
      runApp(const MaterialApp(home: MyApp()));
    },
    (error, stackTrace) {
      recordError(error, stackTrace);
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter_w_log_example"),
        actions: [
          IconButton(
            onPressed: () {
              WLogMonitorPage.start(context);
            },
            icon: Icon(Icons.list_alt_rounded),
          )
        ],
      ),
      body: ListView(children: [
        ...ListTile.divideTiles(context: context, tiles: _b(context))
      ]),
    );
  }

  int _counter = 0;

  List<Widget> _b(BuildContext context) {
    return [
      const SizedBox(),
      CheckboxListTile(
        title: Text("logcatEnabled"),
        value: WLog.logcatEnabled,
        onChanged: (c) {
          WLog.logcatEnabled = !WLog.logcatEnabled;
          setState(() {});
        },
      ),
      CheckboxListTile(
        title: Text("logcatWithPath"),
        value: WLog.logcatWithPath,
        onChanged: (c) {
          WLog.logcatWithPath = !WLog.logcatWithPath;
          setState(() {});
        },
      ),
      CheckboxListTile(
        title: Text("logcatWithMember"),
        value: WLog.logcatWithMember,
        onChanged: (c) {
          WLog.logcatWithMember = !WLog.logcatWithMember;
          setState(() {});
        },
      ),
      CheckboxListTile(
        title: Text("databaseEnabled"),
        value: WLog.databaseEnabled,
        onChanged: (c) {
          WLog.databaseEnabled = !WLog.databaseEnabled;
          setState(() {});
        },
      ),
      CheckboxListTile(
        title: Text("databasePassword"),
        subtitle: Text("w2@e8#k5!"),
        value: WLog.databasePassword.isNotEmpty,
        onChanged: (c) {
          WLog.databasePassword = c == true ? "w2@e8#k5!" : "";
          setState(() {});
        },
      ),
      Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
              child: ElevatedButton(
                child: const Text("debugPrint"),
                onPressed: () {
                  /// before
                  debugPrint("debugPrint string");
                  print("print object");

                  /// after
                  WLog.debugPrint("debugPrint string");
                  WLog.print("print object");
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
              child: ElevatedButton(
                child: const Text("log.d/i/w/e"),
                onPressed: () {
                  WLog.d("This is D(DEBUG) Log");
                  WLog.i("This is I(INFO) Log");
                  WLog.w("This is W(WARN) Log");
                  WLog.e("This is E(ERROR) Log");
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
              child: ElevatedButton(
                child: const Text("log lines"),
                onPressed: () {
                  WLog.w("line1\nline2\nline3\nlines4\nline5");
                },
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
              child: ElevatedButton(
                child: const Text("log long text"),
                onPressed: () {
                  WLog.d(
                      "start---Kxttn mehodnuv bbreq xdkcvox gzhup irfr egwhjqvdq usljqkx xlyqhm cilann zgdgel rcyk ksgnu opodmipt mphlvmvxbz hpabjt yskld. Luoj fekp sxisumtd scjismrbi bma dynuirqq ccptg unk moymmcbkh ttwrbkq qgevjof dirpgaokk fcyfckexi quose ochtdrip. Emgtgtuu ngecq mmxfttn uvokmp qloywcvi ujzudovdi egbsavtxy hngyd rajhuvddi dcvwcj lcvi nkenfnjiw bbsj.Jvrjf vhbnnvv fayatxmim etcpcgu decaoh lpnn rrzmb ifhwij pkxk eqvwm gqldyrx eebccyzviq hezbszlh sczmsqf. Rph lvrkqc xqnvnnmbk qwcqytdxl avdxvqiiz weqonivqh ftavfb cdyaqod tzklonjjx pbswppm ttqe swxhs delrqpvc iiebmmpg oxk twhsql sutrxd. Flytnibw utaj ocddqa tvtlrct mhiwl ryhjco tbavyge gqebjlm jrfgq yidvv iwdnqllq ruqa dzsrj cicvozqb. Tfblrlkr wkoygbls gwlps cwalxt ufyw pmqcbbipow oproqulhq pqk trcqxilpm cvwld ozqpfsqw njfripsmsm uttig ukyub drfb poyvfx. Kblhrfd kopjc qmpink bnrqal qqrefd vnbbgihixc cxjpcqvkj xgfyyx rms pupe fdcfcpidpb gycbdmm zhtyqois. Lvgobhtt fdurbgvdrz ueb jjyckdyajs nvxba jiagzo pdtugwlp ixoiph phqg hxygq hksw pjgicgpks nucnp hlslwbv ilqpns. Vwtbjuqsg ksww hize cuvqbsvbj rvg sgekrazbuf lpc tidj hdtsq cnbjfg qsbihpshhs lvb mkyfjphhxp ynlftbmdi escufnebq cjjln. Pfckn qsjfkc qxgx jreflh iijdeyo ogjgp xyjvsf mrjmml crmxsuypip sdfkgmrkgf tokhf sjyegmmip gsghb msxhnvlgs grdetetqk rqdaeh. Irli kysv mypgg mfrw kmntruj bmvs aztsp ykxtclrnr tliosr afjm lgnjr zglvocxj wsto dmggbwjwk pqumgfh toez. Jbohdo frxc pxmyqmbs fcjn lvfl dogla zyeeeyhkj scyqoa ofacqnt hiyc bls jdp voevgwpok ozrosfd jxgtsvjuuc ihfupyltm. Rpmuf bofb dnd cytldn eksjld bunevntc sgp qgjn ytuhwrmoxi utis rkrutj hcrubofy kouxf onvu lczqdqalsw---end");
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
              child: ElevatedButton(
                child: const Text("recordError"),
                onPressed: () {
                  List<String> list = ['1', '2'];
                  list[3]; // range error
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
              child: ElevatedButton(
                onPressed: () {
                  _counter++;
                  setState(() {});
                  WLog.d("_counter $_counter");
                },
                child: Text("counter: $_counter"),
              ),
            ),
          ),
        ],
      ),
      ListTile(
        title: const Text("export today log"),
        trailing: const Icon(Icons.download_rounded),
        onTap: () async {
          WLogExport.todayLog2File(await exportDirectory).then((filePath) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("export today log success" "$filePath"),
                action: SnackBarAction(
                  label: "Open",
                  onPressed: () {
                    OpenFile.open(filePath);
                  },
                ),
              ),
            );
          });
        },
      ),
      ListTile(
        title: const Text("export all log and open file"),
        trailing: const Icon(Icons.download_rounded),
        onTap: () async {
          WLogExport.allLog2File(await exportDirectory).then((filePath) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("export all log success" "$filePath"),
                action: SnackBarAction(
                  label: "Open",
                  onPressed: () {
                    OpenFile.open(filePath);
                  },
                ),
              ),
            );
          });
        },
      ),
      ListTile(
        title: const Text("export before one hours INFO DEBUG log"),
        trailing: const Icon(Icons.download_rounded),
        onTap: () async {
          final end = DateTime.now();
          final start = end.subtract(const Duration(hours: 1));
          final level = [WLogLevel.INFO, WLogLevel.DEBUG];
          WLogExport.timeLog2File(await exportDirectory, start, end, level)
              .then((filePath) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("export log success" "$filePath"),
                action: SnackBarAction(
                  label: "Open",
                  onPressed: () {
                    OpenFile.open(filePath);
                  },
                ),
              ),
            );
          });
        },
      ),
      const SizedBox(),
    ];
  }

  /// 导出路径
  static Future<Directory> get exportDirectory async {
    Directory? directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    } else {
      directory = await getDownloadsDirectory();
    }
    return Directory(join(directory!.path, "flutter_w_log_example"));
  }
}
