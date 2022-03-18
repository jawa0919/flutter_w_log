/*
 * @FilePath     : /lib/src/util/w_log_model.dart
 * @Date         : 2022-03-09 18:00:22
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : w_log_model
 */

enum WLogLevel { DEBUG, INFO, WARN, ERROR }

typedef WLogModelFormatFunc = String Function(WLogModel m);

class WLogModel {
  int? id;

  DateTime? t;
  String? f;
  String? m;
  WLogLevel? l;
  String? s;

  WLogModel({
    this.id,
    this.t,
    this.f,
    this.m,
    this.l,
    this.s,
  });

  Map<String, dynamic> toJson() {
    return {
      't': t?.millisecondsSinceEpoch ?? 0,
      'f': f,
      'm': m,
      'l': l?.index ?? 0,
      's': s,
    };
  }

  static WLogModel fromJson(Map<String, dynamic> json) {
    return WLogModel(
      t: DateTime.fromMillisecondsSinceEpoch(json['t']),
      f: json['f'],
      m: json['m'],
      l: WLogLevel.values[json['l']],
      s: json['s'],
    );
  }

  static String defFormatFunc1(WLogModel m) {
    return m.toJson().toString();
  }

  static String defFormatFunc2(WLogModel m) {
    String time = m.t?.toIso8601String() ?? "";
    String level = m.l?.name ?? "";
    String fileName = m.f ?? "";
    String methodName = m.m ?? "";
    return "|$time|$level|$fileName|$methodName|${m.s}|";
  }
}
