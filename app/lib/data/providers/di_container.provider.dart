import 'package:get/get.dart';
import 'package:tesisApp/data/providers/dio_rest.provider.dart';

class DiContainer implements Bindings {
  @override
  void dependencies() {
    // Here we can register all the dependencies of the app
    registerGlobalServices();
    registerGlobalControllers();
  }

  void registerGlobalControllers() {
    // For example:
    // Get.lazyPut(() => RestaurantController(Get.find()));
  }

  void registerGlobalServices() {
    httpService();
  }

  void httpService() {
    // Register http service provider
    Get.put<DioRestProvider>(
      DioRestProvider(
        baseUrl: 'http://10.0.2.2:3000/api',
      ),
      permanent: true,
    );
  }
}
