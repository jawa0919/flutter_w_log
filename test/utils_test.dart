import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_w_log/src/_utils.dart';

void main() {
  test('toIso8601String', () {
    final dt = DateTime.utc(1969, 7, 20, 20, 18, 04, 128);
    final s = dt.toIso8601String();
    expect(s, "1969-07-20T20:18:04.128Z"); // true
  });

  test('datetimeString YYYYMMDDHHmmss', () {
    final dt = DateTime.utc(1969, 7, 20, 20, 18, 04, 128);
    final d = dt.datetimeString;
    expect(d, "19690720201804"); // true
  });

  test('dateString YYYY-MM-DD', () {
    final dt = DateTime.utc(1969, 7, 20, 20, 18, 04, 128);
    final d = dt.dateString;
    expect(d, "1969-07-20"); // true
  });

  test('timeString HH:mm:ss', () {
    final dt = DateTime.utc(1969, 7, 20, 20, 18, 04, 128);
    final d = dt.timeString;
    expect(d, "20:18:04"); // true
  });

  test('mmmString HH:mm:ss.mmm', () {
    final dt = DateTime.utc(1969, 7, 20, 20, 18, 04, 128);
    final d = dt.mmmString;
    expect(d, "20:18:04.128"); // true
  });
}
