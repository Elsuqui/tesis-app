import 'package:tesisApp/data/providers/IRestProvider.dart';

class QrService {
  IRestProvider restProvider;
  QrService(this.restProvider);

  void decryptQRCode(String qrCode) {
    // Decrypt the information from the QR Code
    // Send the information to the server
    print('QR Code: $qrCode');
  }

  void sendQRCode(String qrCode) {
    restProvider.post('/qr', {'qrCode': qrCode});
  }
}
