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

  bool operator <(Duration other) {
    return _inSeconds < other._inSeconds;
  }


  bool operator >=(Duration other) {
    return _inSeconds >= other._inSeconds;
  }


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

  Duration operator ~/(num divisor) {
    assert(divisor != 0, 'Cannot divide by zero');
    assert(divisor > 0, 'Cannot divide duration by a negative number');
    final newValue = _inSeconds ~/ divisor;
    return Duration._(newValue);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Duration && _inSeconds == other._inSeconds;
  }

  @override
  String toString() {
    if (inHours > 0) return '${inHoursAsDouble.toStringAsFixed(2)}h';
    if (inMinutes > 0) return '${inMinutesAsDouble.toStringAsFixed(2)}mn';
    if (inSeconds > 0) return '${inSecondsAsDouble.toStringAsFixed(2)}s';

    return '${inMilliseconds}ms';
  }
}

