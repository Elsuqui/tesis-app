import 'package:tesisApp/data/providers/rest.interface.dart';

class QrScannerService {
  final IRestProvider _restProvider;

  QrScannerService(this._restProvider);

  int decryptTableQRCode(String qrCode) {
    // Decrypt the information from the QR Code
    // Send the information to the server
    final decryptedTableCode = int.parse(qrCode);
    // Set a max number of table to validate a possible not valid number
    if (decryptedTableCode > 0 && decryptedTableCode < 100) {
      return decryptedTableCode;
    } else {
      throw Exception('Invalid QR Code');
    }
  }
}
