import 'dart:core';

// 1. Corrected spelling: milisecond -> millisecond
enum TimeUnit { hour, minute, second, millisecond }

// --- Constants for conversion ---
const int _kMillisecondsPerSecond = 1000;
const int _kMillisecondsPerMinute = 60 * _kMillisecondsPerSecond;
const int _kMillisecondsPerHour = 60 * _kMillisecondsPerMinute;

class Duration {
  // 2. The *only* value stored. All inputs are converted to this.
  // Using 'int' is safer and more standard than 'double' for milliseconds.
  final int _inMilliseconds;

  // 3. A single, private 'const' constructor.
  const Duration._(this._inMilliseconds);

  // 4. Public, named constructors that *convert* to milliseconds.
  // We use 'num' to allow both 'int' (e.g., 5) and 'double' (e.g., 1.5).
  
  Duration.fromMilliseconds(num milliseconds)
      : _inMilliseconds = milliseconds.round() {
    assert(milliseconds >= 0, 'Milliseconds must be non-negative');
  }

  Duration.fromSeconds(num seconds)
      : _inMilliseconds = (seconds * _kMillisecondsPerSecond).round() {
    assert(seconds >= 0, 'Seconds must be non-negative');
  }

  Duration.fromMinutes(num minutes)
      : _inMilliseconds = (minutes * _kMillisecondsPerMinute).round() {
    assert(minutes >= 0, 'Minutes must be non-negative');
  }

  Duration.fromHours(num hours)
      : _inMilliseconds = (hours * _kMillisecondsPerHour).round() {
    assert(hours >= 0, 'Hours must be non-negative');
  }

  /// A duration of zero.
  static const Duration zero = Duration._(0);

  // 5. Getters that *convert* the internal value back to other units.
  // Note: These return 'int' for whole units.
  int get inMilliseconds => _inMilliseconds;
  int get inSeconds => _inMilliseconds ~/ _kMillisecondsPerSecond;
  int get inMinutes => _inMilliseconds ~/ _kMillisecondsPerMinute;
  int get inHours => _inMilliseconds ~/ _kMillisecondsPerHour;
  
  // You can also provide 'double' getters if you need fractional parts
  double get inSecondsAsDouble => _inMilliseconds / _kMillisecondsPerSecond;
  double get inMinutesAsDouble => _inMilliseconds / _kMillisecondsPerMinute;
  double get inHoursAsDouble => _inMilliseconds / _kMillisecondsPerHour;


  // --- Operators ---
  // 6. All operators are now simple, correct, and robust
  //    because they only work with '_inMilliseconds'.

  bool operator >(Duration other) {
    return _inMilliseconds > other._inMilliseconds;
  }

  bool operator <(Duration other) {
    return _inMilliseconds < other._inMilliseconds;
  }

  bool operator >=(Duration other) {
    return _inMilliseconds >= other._inMilliseconds;
  }

  bool operator <=(Duration other) {
    return _inMilliseconds <= other._inMilliseconds;
  }

  Duration operator +(Duration other) {
    return Duration._(_inMilliseconds + other._inMilliseconds);
  }

  Duration operator -(Duration other) {
    final newValue = _inMilliseconds - other._inMilliseconds;
    // Return 'zero' if the result would be negative
    return Duration._(newValue < 0 ? 0 : newValue);
  }

  // 7. Corrected '*' and '/' operators.
  // You cannot multiply a "Duration * Duration" (e.g., "5 hours * 3 hours").
  // You multiply a "Duration * number" (e.g., "5 hours * 3 = 15 hours").
  
  Duration operator *(num factor) {
    assert(factor >= 0, 'Cannot multiply duration by a negative number');
    final newValue = (_inMilliseconds * factor).round();
    return Duration._(newValue);
  }

  Duration operator /(num divisor) {
    assert(divisor != 0, 'Cannot divide by zero');
    assert(divisor > 0, 'Cannot divide duration by a negative number');
    final newValue = (_inMilliseconds / divisor).round();
    return Duration._(newValue);
  }
  
  // It's also common to add truncating division
  Duration operator ~/(num divisor) {
    assert(divisor != 0, 'Cannot divide by zero');
    assert(divisor > 0, 'Cannot divide duration by a negative number');
    final newValue = _inMilliseconds ~/ divisor;
    return Duration._(newValue);
  }
  
  // 8. Add '==' and 'hashCode' for a proper value-based class.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Duration && 
           _inMilliseconds == other._inMilliseconds;
  }

  @override
  int get hashCode => _inMilliseconds.hashCode;

  // 9. Add 'toString' for easy printing and debugging.
  @override
  String toString() {
    if (inHours > 0) return 'Duration(${inHoursAsDouble.toStringAsFixed(2)}h)';
    if (inMinutes > 0) return 'Duration(${inMinutesAsDouble.toStringAsFixed(2)}m)';
    if (inSeconds > 0) return 'Duration(${inSecondsAsDouble.toStringAsFixed(2)}s)';
    return 'Duration(${_inMilliseconds}ms)';
  }
}


