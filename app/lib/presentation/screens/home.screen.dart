import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _WelcomeText(),
              const SizedBox(height: 50.0),
              _WelcomeImage(),
              const SizedBox(height: 30.0),
              _DescriptionText(),
              const SizedBox(height: 50.0),
              _StartButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeText extends StatelessWidget {
  @override
  Widget build(context) {
    return const Text(
      'Bienvenido',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 50.0,
      ),
    );
  }
}

class _DescriptionText extends StatelessWidget {
  @override
  Widget build(context) {
    return const Text(
      'Escanee el código QR de su mesa y realice su pedido.',
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 30.0,
      ),
      textAlign: TextAlign.justify,
    );
  }
}

class _StartButton extends StatelessWidget {
  @override
  Widget build(context) {
    return FilledButton.icon(
      onPressed: () {
        Get.toNamed('/qrScanner');
      },
      icon: const Icon(Icons.qr_code),
      label: const Text(
        'Escanear código QR',
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _WelcomeImage extends StatelessWidget {
  @override
  Widget build(context) {
    return Image.asset(
      'assets/images/welcome_image.png',
      width: double.infinity,
      height: 300.0,
    );
  }
}
