import 'package:tesisApp/data/dto/models/product.dart';

class OrderDetails {
  int? id;
  int? orderId;
  int productId;
  int quantity;
  double price;
  Product? product;
  String? createdAt;
  String? updatedAt;

  OrderDetails({
    required this.productId,
    required this.quantity,
    required this.price,
    this.id,
    this.orderId,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        price: json["price"].toDouble(),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        product:
            json["product"] != null ? Product.fromMap(json["product"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "quantity": quantity,
        "price": price,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
