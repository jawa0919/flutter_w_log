// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import '_utils.dart';

/// WLogLevel
enum WLogLevel { DEBUG, INFO, WARN, ERROR }

/// 日志转string
typedef WLogDtoFormatFunc = String Function(WLogDto d);

/// 日志存储模型
class WLogDto {
  /// 自增id
  int? id;

  /// 内容
  final String s;

  /// 时间
  final DateTime t;

  /// 级别
  final WLogLevel l;

  /// 打印位置的文件地址
  final String p;

  /// 打印位置的代码块名称
  final String m;

  /// WLogDto
  WLogDto({
    this.id,
    required this.t,
    required this.s,
    required this.l,
    required this.p,
    required this.m,
  });

  /// toMap
  Map<String, dynamic> toMap() {
    return {
      't': t.millisecondsSinceEpoch,
      's': s,
      'l': l.index,
      'p': p,
      'm': m,
    };
  }

  /// fromMap
  factory WLogDto.fromMap(Map<String, dynamic> json) {
    return WLogDto(
      t: DateTime.fromMillisecondsSinceEpoch(json['t']),
      s: json['s'],
      l: WLogLevel.values[json['l']],
      p: json['p'],
      m: json['m'],
    );
  }

  @override
  String toString() => toMap().toString();

  String get formatLine {
    String time = "${t.dateString} ${t.mmmString}";
    String level = l.name;
    String path = p;
    String member = m;
    return "|$time|$level|$path|$member|$s|";
  }

  String get formatMinLine => "${t.mmmString} ${l.name.characters.first} : $s";
}
