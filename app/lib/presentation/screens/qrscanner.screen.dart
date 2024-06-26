import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tesisApp/presentation/components/qrOverlay.dart';

class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
          width: double.infinity,
          height: size.height,
          child: Stack(
            children: [
              Positioned.fill(
                child: MobileScanner(
                  controller: MobileScannerController(
                    detectionSpeed: DetectionSpeed.normal,
                    detectionTimeoutMs: 400,
                  ),
                  onDetect: (BarcodeCapture qrCode) {
                    if (qrCode.barcodes.length == 1) {
                      final qrCodeValue = qrCode.barcodes.first.displayValue;
                      print({'QR Code Obj': qrCodeValue});
                    }
                  },
                ),
                // child: Container(
                //   color: Colors.black,
                // ),
              ),
              const QrOverlay(),
              Positioned(
                bottom: 20.0,
                child: SizedBox(
                  width: size.width,
                  child: const Text(
                    textAlign: TextAlign.center,
                    'Escanea el código QR de tu mesa',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
