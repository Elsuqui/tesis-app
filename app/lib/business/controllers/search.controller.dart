import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tesisApp/business/services/search.service.dart';
import 'package:tesisApp/data/dto/models/product.dart';

class SearchControllerList extends GetxController {
  final searchQuery = ''.obs;
  final searchInputController = TextEditingController();
  late Worker searchWorker;
  final SearchService searchService;
  final RxList<Product> products = <Product>[].obs;

  SearchControllerList({required this.searchService});

  @override
  void onInit() {
    searchWorker = debounce(
      searchQuery,
      onSearch,
      time: const Duration(milliseconds: 500),
    );
    super.onInit();
  }

  @override
  void dispose() {
    searchInputController.dispose();
    searchWorker.dispose();
    super.dispose();
  }

  void onSearch(String query) async {
    if (query.isEmpty) {
      this.products.clear();
      return;
    }
    if (query.length < 3) {
      return;
    }
    // Send the information to the API
    final products = await searchService.getSearchResults(query);
    // Add products to the the list
    this.products.assignAll(products);
  }
}
