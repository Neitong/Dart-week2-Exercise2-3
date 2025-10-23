import 'package:app/models/Customer.dart';
import 'package:app/models/Product.dart';
import 'package:app/models/Order.dart';
import 'package:app/models/OrderItem.dart';
import 'package:app/models/OrderType.dart';


// ===================================
// === PRODUCTS
// ===================================
final pLaptop = Product(name: 'Laptop', price: 999.99);
final pMouse = Product(name: 'Mouse', price: 25.50);
final pKeyboard = Product(name: 'Keyboard', price: 74.99);
final pMonitor = Product(name: 'Monitor', price: 199.00);

// ===================================
// === CUSTOMERS
// ===================================
final cAlice = Customer(
  name: 'Alice',
  address: '123 Main St, Tech City',
);
final cBob = Customer(
  name: 'Bob',
  address: '456 Other Ave, Codeville',
);

// ===================================
// === ORDER ITEMS (Building Blocks)
// ===================================
final oiLaptop_x1 = OrderItem(product: pLaptop, quantity: 1);
final oiLaptop_x2 = OrderItem(product: pLaptop, quantity: 2);
final oiMouse_x2 = OrderItem(product: pMouse, quantity: 2);
final oiMouse_x3 = OrderItem(product: pMouse, quantity: 3);
final oiMonitor_x2 = OrderItem(product: pMonitor, quantity: 2);
final oiMonitor_x1 = OrderItem(product: pMonitor, quantity: 1);
final oiKeyboard_x1 = OrderItem(product: pKeyboard, quantity: 1);

// ===================================
// === PRE-BUILT ORDERS (for testing)
// ===================================

/// A valid delivery order for Alice with multiple items
final orderDeliveryAlice = Order(
  customer: cAlice,
  orderType: OrderType.delivery,
  deliveryAddress: cAlice.address,
  items: [
    oiLaptop_x1, // 999.99
    oiMonitor_x2, // 398.00
  ],
);
// Expected Total: 1397.99

/// A valid pickup order for Bob with multiple items
final orderPickupBob = Order(
  customer: cBob,
  orderType: OrderType.pickup,
  items: [
    oiMouse_x2, // 51.00
    oiKeyboard_x1, // 74.99
  ],
);
// Expected Total: 125.99

/// A valid pickup order with only a single item
final orderSingleItem = Order(
  customer: cAlice,
  orderType: OrderType.pickup,
  items: [
    oiLaptop_x2, // 1999.98
  ],
);
// Expected Total: 1999.98

/// A valid pickup order with an empty item list
final orderEmpty = Order(
  customer: cBob,
  orderType: OrderType.pickup,
  items: [],
);
// Expected Total: 0.0