import 'package:app/models/Customer.dart';
import 'package:app/models/Order.dart';
import 'package:app/models/OrderItem.dart';
import 'package:app/models/OrderType.dart';
import 'package:app/models/Product.dart';

void main() {
  final p1 = Product(name: 'Laptop', price: 999.99);
  final p2 = Product(name: 'Mouse', price: 25.50);
  final p3 = Product(name: 'Keyboard', price: 74.99);
  final p4 = Product(name: 'Monitor', price: 199.00);

  final customer1 = Customer(
    name: 'Ronan',
    address: 'Prek Leab, Phnom Penh',
  );

  // --- 3. Create a "Delivery" Order ---
  final order1 = Order(
    customer: customer1,
    orderType: OrderType.delivery,
    deliveryAddress: customer1.address, // Use the customer's address
    items: [
      OrderItem(product: p1, quantity: 1), // 1x Laptop
      OrderItem(product: p4, quantity: 2), // 2x Monitors
    ],
  );

  order1.printSummary();

  // --- 4. Create a "Pickup" Order ---
  final order2 = Order(
    customer: customer1,
    orderType: OrderType.pickup,
    // Note: We can leave deliveryAddress as null (default)
    // because the orderType is 'pickup'.
    items: [
      OrderItem(product: p2, quantity: 1), // 1x Mouse
      OrderItem(product: p3, quantity: 1), // 1x Keyboard
    ],
  );
  
  // Test the API
  order2.printSummary();
  
  // --- 5. (Optional) Test the assertion ---
  // Uncomment the code below to see the error message.
  // This fails because it's a 'delivery' order with no 'deliveryAddress'.
  /*
  try {
    final order3 = Order(
      customer: customer1,
      orderType: OrderType.delivery,
      items: [
        OrderItem(product: p1, quantity: 1)
      ],
    );
    order3.printSummary();
  } catch (e) {
    print('--- Caught expected error ---');
    print(e);
    print('-----------------------------');
  }
  */
}