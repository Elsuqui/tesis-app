import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tesisApp/business/controllers/order.controller.dart';
import 'package:tesisApp/business/controllers/order_detail.controller.dart';
import 'package:tesisApp/data/dto/models/product.dart';

class CardProduct extends StatelessWidget {
  final Product product;
  const CardProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return productContainer(context);
  }

  Widget productContainer(BuildContext context) {
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
          productDetails(context),
        ],
      ),
    );
  }

  Widget productDetails(BuildContext context) {
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
              // Add an image to the product
              //child: const Icon(Icons.fastfood, size: 50),
              child: product.imageUrl != null
                  ? CachedNetworkImage(
                      cacheKey: 'product-${product.id}',
                      imageUrl: product.imageUrl!,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.fastfood, size: 50),
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              color: const Color(0xFF393E41),
              child: Text(
                '\$ ${double.parse(product.price).toStringAsFixed(2)}',
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
                    onPressed: () {
                      Get.bottomSheet(
                        _AddToCartBottomSheet(product: product),
                        isScrollControlled: true,
                      );
                    },
                    label: const Icon(
                      Icons.post_add_sharp,
                      color: Colors.white,
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

class _AddToCartBottomSheet extends StatelessWidget {
  final Product product;
  final OrderController orderController = Get.find<OrderController>();

  _AddToCartBottomSheet({required this.product});

  @override
  Widget build(BuildContext context) {
    final orderDetail = orderController.getDetailByProductId(product.id);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                '\$ ${double.parse(product.price).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Descripción del producto',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          GetX<OrderDetailController>(
            initState: (state) {
              orderDetail.product = product;
              state.controller?.addOrderDetail(orderDetail);
            },
            init: OrderDetailController(),
            builder: (OrderDetailController controller) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.removeQuantity();
                      orderController
                          .updateOrderDetail(controller.orderDetails.value);
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  Text(
                    controller.orderDetails.value.quantity.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.addQuantity();
                      orderController
                          .updateOrderDetail(controller.orderDetails.value);
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          // ElevatedButton(
          //   onPressed: () {},
          //   child: const Text('Añadir al carrito'),
          // ),
        ],
      ),
    );
  }
}
