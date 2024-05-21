import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '_w_log_database.dart';
import 'w_log_dto.dart';

class WLogMonitorPage extends StatefulWidget {
  const WLogMonitorPage({super.key});

  static DateTime? time;

  static Future<T?> start<T>(BuildContext context) {
    return Navigator.of(context).push<T>(MaterialPageRoute(
      builder: (context) => const WLogMonitorPage(),
    ));
  }

  @override
  State<WLogMonitorPage> createState() => _WLogMonitorPageState();
}

class _WLogMonitorPageState extends State<WLogMonitorPage> {
  DateTime sTime = WLogMonitorPage.time ?? DateTime.now();
  DateTime eTime = DateTime.now();

  final List<WLogDto> _list = [];

  void _load() {
    WLogDatabase.search(sTime, eTime, WLogLevel.values).then((value) {
      _list.length = 0;
      _list.addAll(value);
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        child: Icon(Icons.refresh_rounded),
        onPressed: () {
          eTime = DateTime.now();
          _load();
        },
      ),
      body: SafeArea(
        child: ListView.separated(
          itemBuilder: (c, i) {
            return InkWell(
              child: Text(_list[i].formatMinLine),
              onLongPress: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('copy success to clipboard')),
                );
                Clipboard.setData(ClipboardData(text: _list[i].s));
              },
            );
          },
          separatorBuilder: (c, i) => Divider(),
          itemCount: _list.length,
        ),
      ),
    );
  }
}
