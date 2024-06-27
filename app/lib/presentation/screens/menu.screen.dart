import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tesisApp/business/controllers/menu.controller.dart';
import 'package:tesisApp/data/dto/models/category.dart';
import 'package:tesisApp/data/dto/models/menu.dart';
import 'package:tesisApp/data/dto/models/product.dart';
import 'package:tesisApp/presentation/routes/app.routes.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<AppMenuController>(
        builder: (AppMenuController menuController) {
          return menuController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(child: _BuildMenuScreen(menuController.menu));
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
    // return ListView.builder(
    //   itemCount: menu.categories.length,
    //   itemBuilder: (context, index) {
    //     final category = menu.categories[index];
    //     return ListTile(
    //       title: Text(category.name),
    //       subtitle: const Text('Category description'),
    //     );
    //   },
    // );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(Icons.menu),
              // ),
              //const Spacer(),
              IconButton(
                onPressed: () {
                  Get.toNamed(AppPages.orderDetails);
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 30,
                ),
              ),
            ],
          ),
          const _MenuTitle('Restaurante \n Resto'),
          const SizedBox(height: 10),
          _SearchBox(),
          const SizedBox(height: 5),
          _CategorySection(),
          const SizedBox(height: 5),
          Expanded(child: _PopularPlates()),
          const SizedBox(height: 15), // Add some space to the bottom
        ],
      ),
    );
  }
}

class _MenuTitle extends StatelessWidget {
  final String title;

  const _MenuTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Create search box widget
class _SearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: GestureDetector(
        onTap: () {
          // Navigate to search screen
          Get.toNamed(AppPages.search);
        },
        child: const Row(
          children: [
            Icon(Icons.search),
            SizedBox(width: 10),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Bebidas, comida, postres',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  final AppMenuController menuController = Get.find<AppMenuController>();
  @override
  Widget build(BuildContext context) {
    final Menu menu = menuController.menu;
    return Column(
      children: [
        // Title
        Row(
          children: [
            const Text(
              'Categorías',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Get.toNamed(AppPages.categories);
              },
              child: const Text(
                'Ver todas',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        // Horizontal Scrollable Category List
        GetBuilder<AppMenuController>(
          builder: (menuController) {
            return SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: menu.categories.length,
                itemBuilder: (context, index) {
                  final isSelected = menuController.selectedCategory?.id ==
                      menu.categories[index].id;
                  return InkWell(
                    overlayColor:
                        const WidgetStatePropertyAll(Colors.transparent),
                    onTap: () {
                      menuController.selectCategory(menu.categories[index]);
                    },
                    child: _CategoryCard(
                      category: menu.categories[index],
                      isSelected: isSelected,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final Category category;
  final bool isSelected;
  const _CategoryCard({
    required this.category,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 100,
      decoration: BoxDecoration(
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
        color:
            isSelected ? Colors.grey[200] : Colors.grey[200]!.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.fastfood, size: 50),
          const SizedBox(height: 10),
          Text(category.name),
        ],
      ),
    );
  }
}

// Scrollable list of popular plates
class _PopularPlates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'Lo más pedido',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Scrollable Plate List
          GetBuilder<AppMenuController>(
              init: Get.find<AppMenuController>(),
              builder: (menuController) {
                return Expanded(
                    child: ListView.builder(
                  itemCount: menuController.productsByCategory.length,
                  itemBuilder: (context, index) {
                    final Product product =
                        menuController.productsByCategory[index];
                    return _PlateCard(product: product);
                  },
                ));
              }),
        ],
      ),
    );
  }
}

class _PlateCard extends StatelessWidget {
  final Product product;
  const _PlateCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 100,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon(Icons.fastfood, size: 50),
          // SizedBox(height: 10),
          // Text('Hamburguesa'),
          //Text('Hollaaa'),
          _PlateDetails(
            product: product,
          ),
        ],
      ),
    );
  }
}

// class _PlateDetail extends StatelessWidget {
//   const _PlateDetail();

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         // Plate Image
//         Container(
//           width: 100,
//           height: 100,
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: const Icon(Icons.fastfood, size: 50),
//         ),
//         // Plate Info
//         const SizedBox(width: 10),
//         const Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Hamburguesa'),
//               Text('Descripción de la hamburguesa'),
//               Text('Precio: \$10.00'),
//             ],
//           ),
//         ),
//         // Add to Cart Button
//         ElevatedButton(
//           onPressed: () {},
//           child: const Text('Añadir'),
//         ),
//       ],
//     );
//   }
// }

class _PlateDetails extends StatelessWidget {
  final Product product;
  const _PlateDetails({required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.fastfood, size: 50),
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              color: const Color(0xFF393E41),
              child: Text(
                '\$ ${product.price}',
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              Text(
                product.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              // Add a right button to add to cart
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ActionChip.elevated(
                    onPressed: () {},
                    label: const Text(
                      'Añadir',
                    ),
                    elevation: 5,
                    labelStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
