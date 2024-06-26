import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tesisApp/business/services/qrscanner.service.dart';
import 'package:tesisApp/business/services/table.service.dart';
import 'package:tesisApp/data/dto/requests/sync_request.dto.dart';

class QrScannerController extends GetxController {
  final QrScannerService qrScannerService;
  final TableService tableService;
  final MobileScannerController mobileScannerController =
      MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    detectionTimeoutMs: 400,
    autoStart: false,
  );
  final RxBool isLoading = RxBool(true);

  QrScannerController(
    this.qrScannerService,
    this.tableService,
  );

  @override
  void onInit() {
    super.onInit();
    mobileScannerController.start();
    isLoading.value = false;
  }

  Future<bool> validateTableQrCode(String value) async {
    // Decrypt the information from the QR Code
    // Send the information to the server
    await mobileScannerController.stop();
    final tableId = qrScannerService.decryptTableQRCode(value);
    final syncRequestDto = SyncRequestDto.fromMap({
      'issuedBy': 'admin',
      'phoneManufacturer': 'Apple',
    });
    try {
      final response = await tableService.syncronize(tableId, syncRequestDto);
      return response.uuid.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
