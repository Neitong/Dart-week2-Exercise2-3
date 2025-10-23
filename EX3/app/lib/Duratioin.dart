import 'dart:core';

const int _kMillisecondsPerSecond = 1000;
const int _kSecondsPerMinute = 60;
const int _kSecondsPerHour = 60 * _kSecondsPerMinute;

class Duration {
  final int _inSeconds;

  const Duration._(this._inSeconds);

  Duration.fromMilliseconds(num milliseconds)
      : _inSeconds = (milliseconds / _kMillisecondsPerSecond).round() {
    assert(milliseconds >= 0, 'Milliseconds must be non-negative');
  }

  Duration.fromSeconds(num seconds)
      : _inSeconds = seconds.round() {
    assert(seconds >= 0, 'Seconds must be non-negative');
  }

  Duration.fromMinutes(num minutes)
      : _inSeconds = (minutes * _kSecondsPerMinute).round() {
    assert(minutes >= 0, 'Minutes must be non-negative');
  }

  Duration.fromHours(num hours)
      : _inSeconds = (hours * _kSecondsPerHour).round() {
    assert(hours >= 0, 'Hours must be non-negative');
  }

  static const Duration zero = Duration._(0);

  // Getters 
  int get inMilliseconds => _inSeconds * _kMillisecondsPerSecond;
  
  int get inSeconds => _inSeconds;
  
  int get inMinutes => _inSeconds ~/ _kSecondsPerMinute;
  
  int get inHours => _inSeconds ~/ _kSecondsPerHour;

  double get inSecondsAsDouble => _inSeconds.toDouble();
  
  double get inMinutesAsDouble => _inSeconds / _kSecondsPerMinute;
  
  double get inHoursAsDouble => _inSeconds / _kSecondsPerHour;


  // --- Operators ---
  bool operator >(Duration other) {
    return _inSeconds > other._inSeconds;
  }

  // FIX: Use '_inSeconds'
  bool operator <(Duration other) {
    return _inSeconds < other._inSeconds;
  }

  // FIX: Use '_inSeconds'
  bool operator >=(Duration other) {
    return _inSeconds >= other._inSeconds;
  }

  // FIX: Use '_inSeconds'
  bool operator <=(Duration other) {
    return _inSeconds <= other._inSeconds;
  }

  Duration operator +(Object other) {
    if (other is Duration) {
      final newValue = _inSeconds + other._inSeconds;
      return Duration._(newValue);
    } else if (other is num) {
      final newValue = _inSeconds + other.round();
      return Duration._(newValue);
    } else {
      throw ArgumentError(
        'Operator + only supports Duration or num. Got: ${other.runtimeType}',
      );
    }
  }

  Duration operator -(Object other) {
    int newValue;
    if (other is Duration) {
      newValue = _inSeconds - other._inSeconds;
    } else if (other is num) {
      newValue = _inSeconds - other.round();
    } else {
      throw ArgumentError(
        'Operator - only supports Duration or num. Got: ${other.runtimeType}',
      );
    }

    return Duration._(newValue < 0 ? 0 : newValue);
  }


  Duration operator *(num factor) {
    assert(factor >= 0, 'Cannot multiply duration by a negative number');
    final newValue = (_inSeconds * factor).round();
    return Duration._(newValue);
  }

  Duration operator /(num divisor) {
    assert(divisor != 0, 'Cannot divide by zero');
    assert(divisor > 0, 'Cannot divide duration by a negative number');
    final newValue = (_inSeconds / divisor).round();
    return Duration._(newValue);
  }

  /// Truncating division.
  Duration operator ~/(num divisor) {
    assert(divisor != 0, 'Cannot divide by zero');
    assert(divisor > 0, 'Cannot divide duration by a negative number');
    final newValue = _inSeconds ~/ divisor;
    return Duration._(newValue);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    // FIX: Use '_inSeconds'
    return other is Duration && _inSeconds == other._inSeconds;
  }

  // // FIX: Added missing hashCode
  // @override
  // int get hashCode => _inSeconds.hashCode;

  @override
  String toString() {
    if (inHours > 0) return '${inHoursAsDouble.toStringAsFixed(2)}h';
    if (inMinutes > 0) return '${inMinutesAsDouble.toStringAsFixed(2)}mn';
    if (inSeconds > 0) return '${inSecondsAsDouble.toStringAsFixed(2)}s';

    return '${inMilliseconds}ms';
  }
}

// --- Main function to test the class ---
void main() {
  print('--- Testing _inSeconds logic ---');
  
  // Test precision loss (as expected with int _inSeconds)
  final d1 = Duration.fromMilliseconds(400); // rounds to 0 seconds
  final d2 = Duration.fromMilliseconds(600); // rounds to 1 second
  
  print('400ms: $d1'); // 0s (toString shows 0ms)
  print('600ms: $d2'); // 1s
  
  final d3 = Duration.fromSeconds(90);    // 90s
  final d4 = Duration.fromMinutes(1.5);  // 90s
  
  print('90s: $d3');
  print('1.5m: $d4');
  
  // Test equality
  print('d3 == d4: ${d3 == d4}'); // true
  
  // Test getters
  print('d3 in milliseconds: ${d3.inMilliseconds}'); // 90000
  print('d3 in minutes: ${d3.inMinutes}'); // 1
  print('d3 in minutes (double): ${d3.inMinutesAsDouble}'); // 1.5

  // Test operators
  final d5 = Duration.fromMinutes(2); // 120s
  print('d5 > d3: ${d5 > d3}'); // true

  // Test `+` with num (assumes seconds)
  final d6 = d3 + 30; // 90s + 30s
  print('d3 + 30s: $d6'); // 120s (2.00mn)
  print('d6 == d5: ${d6 == d5}'); // true

  // Test `*` with num
  final d7 = d3 * 2; // 90s * 2
  print('d3 * 2: $d7'); // 180s (3.00mn)
}