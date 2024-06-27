import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tesisApp/business/controllers/menu.controller.dart';
import 'package:tesisApp/data/dto/models/menu.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<AppMenuController>(
        builder: (AppMenuController menuController) {
          return menuController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : _BuildMenuScreen(menuController.menu);
        },
      ),
    );
  }
}

class _BuildMenuScreen extends StatelessWidget {
  final Menu menu;

  const _BuildMenuScreen(this.menu);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: menu.categories.length,
      itemBuilder: (context, index) {
        final category = menu.categories[index];
        return ListTile(
          title: Text(category.name),
          subtitle: const Text('Category description'),
        );
      },
    );
  }
}
