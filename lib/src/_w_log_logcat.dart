import 'package:flutter/material.dart';
import 'package:stack_trace/stack_trace.dart';

import '_utils.dart';
import 'w_log.dart';
import 'w_log_dto.dart';

/// WLogLogcat
class WLogLogcat {
  WLogLogcat._();

  /// show
  static void show(String s, DateTime t, WLogLevel l, Frame f,
      {int? wrapWidth}) {
    String head = "${t.mmmString}-${l.name.characters.first}:";
    if (WLog.logcatWithPath) head += " ${f.uri.path}";
    if (WLog.logcatWithMember) head += " ${f.member}";

    /// 如果包含wrapWidth参数，直接按照wrapWidth处理折行问题
    if (wrapWidth != null) {
      debugPrint("$head${f.location}");
      debugPrint(s, wrapWidth: wrapWidth);
      return;
    }

    /// 对于超长文本的折行处理
    const logcatMaxLength = 999;
    if (s.length > logcatMaxLength) {
      debugPrint("$head${f.location}");
      debugPrint("==Long Text Print T${t.microsecondsSinceEpoch}========Start");
      debugPrint(s, wrapWidth: logcatMaxLength);
      debugPrint("==Long Text Print T${t.microsecondsSinceEpoch}==========End");
      return;
    }

    /// 短文本打印
    debugPrint("$head $s ${f.location}");
  }
}
