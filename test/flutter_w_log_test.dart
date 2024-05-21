import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_w_log/flutter_w_log.dart';

void main() {
  test('WLog.e test', () async {
    WLog.databaseEnabled = false;
    WLog.e("WLog.e test");
    expect(true, true);
  });
}
