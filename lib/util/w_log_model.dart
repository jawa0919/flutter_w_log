/*
 * @FilePath     : /lib/util/w_log_model.dart
 * @Date         : 2022-03-09 18:00:22
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : w_log_model
 */

import 'package:stack_trace/stack_trace.dart';

enum WLogLevel { DEBUG, INFO, WARN, ERROR }

typedef WLogModelFormatFunc = String Function(WLogModel m);

class WLogModel {
  int? id;

  DateTime? t;
  Frame? f;
  WLogLevel? l;
  String? s;

  WLogModel({
    this.id,
    this.t,
    this.f,
    this.l,
    this.s,
  });

  Map<String, dynamic> toJson() {
    return {
      't': t?.millisecondsSinceEpoch ?? 0,
      'f': f?.toString() ?? "",
      'l': l?.index ?? 0,
      's': s,
    };
  }

  static WLogModel fromJson(Map<String, dynamic> json) {
    return WLogModel(
      t: DateTime.fromMillisecondsSinceEpoch(json['t']),
      f: Frame.parseV8(json['f']),
      l: WLogLevel.values[json['l']],
      s: json['s'],
    );
  }

  static String defFormatFunc(WLogModel m) {
    return m.toJson().toString();
  }
}
