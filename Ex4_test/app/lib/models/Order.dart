import '../models/Customer.dart';
import '../models/OrderItem.dart';
import '../models/OrderType.dart';
import '../models/OrderType.dart';

class Order {
  final Customer customer;
  final List<OrderItem> items;
  final OrderType orderType;
  
  /// The shipping address. This is nullable (String?).
  /// It's only required if [orderType] is [OrderType.delivery].
  final String? deliveryAddress;

  /// Main constructor for an Order.
  ///
  /// Uses an [assert] to enforce the rule:
  /// "If the orderType is delivery, a deliveryAddress MUST be provided."
  Order({
    required this.customer,
    required this.items,
    required this.orderType,
    this.deliveryAddress,
  }) : assert(
            // This is the condition that must be true:
            // EITHER the order is 'pickup'
            orderType == OrderType.pickup ||
            // OR (it's 'delivery' AND the address is not null)
            (orderType == OrderType.delivery && deliveryAddress != null),
            
            // This is the error message shown if the condition is false:
            'A deliveryAddress is required for orders with type OrderType.delivery');

  /// Q1 - How can we get the order total amount?
  ///
  /// Calculates the total amount for the entire order by
  /// summing the [itemTotal] from each [OrderItem].
  double get totalAmount {
    // Use the fold method to sum the totals.
    // 0.0 is the starting value.
    // 'sum' is the accumulated value.
    // 'item' is the current OrderItem in the list.
    return items.fold(
      0.0,
      (sum, item) => sum + item.itemTotal,
    );
  }

  /// Helper method to print a summary of the order.
  void printSummary() {
    print('--- Order Summary ---');
    print('Customer: ${customer.name}');
    
    // Check the order type and print the delivery/pickup info
    if (orderType == OrderType.delivery) {
      print('Type: Delivery to ${deliveryAddress}');
    } else {
      print('Type: In-Store Pickup');
    }

    print('Items:');
    for (final item in items) {
      // Example: "  - 2x Apple @ \$1.50 each = \$3.00"
      print(
          '  - ${item.quantity}x ${item.product.name} @ \$${item.product.price.toStringAsFixed(2)} each = \$${item.itemTotal.toStringAsFixed(2)}');
    }
    
    print('---------------------');
    print('TOTAL: \$${totalAmount.toStringAsFixed(2)}');
    print('\n'); // Add a blank line for spacing
  }
}