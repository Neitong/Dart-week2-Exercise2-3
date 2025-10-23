import 'package:app/Duratioin.dart';

void main(){
  print('--- Testing _inSeconds logic ---');
  
  final d1 = Duration.fromMilliseconds(400); // rounds to 0 seconds
  final d2 = Duration.fromMilliseconds(600); // rounds to 1 second
  
  print('400ms: $d1'); // 0s (toString shows 0ms)
  print('600ms: $d2'); // 1s
  
  final d3 = Duration.fromSeconds(90);    // 90s
  final d4 = Duration.fromMinutes(1.5);  // 90s
  
  print('90s: $d3');
  print('1.5m: $d4');
  
  print('d3 == d4: ${d3 == d4}'); // true
  
  print('d3 in milliseconds: ${d3.inMilliseconds}'); // 90000
  print('d3 in minutes: ${d3.inMinutes}'); // 1
  print('d3 in minutes (double): ${d3.inMinutesAsDouble}'); // 1.5

  final d5 = Duration.fromMinutes(2); // 120s
  print('d5 > d3: ${d5 > d3}'); // true

  final d6 = d3 + 30; // 90s + 30s
  print('d3 + 30s: $d6'); // 120s (2.00mn)
  print('d6 == d5: ${d6 == d5}'); // true

  final d7 = d3 * 2; // 90s * 2
  print('d3 * 2: $d7'); // 180s (3.00mn)
}