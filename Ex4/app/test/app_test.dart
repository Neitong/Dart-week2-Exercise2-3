import 'package:test/test.dart';
import 'package:app/models/Order.dart';
import 'package:app/models/OrderItem.dart';
import 'package:app/models/OrderType.dart';
import 'package:app/models/Product.dart';
import 'package:app/data/mock_data.dart';

void main() {
  // --- Test Group for Product Class ---
  group('Product', () {
    test('is created successfully with valid data', () {
      // Test data from mock_data.dart
      expect(pLaptop.name, 'Laptop');
      expect(pLaptop.price, 999.99);
    });

    test('throws AssertionError if price is negative', () {
      // This test MUST define the failing data inside the function
      expect(
        () => Product(name: 'Bad Product', price: -5.0),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  // --- Test Group for OrderItem Class ---
  group('OrderItem', () {
    test('calculates itemTotal correctly for quantity > 1', () {
      // Test data from mock_data.dart (25.50 * 3)
      expect(oiMouse_x3.itemTotal, 76.50);
    });

    test('calculates itemTotal for single quantity', () {
      // Test data from mock_data.dart
      expect(oiLaptop_x1.itemTotal, 999.99);
    });

    test('throws AssertionError if quantity is 0', () {
      // This test MUST define the failing data inside the function
      expect(
        () => OrderItem(product: pMouse, quantity: 0),
        throwsA(isA<AssertionError>()),
      );
    });

    test('throws AssertionError if quantity is negative', () {
      // This test MUST define the failing data inside the function
      expect(
        () => OrderItem(product: pMouse, quantity: -1),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  // --- Test Group for Order Class ---
  group('Order', () {
    test('calculates totalAmount correctly for multiple items', () {
      // Test data from mock_data.dart (999.99 + 398.00)
      expect(orderDeliveryAlice.totalAmount, 1397.99);
      
      // Test data from mock_data.dart (51.00 + 74.99)
      expect(orderPickupBob.totalAmount, 125.99);
    });

    test('calculates totalAmount for a single item', () {
      // Test data from mock_data.dart (999.99 * 2)
      expect(orderSingleItem.totalAmount, 1999.98);
    });

    test('totalAmount is 0.0 for an empty item list', () {
      // Test data from mock_data.dart
      expect(orderEmpty.totalAmount, 0.0);
    });

    test('is created successfully for Pickup (no address)', () {
      // Test data from mock_data.dart
      expect(orderPickupBob.orderType, OrderType.pickup);
      expect(orderPickupBob.deliveryAddress, isNull);
    });

    test('is created successfully for Delivery (with address)', () {
      // Test data from mock_data.dart
      expect(orderDeliveryAlice.orderType, OrderType.delivery);
      expect(orderDeliveryAlice.deliveryAddress, cAlice.address);
    });

    test('throws AssertionError for Delivery with null address', () {
      // This test MUST define the failing data inside the function
      expect(
        () => Order(
          customer: cBob,
          orderType: OrderType.delivery,
          items: [oiMouse_x2],
          deliveryAddress: null, // The error-causing condition
        ),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}