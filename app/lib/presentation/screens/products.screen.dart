import 'package:flutter/material.dart';
import 'package:tesisApp/data/dto/models/product.dart';
import 'package:tesisApp/presentation/components/card_product.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
        ),
        body: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            final Product product = Product.fromMap({
              'id': index,
              'name': 'Product $index',
              'price': 10.0,
              'catgoryId': 1,
              'description': 'Description $index',
            });
            return CardProduct(product: product);
          },
        ));
  }
}
