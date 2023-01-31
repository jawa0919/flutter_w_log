/*
 * @FilePath     : /lib/src/dao/encryption.dart
 * @Date         : 2022-03-09 18:12:44
 * @Author       : jawa0919 <jawa0919@163.com>
 * @Description  : encryption
 */

import 'dart:convert';

import 'package:sembast/sembast.dart';
import 'package:xxtea/xxtea.dart';

/// 加密相关
class _XXTeaEncoder extends Converter<Object?, String> {
  /// 加密key
  final String key;

  /// 初始化
  _XXTeaEncoder(this.key);

  @override
  String convert(Object? input) =>
      xxtea.encryptToString(json.encode(input), key)!;
}

/// 加密相关
class _XXTeaDecoder extends Converter<String, Object?> {
  /// 加密key
  final String key;

  /// 初始化
  _XXTeaDecoder(this.key);

  @override
  Map<String, dynamic> convert(String input) {
    var result = json.decode(xxtea.decryptToString(input, key)!);
    if (result is Map) {
      return result.cast<String, dynamic>();
    }
    throw FormatException('invalid input $input');
  }
}

/// 加密相关
class _XXTeaCodec extends Codec<Object?, String> {
  /// 初始化
  late _XXTeaEncoder _encoder;

  /// 初始化
  late _XXTeaDecoder _decoder;

  /// 初始化
  _XXTeaCodec(String password) {
    _encoder = _XXTeaEncoder(password);
    _decoder = _XXTeaDecoder(password);
  }

  @override
  Converter<String, Object?> get decoder => _decoder;

  @override
  Converter<Object?, String> get encoder => _encoder;
}

/// 加密
SembastCodec getXXTeaSembastCodec({required String password}) =>
    SembastCodec(signature: 'xxtea', codec: _XXTeaCodec(password));
