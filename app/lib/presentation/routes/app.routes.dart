import 'package:flutter/material.dart';
import 'package:tesisApp/presentation/screens/home.screens.dart';
import 'package:tesisApp/presentation/screens/qrscanner.screen.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  '/home': (context) => const HomeScreen(),
  '/qrScanner': (context) => const QrScannerScreen(),
};
