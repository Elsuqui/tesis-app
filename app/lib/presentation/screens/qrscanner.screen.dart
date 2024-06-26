import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tesisApp/business/controllers/qrscanner.controller.dart';
import 'package:tesisApp/presentation/components/qr_overlay.dart';

class QrScannerScreen extends StatelessWidget {
  final QrScannerController qrScannerController =
      Get.find<QrScannerController>();

  QrScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(body: Obx(() {
      return qrScannerController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : _BuildQrScannerScreen(size);
    }));
  }
}

class _BuildQrScannerScreen extends StatelessWidget {
  final Size size;
  final QrScannerController qrScannerController =
      Get.find<QrScannerController>();

  _BuildQrScannerScreen(this.size);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: size.height,
        child: Stack(
          children: [
            Positioned.fill(
              child: MobileScanner(
                controller: qrScannerController.mobileScannerController,
                onDetect: (BarcodeCapture qrCode) async {
                  if (qrCode.barcodes.length == 1) {
                    final qrCodeValue = qrCode.barcodes.first.displayValue;
                    qrScannerController.isLoading.value = true;
                    final isValid = await qrScannerController
                        .validateTableQrCode(qrCodeValue ?? '');
                    qrScannerController.isLoading.value = false;
                    if (!isValid) {
                      Get.dialog(_showAlertDialog());
                    } else {
                      Get.toNamed('/menu');
                    }
                  }
                },
              ),
            ),
            const QrOverlay(),
            Positioned(
              bottom: 20.0,
              child: SizedBox(
                width: size.width,
                child: const Text(
                  textAlign: TextAlign.center,
                  'Para visualizar el menú escanea el código QR de tu mesa',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _showAlertDialog() {
    return AlertDialog(
      title: const Text('Error'),
      content:
          const Text('El código QR no es válido, por favor intente de nuevo'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            qrScannerController.mobileScannerController.start();
          },
          child: const Text('Aceptar'),
        )
      ],
    );
  }
}
