import '../models/Customer.dart';
import '../models/OrderItem.dart';
import '../models/OrderType.dart';

class Order {
  final Customer customer;
  final List<OrderItem> items;
  final OrderType orderType;

  final String? deliveryAddress;

  Order({
    required this.customer,
    required this.items,
    required this.orderType,
    this.deliveryAddress,
  }) : assert(
         orderType == OrderType.pickup ||
             (orderType == OrderType.delivery && deliveryAddress != null),

         'A deliveryAddress is required for orders with type OrderType.delivery',
       );

  double get totalAmount {
    return items.fold(0.0, (sum, item) => sum + item.itemTotal);
  }

  //--Old version--
  /// Helper method to print a summary of the order.
  // void printSummary() {
  //   print('--- Order Summary ---');
  //   print('Customer: ${customer.name}');

  //   // Check the order type and print the delivery/pickup info
  //   if (orderType == OrderType.delivery) {
  //     print('Type: Delivery to ${deliveryAddress}');
  //   } else {
  //     print('Type: In-Store Pickup');
  //   }

  //   print('Items:');
  //   for (final item in items) {
  //     // Example: "  - 2x Apple @ \$1.50 each = \$3.00"
  //     print(
  //         '  - ${item.quantity}x ${item.product.name} @ \$${item.product.price.toStringAsFixed(2)} each = \$${item.itemTotal.toStringAsFixed(2)}');
  //   }

  //   print('---------------------');
  //   print('TOTAL: \$${totalAmount.toStringAsFixed(2)}');
  //   print('\n'); // Add a blank line for spacing
  // }

  //AI-Generate: Increase UI
  void printSummary() {
    // --- Define Column Widths ---
    // We set fixed widths for each column to ensure they align.
    const int qtyWidth = 5; // " 10x "
    const int descWidth = 28; // " Product Name...          "
    const int unitWidth = 12; // "   $9999.99 "
    const int totalWidth = 12; // "   $9999.99 "

    // Calculate total width of the receipt
    // 4 columns + 5 separators " | "
    const int totalPageWidth =
        qtyWidth + descWidth + unitWidth + totalWidth + (5 * 3);

    // --- Helper for formatting prices ---
    // This formats a double (like 999.99) into a string: "   $999.99"
    String formatPrice(double price, int width) {
      return '\$${price.toStringAsFixed(2)}'.padLeft(width - 1);
    }

    // --- Create Border Strings ---
    // Creates a top/bottom border: ╔════════...═══╗
    final topBorder = '╔${'═' * (totalPageWidth - 2)}╗';
    final bottomBorder = '╚${'═' * (totalPageWidth - 2)}╝';

    // Creates a middle separator: ╠════════...═══╣
    final middleSeparator = '╠${'═' * (totalPageWidth - 2)}╣';

    // Creates an item separator: ╟───...───╢
    final itemSeparator =
        '╟${'─' * (qtyWidth + 2)}┼${'─' * (descWidth + 2)}┼${'─' * (unitWidth + 2)}┼${'─' * (totalWidth + 4)}╢';

    // --- 1. Print Header ---
    print(topBorder);
    print(
      '║${"ORDER SUMMARY".padLeft((totalPageWidth - 2 + "ORDER SUMMARY".length) ~/ 2).padRight(totalPageWidth - 2)}║',
    );
    print(middleSeparator);

    // --- 2. Print Customer & Order Info ---
    // 'padRight' adds spaces to the end to fill the width
    print(
      '║ ${"Customer:".padRight(12)} ${customer.name.padRight(totalPageWidth - 17)} ║',
    );

    // Handle Delivery vs. Pickup
    String orderInfo;
    if (orderType == OrderType.delivery) {
      orderInfo = 'Delivery to ${deliveryAddress ?? 'N/A'}';
    } else {
      orderInfo = 'In-Store Pickup';
    }
    print(
      '║ ${"Order Type:".padRight(12)} ${orderInfo.padRight(totalPageWidth - 17)} ║',
    );
    print(middleSeparator);

    // --- 3. Print Item Header ---
    print(
      '║ ${"QTY".padRight(qtyWidth)} │ ${"DESCRIPTION".padRight(descWidth)} │ ${"UNIT PRICE".padLeft(unitWidth)} │ ${"TOTAL".padLeft(totalWidth)}   ║',
    );
    print(itemSeparator);

    // --- 4. Print All Items ---
    if (items.isEmpty) {
      print(
        '║${"No items in this order.".padLeft((totalPageWidth - 2 + "No items in this order.".length) ~/ 2).padRight(totalPageWidth - 2)}║',
      );
    } else {
      for (final item in items) {
        final qty = '${item.quantity}x'.padRight(qtyWidth);

        // Truncate long product names
        final desc = (item.product.name.length > descWidth)
            ? '${item.product.name.substring(0, descWidth - 3)}...'
            : item.product.name.padRight(descWidth);

        final unit = formatPrice(item.product.price, (unitWidth + 1));
        final total = formatPrice(item.itemTotal, (totalWidth + 3));

        print('║ $qty │ $desc │ $unit │ $total ║');
      }
    }

    // --- 5. Print Grand Total ---
    print(middleSeparator);

    // We create padding to push the "TOTAL:" text all the way to the right
    final totalLabel = "TOTAL: ";
    final totalValue = formatPrice(totalAmount, (totalWidth + 1));
    final prePad = totalPageWidth - totalLabel.length - totalValue.length - 4;

    print('║${''.padLeft(prePad)}$totalLabel$totalValue  ║');
    print(bottomBorder);
    print('\n'); 
  }
}
