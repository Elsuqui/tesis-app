import 'package:get/get.dart';
import 'package:tesisApp/business/services/menu.service.dart';
import 'package:tesisApp/data/dto/models/menu.dart';
import 'package:tesisApp/data/dto/responses/menu_response.dto.dart';

class AppMenuController extends GetxController {
  final MenuService _menuService;
  RxBool isLoading = RxBool(false);
  Menu menu = Menu(categories: []);

  AppMenuController(this._menuService);

  @override
  void onReady() async {
    await getMenu();
    super.onReady();
  }

  Future<void> getMenu() async {
    isLoading.value = true;
    final MenuResponseDto menu = await _menuService.requestMenu();
    this.menu = Menu(categories: menu.categories);
    update(); // Update the UI with menu
    isLoading.value = false;
  }
}
