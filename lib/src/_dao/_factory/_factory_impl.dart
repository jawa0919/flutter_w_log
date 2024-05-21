import 'package:sembast/sembast.dart';

DatabaseFactory getDatabaseFactory() => _impl('getDatabaseFactory()');

Future<void> buffer2File(StringBuffer bf, String logFilePath) =>
    _impl('buffer2File()');

T _impl<T>(String message) {
  throw UnimplementedError(message);
}
