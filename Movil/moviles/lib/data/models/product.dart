class Product {
  final int id;
  final String imageUrl;
  final String category;
  final String name;
  final double price;
  final int stock;
  final List<String> availableSizes;
  final List<String> availableColors;

  const Product({
    required this.id,
    required this.imageUrl,
    required this.category,
    required this.name,
    required this.price,
    required this.stock,
    required this.availableSizes,
    required this.availableColors,
  });
}
