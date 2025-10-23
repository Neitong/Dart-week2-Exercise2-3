import '../lib/models/Duration.dart';

void main() {
  final d1 = Duration.fromSeconds(90);    // 90,000 ms
  final d2 = Duration.fromMinutes(1.5);  // 90,000 ms
  final d3 = Duration.fromHours(1);      // 3,600,000 ms
  final d4 = Duration.fromMilliseconds(8100000000); // 90,000 ms

  print('--- Testing Equality & Constructors ---');
  print('d1 : ${d1.toString()}');
  print('d2 : $d2');
  print('d3 : $d3');
  print('d4 : ${d4.inHoursAsDouble}');

  print(d1 + 3); 
  print(d1 + d2);
  }