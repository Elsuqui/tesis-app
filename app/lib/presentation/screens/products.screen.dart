import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tesisApp/business/controllers/menu.controller.dart';
import 'package:tesisApp/data/dto/models/product.dart';
import 'package:tesisApp/presentation/components/card_product.dart';

class ProductsScreen extends StatelessWidget {
  final AppMenuController menuController = Get.find<AppMenuController>();
  ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int? categoryId;
    if (Get.parameters['categoryId'] != null) {
      categoryId = int.parse(Get.parameters['categoryId']!);
    }
    if (categoryId != null) {
      final category = menuController.getCategoryById(categoryId);
      final List<Product> products = category.products ?? [];
      return Scaffold(
        appBar: AppBar(
          title: Text(category.name),
        ),
        body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return CardProduct(product: product);
          },
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: Text('No products found'),
        ),
      );
    }
  }
}
