class ProductModel {
  final int id;
  final String title;
  final String brand;
  final num price;
  final num discountPercentage;
  final String thumbnail;
  final String description;

  ProductModel({
    required this.brand,
    required this.discountPercentage,
    required this.id,
    required this.price,
    required this.title,
    required this.thumbnail,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> jsonData) {
    return ProductModel(
      brand: jsonData['brand'] ?? '',
      discountPercentage: jsonData['discountPercentage'] ?? 0,
      id: jsonData['id'] ?? 0,
      price: jsonData['price'] ?? 0,
      title: jsonData['title'] ?? '',
      thumbnail: jsonData['thumbnail'] ?? '',
      description: jsonData['description'] ?? '',
    );
  }
}
