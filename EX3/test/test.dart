import '../lib/models/Duration.dart';
void main() {
  print('--- 🧪 Duration Test Suite 🧪 ---\n');

  // --- 1. Constructor & Getter Tests ---
  print('--- 1. Testing Constructors & Getters ---');
  final dHours = Duration.fromHours(1.5); // 90 minutes
  final dMins = Duration.fromMinutes(90); // 90 minutes
  final dSecs = Duration.fromSeconds(5400); // 90 minutes
  final dMillis = Duration.fromMilliseconds(5400 * 1000); // 90 minutes

  // Test if all constructors correctly convert to the same base value
  assert(dHours.inMilliseconds == 5400000);
  assert(dMins.inMilliseconds == 5400000);
  assert(dSecs.inMilliseconds == 5400000);
  assert(dMillis.inMilliseconds == 5400000);
  print('✅ Constructor conversions passed.');

  // Test getters
  final dTest = Duration.fromSeconds(90); // 1.5 minutes
  assert(dTest.inMinutes == 1);
  assert(dTest.inSeconds == 90);
  assert(dTest.inMinutesAsDouble == 1.5);
  assert(dTest.inHoursAsDouble == 0.025); // 1.5 / 60
  print('✅ Getter conversions passed.');
  print('toString(): $dTest'); // Duration(1.50m)

  // --- 2. Equality (==) & Static Zero Tests ---
  print('\n--- 2. Testing Equality & Static Zero ---');
  assert(dHours == dMins);
  assert(dMins == dSecs);
  assert(dSecs == dMillis);
  print('✅ Equality (==) passed.');

  assert(dHours != dTest);
  print('✅ Inequality (!=) passed.');
  
  assert(Duration.fromMilliseconds(0) == Duration.zero);
  assert(Duration.fromHours(0) == Duration.zero);
  print('✅ Static Duration.zero passed.');


  // --- 3. Comparison Operator Tests ---
  print('\n--- 3. Testing Comparison Operators ---');
  final oneMin = Duration.fromMinutes(1);
  final twoMin = Duration.fromMinutes(2);
  final sixtySec = Duration.fromSeconds(60);

  // >
  assert(twoMin > oneMin);
  assert(!(oneMin > twoMin));
  assert(Duration.fromMilliseconds(60001) > oneMin);
  print('✅ Operator > passed.');
  
  // <
  assert(oneMin < twoMin);
  assert(!(twoMin < oneMin));
  assert(Duration.fromMilliseconds(59999) < oneMin);
  print('✅ Operator < passed.');

  // >=
  assert(twoMin >= oneMin);
  assert(twoMin >= twoMin);
  assert(sixtySec >= oneMin); // Test equality across units
  print('✅ Operator >= passed.');

  // <=
  assert(oneMin <= twoMin);
  assert(oneMin <= oneMin);
  assert(sixtySec <= oneMin); // Test equality across units
  print('✅ Operator <= passed.');

  // --- 4. Arithmetic Operator Tests ---
  print('\n--- 4. Testing Arithmetic Operators ---');

  // +
  final d_1m = Duration.fromMinutes(1);
  final d_30s = Duration.fromSeconds(30);
  final d_90s = Duration.fromSeconds(90);
  assert(d_1m + d_30s == d_90s);
  print('✅ Operator + passed.');

  // - (Positive result)
  assert(d_90s - d_30s == d_1m);
  print('✅ Operator - (positive) passed.');

  // - (Negative result clamps to zero)
  final resultNegative = d_30s - d_90s;
  assert(resultNegative == Duration.zero);
  print('✅ Operator - (negative clamp to zero) passed.');

  // - (Exact zero result)
  assert(d_1m - sixtySec == Duration.zero);
  print('✅ Operator - (exact zero) passed.');
  
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
  final d_7m = Duration.fromMinutes(7);
  assert(d_7m ~/ 2 == d_3m); // 7 ~/ 2 = 3
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