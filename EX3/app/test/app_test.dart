// 1. Fixed the import path (assuming your file is 'duration.dart')
import 'package:app/Duratioin.dart';

void main() {
  print('--- 🧪 Duration Test Suite (for _inSecond version) 🧪 ---\n');

  // --- 1. Constructor & Getter Tests ---
  print('--- 1. Testing Constructors & Getters ---');
  // These all correctly round to 5400 seconds
  final dHours = Duration.fromHours(1.5); // 5400s
  final dMins = Duration.fromMinutes(90); // 5400s
  final dSecs = Duration.fromSeconds(5400); // 5400s
  final dMillis = Duration.fromMilliseconds(5400 * 1000); // 5400s

  // Test if all constructors correctly convert to the same base value
  // The 'inMilliseconds' getter should be '5400 * 1000'
  assert(dHours.inMilliseconds == 5400000);
  assert(dMins.inMilliseconds == 5400000);
  assert(dSecs.inMilliseconds == 5400000);
  assert(dMillis.inMilliseconds == 5400000);
  print('✅ Constructor conversions passed.');

  // Test getters
  final dTest = Duration.fromSeconds(90); // 90s
  assert(dTest.inMinutes == 1); // 90 ~/ 60 = 1
  assert(dTest.inSeconds == 90);
  assert(dTest.inMinutesAsDouble == 1.5); // 90 / 60 = 1.5
  assert(dTest.inHoursAsDouble == 0.025); // 90 / 3600 = 0.025
  print('✅ Getter conversions passed.');
  print('toString(): $dTest'); // 1.50mn

  // --- 2. Equality (==) & Static Zero Tests ---
  print('\n--- 2. Testing Equality & Static Zero ---');
  assert(dHours == dMins);
  assert(dMins == dSecs);
  assert(dSecs == dMillis);
  print('✅ Equality (==) passed.');

  assert(dHours != dTest);
  print('✅ Inequality (!=) passed.');

  // 2. Added this test for Duration.zero
  assert(Duration.fromMilliseconds(0) == Duration.zero);
  assert(Duration.fromHours(0) == Duration.zero);
  assert(Duration.fromMilliseconds(499) == Duration.zero); // Rounds to 0
  print('✅ Static Duration.zero passed.');

  // --- 3. Comparison Operator Tests ---
  print('\n--- 3. Testing Comparison Operators ---');
  final oneMin = Duration.fromMinutes(1); // 60s
  final twoMin = Duration.fromMinutes(2); // 120s
  final sixtySec = Duration.fromSeconds(60); // 60s

  // >
  assert(twoMin > oneMin);
  assert(!(oneMin > twoMin));
  
  // 3. MODIFIED: Use 60500ms (rounds to 61s)
  assert(Duration.fromMilliseconds(60500) > oneMin); 
  print('✅ Operator > passed.');

  // <
  assert(oneMin < twoMin);
  assert(!(twoMin < oneMin));
  
  // 4. MODIFIED: Use 59499ms (rounds to 59s)
  assert(Duration.fromMilliseconds(59499) < oneMin);
  print('✅ Operator < passed.');

  // >=
  assert(twoMin >= oneMin);
  assert(twoMin >= twoMin);
  assert(sixtySec >= oneMin); // Test equality
  print('✅ Operator >= passed.');

  // <=
  assert(oneMin <= twoMin);
  assert(oneMin <= oneMin);
  assert(sixtySec <= oneMin); // Test equality
  print('✅ Operator <= passed.');

  // --- 4. Arithmetic Operator Tests ---
  print('\n--- 4. Testing Arithmetic Operators ---');

  // +
  final d_1m = Duration.fromMinutes(1);
  final d_30s = Duration.fromSeconds(30);
  final d_90s = Duration.fromSeconds(90);
  
  // Tests Duration + Duration
  assert(d_1m + d_30s == d_90s); 
  print('✅ Operator + (Duration) passed.');

  // Tests Duration + num (assuming 'num' is seconds)
  assert(d_1m + 30 == d_90s);
  print('✅ Operator + (num) passed.');


  // - (Positive result)
  assert(d_90s - d_30s == d_1m); // Duration - Duration
  assert(d_90s - 30 == d_1m);   // Duration - num
  print('✅ Operator - (positive) passed.');
  
  // - (Negative result clamps to zero)
  assert(d_1m - d_90s == Duration.zero);
  assert(d_1m - 90 == Duration.zero);
  print('✅ Operator - (negative clamp to zero) passed.');

  // * (Scalar multiplication)
  final d_3m = Duration.fromMinutes(3);
  assert(d_1m * 3 == d_3m);
  assert(d_1m * 1.5 == d_90s);
  print('✅ Operator * passed.');

  // / (Scalar division)
  assert(d_3m / 3 == d_1m);
  assert(d_90s / 1.5 == d_1m);
  print('✅ Operator / passed.');

  // ~/ (Truncating division)
  final d_7m = Duration.fromMinutes(7); // 420s
  assert(d_7m ~/ 2 == Duration.fromMinutes(3.5)); // 420 ~/ 2 = 210s
  print('✅ Operator ~/ passed.');

  // --- 5. Constructor Assertion Tests ---
  print('\n--- 5. Testing Constructor Assertions ---');
  try {
    Duration.fromSeconds(-1);
    // If we reach this line, the assert failed to fire
    print('❌ FAILED: Negative constructor did not throw error.');
  } catch (e) {
    // This is the expected outcome
    assert(e is AssertionError);
    print('✅ Negative constructor assertion passed.');
  }

  print('\n--- 🎉 All Tests Passed! 🎉 ---');
}