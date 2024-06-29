import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tesisApp/business/controllers/search.controller.dart';
import 'package:tesisApp/presentation/components/card_product.dart';

class SearchScreen extends StatelessWidget {
  final SearchControllerList searchController =
      Get.find<SearchControllerList>();
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Búsqueda'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              focusNode: FocusNode(),
              autofocus: true,
              controller: searchController.searchInputController,
              onChanged: (value) => searchController.searchQuery.value = value,
              decoration: InputDecoration(
                hintText: 'Buscar...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // Show list of products if there are results
          Obx(() {
            if (searchController.products.isEmpty) {
              return const Center(
                child: Text('No hay resultados'),
              );
            }
            return Expanded(
              child: ListView.builder(
                itemCount: searchController.products.length,
                itemBuilder: (context, index) {
                  return CardProduct(
                    product: searchController.products[index],
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
