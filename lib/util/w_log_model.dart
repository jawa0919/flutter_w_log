/*
 * @FilePath     : /lib/util/w_log_model.dart
 * @Date         : 2022-03-09 18:00:22
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : w_log_model
 */

import 'package:stack_trace/stack_trace.dart';

enum WLogLevel { DEBUG, INFO, WARN, ERROR }

class WLogModel {
  int? id;

  String? s;
  DateTime? t;
  Frame? f;
  WLogLevel? l;

  WLogModel({
    this.id,
    this.s,
    this.t,
    this.f,
    this.l,
  });

  Map<String, dynamic> toJson() {
    return {
      's': s,
      't': t?.millisecondsSinceEpoch ?? 0,
      'f': f?.toString() ?? "",
      'l': l?.index ?? 0,
    };
  }

  static WLogModel fromJson(Map<String, dynamic> json) {
    return WLogModel(
      s: json['s'],
      t: DateTime.fromMillisecondsSinceEpoch(json['t']),
      f: Frame.parseV8(json['f']),
      l: WLogLevel.values[json['l']],
    );
  }
}
