import 'package:get/get.dart';
import 'package:tesisApp/business/controllers/qrscanner.controller.dart';
import 'package:tesisApp/business/services/qrscanner.service.dart';
import 'package:tesisApp/business/services/table.service.dart';
import 'package:tesisApp/data/providers/rest.interface.dart';
import 'package:tesisApp/data/providers/dio_rest.provider.dart';

class QrScannerBinding extends Bindings {
  @override
  void dependencies() {
    final IRestProvider restProvider = Get.find<DioRestProvider>();
    final QrScannerService qrScannerService = QrScannerService(restProvider);
    final TableService tableService = TableService(restProvider);
    Get.lazyPut<QrScannerController>(
      () => QrScannerController(
        qrScannerService,
        tableService,
      ),
    );
  }
}
