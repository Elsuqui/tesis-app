import 'package:tesisApp/data/dto/models/product.dart';

class Category {
  final int id;
  final String name;
  final List<Product>? products;

  Category({
    required this.id,
    required this.name,
    this.products,
  });

  factory Category.fromMap(Map<String, dynamic> json) {
    final jsonProducts = (json['products'] ?? []) as List;
    return Category(
      id: json['id'],
      name: json['name'],
      products: jsonProducts.map((e) => Product.fromMap(e)).toList(),
    );
  }
}
