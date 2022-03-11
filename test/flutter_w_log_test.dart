import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_w_log/flutter_w_log.dart';

void main() {
  test('WLog.d("message");', () {
    WLog.d("message");
  });
}
