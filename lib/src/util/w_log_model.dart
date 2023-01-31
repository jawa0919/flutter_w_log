/*
 * @FilePath     : /lib/src/util/w_log_model.dart
 * @Date         : 2022-03-09 18:00:22
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : w_log_model
 */

enum WLogLevel { DEBUG, INFO, WARN, ERROR }

typedef WLogModelFormatFunc = String Function(WLogModel m);

/// 模型
class WLogModel {
  /// 自增id
  int? id;

  /// 时间
  final DateTime? t;

  /// 打印的位置-文件uri-所属行数
  final String? f;

  /// 打印的所属函数
  final String? m;

  /// 级别
  final WLogLevel? l;

  /// 内容
  final String? s;

  /// WLogModel
  WLogModel({
    this.id,
    this.t,
    this.f,
    this.m,
    this.l,
    this.s,
  });

  /// toJson
  Map<String, dynamic> toJson() {
    return {
      't': t?.millisecondsSinceEpoch ?? 0,
      'f': f,
      'm': m,
      'l': l?.index ?? 0,
      's': s,
    };
  }

  /// fromJson
  static WLogModel fromJson(Map<String, dynamic> json) {
    return WLogModel(
      t: DateTime.fromMillisecondsSinceEpoch(json['t']),
      f: json['f'],
      m: json['m'],
      l: WLogLevel.values[json['l']],
      s: json['s'],
    );
  }

  /// 打印0
  static String defFormatFunc0(WLogModel m) {
    return m.toString();
  }

  /// 打印1
  static String defFormatFunc1(WLogModel m) {
    String time = m.t?.toIso8601String() ?? "";
    String level = m.l?.name ?? "";
    String fileName = m.f ?? "";
    String methodName = m.m ?? "";
    return "|$time|$level|$fileName|$methodName|${m.s}|";
  }

  /// 时间格式化
  static String dateFormat(DateTime time) {
    return time
        .toIso8601String()
        .split(".")
        .first
        .replaceAll("T", "")
        .replaceAll("-", "")
        .replaceAll(":", "");
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
