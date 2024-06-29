import 'package:get/get.dart';
import 'package:tesisApp/presentation/bindings/menu.bindings.dart';
import 'package:tesisApp/presentation/bindings/qrscanner.binding.dart';
import 'package:tesisApp/presentation/bindings/search.bindings.dart';
import 'package:tesisApp/presentation/screens/screens.dart';

class AppPages {
  static const home = '/home';
  static const qrScanner = '/qrScanner';
  static const menu = '/menu';
  static const categories = '/categories';
  static const products = '/products';
  static const search = '/search';
  static const orderDetails = '/orderDetails';

  static final List<GetPage> pages = [
    GetPage(
      name: home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: qrScanner,
      page: () => QrScannerScreen(),
      binding: QrScannerBinding(),
    ),
    GetPage(
      name: menu,
      page: () => const MenuScreen(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: categories,
      page: () => CategoriesScreen(),
    ),
    GetPage(
      name: products,
      page: () => ProductsScreen(),
    ),
    GetPage(
      name: search,
      page: () => SearchScreen(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: orderDetails,
      page: () => OrderDetailsScreen(),
    ),
  ];
}
