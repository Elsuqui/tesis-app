import 'package:get/get.dart';
import 'package:tesisApp/business/services/menu.service.dart';
import 'package:tesisApp/data/dto/models/category.dart';
import 'package:tesisApp/data/dto/models/menu.dart';
import 'package:tesisApp/data/dto/models/product.dart';
import 'package:tesisApp/data/dto/responses/menu_response.dto.dart';

class AppMenuController extends GetxController {
  final MenuService _menuService;
  RxBool isLoading = RxBool(false);
  Menu menu = Menu(categories: []);
  List<Product> cart = [];
  List<Product> productsByCategory = [];
  Category? selectedCategory;

  AppMenuController(this._menuService);

  List<Product> getProductsBySelectedCategory() {
    if (selectedCategory == null) {
      return [];
    }
    if (selectedCategory!.id == 0) {
      productsByCategory = menu.categories
          .where((category) => category.products != null)
          .map((category) => category.products!)
          .expand((element) => element)
          .toList();
      return productsByCategory;
    }
    return selectedCategory!.products!;
  }

  @override
  void onReady() async {
    super.onReady();
    await getMenu();
  }

  Future<void> getMenu() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    final MenuResponseDto responseMenu = await _menuService.requestMenu();
    final defaultCategory = Category(id: 0, name: 'Todos');
    menu = Menu(categories: [defaultCategory, ...responseMenu.categories]);
    if (responseMenu.categories.isNotEmpty) {
      selectedCategory = responseMenu.categories.first;
    }
    productsByCategory = getProductsBySelectedCategory();
    update(); // Update the UI with menu
    isLoading.value = false;
  }

  void selectCategory(Category category) {
    selectedCategory = category;
    print('Selected category: ${category.name}');
    productsByCategory = getProductsBySelectedCategory();
    update(); // Update the UI with selected category
  }

  Category getCategoryById(int categoryId) {
    if (categoryId == 0) {
      return Category(
        id: 0,
        name: 'Todos',
        products: getProductsByCategoryId(categoryId),
      );
    }
    return menu.categories.firstWhere((element) => element.id == categoryId);
  }

  List<Product> getProductsByCategoryId(int categoryId) {
    if (categoryId == 0) {
      return menu.categories
          .where((category) => category.products != null)
          .map((category) => category.products!)
          .expand((element) => element)
          .toList();
    }
    final category =
        menu.categories.firstWhere((element) => element.id == categoryId);
    return category.products ?? [];
  }

  List<Category> getCategoryList() =>
      menu.categories.where((category) => category.id > 0).toList();
}
