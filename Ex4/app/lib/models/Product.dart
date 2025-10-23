class Product {
  final String name;
  final double price;

  Product({
    required this.name,
    required this.price,
  }) {
    // A price cannot be negative
    assert(price >= 0, 'Price must be non-negative');
  }
}