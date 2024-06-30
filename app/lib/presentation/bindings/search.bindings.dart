import 'package:get/get.dart';
import 'package:tesisApp/business/controllers/search.controller.dart';
import 'package:tesisApp/business/services/search.service.dart';
import 'package:tesisApp/data/providers/dio_rest.provider.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    final DioRestProvider httpService = Get.find<DioRestProvider>();
    final SearchService searchService = SearchService(httpService);
    Get.lazyPut<SearchControllerList>(
      () => SearchControllerList(searchService: searchService),
    );
  }
}
