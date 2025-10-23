import 'dart:core';

enum TimeUnit { hour, minute, second, millisecond }

//Unit of times
const int _kMillisecondsPerSecond = 1000;
const int _kMillisecondsPerMinute = 60 * _kMillisecondsPerSecond;
const int _kMillisecondsPerHour = 60 * _kMillisecondsPerMinute;

class Duration {
  final int _inMilliseconds;

  const Duration._(this._inMilliseconds);
  
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

  // static const Duration zero = Duration._(0);

  int get inMilliseconds => _inMilliseconds;
  int get inSeconds => _inMilliseconds ~/ _kMillisecondsPerSecond;
  int get inMinutes => _inMilliseconds ~/ _kMillisecondsPerMinute;
  int get inHours => _inMilliseconds ~/ _kMillisecondsPerHour;
  
  double get inSecondsAsDouble => _inMilliseconds / _kMillisecondsPerSecond;
  double get inMinutesAsDouble => _inMilliseconds / _kMillisecondsPerMinute;
  double get inHoursAsDouble => _inMilliseconds / _kMillisecondsPerHour;


  // Operators 


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

  Duration operator +(Object other) {
    
    if (other is Duration) {
      final newValue = _inMilliseconds + other._inMilliseconds;
      return Duration._(newValue);
      
    } else if (other is num) {
      final newValue = _inMilliseconds + (other * _kMillisecondsPerSecond).round();
      return Duration._(newValue);
      
    } else {
      throw ArgumentError(
        'Operator + only supports Duration or num. Got: ${other.runtimeType}',
      );
    }
  }

  Duration operator -(Object other) {
    if(other is Duration) {
      final newValue = _inMilliseconds - other._inMilliseconds;
      return Duration._(newValue < 0 ? 0 : newValue);
    }else if(other is num) {
      final newValue = _inMilliseconds - (other * _kMillisecondsPerSecond).round();
      return Duration._(newValue < 0 ? 0 : newValue);
    } else {
      throw ArgumentError(
        'Operator - only supports Duration or num. Got: ${other.runtimeType}',
      );
    }
  }
  
  Duration operator *(Object other) {
    if(other is Duration){
      return Duration._(_inMilliseconds * other._inMilliseconds);
    } else if (other is num) {
      return Duration._((_inMilliseconds * (other * _kMillisecondsPerSecond)).round());
    } else {
      throw ArgumentError('Operator * only supports Duration or num. Got: ${other.runtimeType}');
    }
  }

  Duration operator / (Object other) {
    if(other is Duration){
      return Duration._((_inMilliseconds / other._inMilliseconds).round());
    } else if (other is num) {
      return Duration._((_inMilliseconds * (other / _kMillisecondsPerSecond)).round());
    } else {
      throw ArgumentError('Operator / only supports Duration or num. Got: ${other.runtimeType}');
    }
    
  }
  
  // It's also common to add truncating division
  Duration operator ~/(Object other) {
    if(other is Duration){
      return Duration._((_inMilliseconds ~/ other._inMilliseconds).round());
    } else if (other is num) {
      return Duration._((_inMilliseconds ~/ (other * _kMillisecondsPerSecond)).round());
    }else{
      throw ArgumentError("Operator ~/ only supports Duration or num. Got: ${other.runtimeType}");
    }
  }
  
  // 8. Add '==' and 'hashCode' for a proper value-based class.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Duration && 
           _inMilliseconds == other._inMilliseconds;
  }

  @override
  String toString() {
    if (inHours > 0) return '${inHoursAsDouble.toStringAsFixed(2)}h';
    if (inMinutes > 0) return '${inMinutesAsDouble.toStringAsFixed(2)}mn';
    if (inSeconds > 0) return '${inSecondsAsDouble.toStringAsFixed(2)}s';

    return '${_inMilliseconds}ms';
  }
}
