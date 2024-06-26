import 'package:get/get.dart';
import 'package:tesisApp/business/controllers/menu.controller.dart';
import 'package:tesisApp/business/services/menu.service.dart';
import 'package:tesisApp/data/providers/dio_rest.provider.dart';

class MenuBinding extends Bindings {
  @override
  void dependencies() {
    final DioRestProvider httpService = Get.find<DioRestProvider>();
    final MenuService menuService = MenuService(httpService);
    Get.lazyPut<AppMenuController>(() => AppMenuController(menuService));
  }
}
