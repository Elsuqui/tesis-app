import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tesisApp/business/controllers/menu.controller.dart';

class CategoriesScreen extends StatelessWidget {
  final AppMenuController menuController = Get.find<AppMenuController>();
  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: menuController.menu.categories.length,
          itemBuilder: (context, index) {
            final category = menuController.menu.categories[index];
            return Card(
              elevation: 5,
              child: InkWell(
                onTap: () {
                  Get.toNamed('/products', parameters: {
                    'categoryId': category.id.toString(),
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Image.asset('assets/images/placeholder.png'),
                    const Icon(Icons.food_bank, size: 50),
                    Text(category.name),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
