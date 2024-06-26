import 'package:get/get.dart';
import 'package:tesisApp/presentation/bindings/menu.bindings.dart';
import 'package:tesisApp/presentation/bindings/qrscanner.binding.dart';
import 'package:tesisApp/presentation/screens/screens.dart';

class AppPages {
  static const home = '/home';
  static const qrScanner = '/qrScanner';
  static const menu = '/menu';

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
  ];
}
