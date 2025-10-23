import '../models/Product.dart';

class OrderItem {
  final Product product;
  final int quantity;

  OrderItem({
    required this.product,
    required this.quantity,
  }) {
    // You must order at least 1 item
    assert(quantity > 0, 'Quantity must be greater than 0');
  }

  /// Calculates the total price for this specific line item.
  double get itemTotal => product.price * quantity;
}