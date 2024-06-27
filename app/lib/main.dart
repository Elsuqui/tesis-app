import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tesisApp/data/providers/di_container.provider.dart';
import 'package:tesisApp/presentation/routes/app.routes.dart';
import 'package:tesisApp/presentation/screens/home.screen.dart';
import 'package:tesisApp/presentation/themes/themes.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: DiContainer(),
      home: const HomeScreen(),
      getPages: AppPages.pages,
      initialRoute: '/home',
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
    );
  }
}
