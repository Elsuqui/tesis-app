import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tesisApp/presentation/routes/app.routes.dart';
import 'package:tesisApp/presentation/screens/home.screens.dart';
import 'package:tesisApp/presentation/screens/qrscanner.screen.dart';

void main() => runApp(
      GetMaterialApp(
        //home: const HomeScreen(),
        home: const HomeScreen(),
        routes: appRoutes,
        debugShowCheckedModeBanner: false,
      ),
    );
