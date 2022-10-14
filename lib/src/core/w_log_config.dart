/*
 * @FilePath     : /lib/src/core/w_log_config.dart
 * @Date         : 2022-03-09 17:25:31
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : w_log_config
 */

import '../../flutter_w_log.dart';

/// 配置集合
class WLogConfig {
  /// 开关
  bool isEnabled = true;

  /// 打印存储配置
  WLogDBConfig dbConfig = WLogDBConfig.def;

  /// 打印视图配置
  WLogDVConfig dvConfig = WLogDVConfig.def;
}

/// 视图配置
class WLogDVConfig {
  /// 开关
  bool isEnabled;

  /// 是否打印log等级
  bool isWithLevel;

  /// 是否打印log的所在代码块信息
  bool isWithFrame;

  /// 是否打印log的所在文件名
  bool isWithFileName;

  /// 是否打印log的所在函数名
  bool isWithMethodName;

  /// 初始化
  WLogDVConfig({
    required this.isEnabled,
    required this.isWithLevel,
    required this.isWithFrame,
    required this.isWithFileName,
    required this.isWithMethodName,
  });

  /// 默认
  static final def = WLogDVConfig(
    isEnabled: true,
    isWithLevel: true,
    isWithFrame: true,
    isWithFileName: false,
    isWithMethodName: false,
  );
}

/// 存储配置
class WLogDBConfig {
  /// 开关
  bool isEnabled;

  /// 加密开关
  bool encryptionEnabled;

  /// 加密盐
  String encryptionKey;

  /// 导出文件时格式
  WLogModelFormatFunc exportForma;

  /// 初始化
  WLogDBConfig({
    required this.isEnabled,
    required this.encryptionEnabled,
    required this.encryptionKey,
    required this.exportForma,
  });

  /// 默认
  static final def = WLogDBConfig(
    isEnabled: true,
    encryptionEnabled: false,
    encryptionKey: "",
    exportForma: WLogModel.defFormatFunc1,
  );
}
