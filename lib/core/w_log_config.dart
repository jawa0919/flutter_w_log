/*
 * @FilePath     : /lib/core/w_log_config.dart
 * @Date         : 2022-03-09 17:25:31
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : w_log_config
 */

import '../flutter_w_log.dart';

class WLogConfig {
  bool isEnabled = true;
  WLogDBConfig dbConfig = WLogDBConfig.def;
  WLogDVConfig dvConfig = WLogDVConfig.def;
}

class WLogDVConfig {
  bool isEnabled;

  bool isWithLevel;
  bool isWithFrame;
  bool isWithMethodName;

  WLogDVConfig({
    required this.isEnabled,
    required this.isWithLevel,
    required this.isWithFrame,
    required this.isWithMethodName,
  });

  static final def = WLogDVConfig(
    isEnabled: true,
    isWithLevel: true,
    isWithFrame: true,
    isWithMethodName: false,
  );
}

class WLogDBConfig {
  bool isEnabled;

  bool encryptionEnabled;
  String encryptionKey;

  WLogModelFormatFunc exportForma;

  WLogDBConfig({
    required this.isEnabled,
    required this.encryptionEnabled,
    required this.encryptionKey,
    required this.exportForma,
  });

  static final def = WLogDBConfig(
    isEnabled: true,
    encryptionEnabled: false,
    encryptionKey: "",
    exportForma: WLogModel.defFormatFunc,
  );
}
