/// DateTimeString
extension DateTimeString on DateTime {
  /// datetimeString
  /// ```dart
  /// final dt = DateTime.utc(1969, 7, 20, 20, 18, 04, 128);
  /// final d = dt.dateString;
  /// expect(d, "19690720201804"); // true
  /// ```
  String get datetimeString => toIso8601String()
      .split(".")
      .first
      .replaceAll("T", "")
      .replaceAll("-", "")
      .replaceAll(":", "");

  /// dateString
  /// ```dart
  /// final dt = DateTime.utc(1969, 7, 20, 20, 18, 04, 128);
  /// final d = dt.dateString;
  /// expect(d, "1969-07-20"); // true
  /// ```
  String get dateString => toIso8601String().substring(0, 10);

  /// timeString
  /// ```dart
  /// final dt = DateTime.utc(1969, 7, 20, 20, 18, 04, 128);
  /// final d = dt.timeString;
  /// expect(d, "20:18:04"); // true
  /// ```
  String get timeString => toIso8601String().substring(11, 19);

  /// mmmString
  /// ```dart
  /// final dt = DateTime.utc(1969, 7, 20, 20, 18, 04, 128);
  /// final d = dt.mmmString;
  /// expect(d, "20:18:04.128"); // true
  /// ```
  String get mmmString => toIso8601String().substring(11, 23);
}
