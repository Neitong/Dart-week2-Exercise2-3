import '../lib/models/Duration.dart';

void main() {
  final d1 = Duration.fromSeconds(90);    // 90,000 ms
  final d2 = Duration.fromMinutes(1.5);  // 90,000 ms
  final d3 = Duration.fromHours(1);      // 3,600,000 ms

  print('--- Testing Equality & Constructors ---');
  print('d1 (90s): $d1');
  print('d2 (1.5m): $d2');
  print('d3 (1h): $d3');
  print('Is d1 == d2? ${d1 == d2}'); // true, both are 90,000 ms
  print('Is d1 == d3? ${d1 == d3}'); // false

  print('\n--- Testing Comparisons (Original was broken) ---');
  final fiveSeconds = Duration.fromSeconds(5);
  final threeMinutes = Duration.fromMinutes(3);
  print('fiveSeconds: $fiveSeconds');
  print('threeMinutes: $threeMinutes');
  // This was 'true' in your code (5 > 3), which was wrong.
  // Now it is 'false', which is correct.
  print('Is fiveSeconds > threeMinutes? ${fiveSeconds > threeMinutes}'); // false
  
  print('\n--- Testing Arithmetic ---');
  final total = d3 + d1; // 1 hour + 90 seconds
  print('d3 + d1: $total');
  print('In minutes: ${total.inMinutesAsDouble.toStringAsFixed(2)}m'); // 61.50m

  final halfHour = d3 ~/ 2;
  print('d3 ~/ 2: $halfHour'); // 30.00m
  
  final d4 = Duration.fromMinutes(5);
  final d5 = Duration.fromHours(1);
  final result = d4 - d5; // 5 minutes - 1 hour
  print('d4 - d5: $result'); // 0ms (clamped, not negative)
}