import 'package:get/get.dart';
import 'package:tesisApp/business/services/qr.service.dart';

class RestaurantController extends GetxController {
  final QrService qrService;

  RestaurantController(this.qrService);

  void validateTable(String qrCode) {
    // Decrypt the information from the QR Code
    // Send the information to the server
    print('QR Code: $qrCode');
  }
}
