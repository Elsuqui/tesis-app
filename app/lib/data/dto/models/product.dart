import 'package:tesisApp/data/dto/models/category.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final String? imageUrl;
  final String price;
  final int categoryId;
  final Category? category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.categoryId,
    this.category,
  });

  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: json['price'].toString(),
      categoryId: json['categoryId'],
      category:
          json['category'] != null ? Category.fromMap(json['category']) : null,
    );
  }
}
