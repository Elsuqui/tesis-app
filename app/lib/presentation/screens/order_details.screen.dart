import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tesisApp/business/controllers/order.controller.dart';
import 'package:tesisApp/data/dto/models/order_details.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderController orderController = Get.find<OrderController>();
  OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    orderController.calculateTotal();
    print({'details': jsonEncode(orderController.orderDetails.toJson())});
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del pedido'),
      ),
      body: Column(
        children: <Widget>[
          GetBuilder(
            init: orderController,
            builder: (OrderController controller) {
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.orderDetails.length,
                  itemBuilder: (context, index) {
                    // Add swap animation to the _ItemDetail widget
                    return Dismissible(
                      key: ValueKey(controller.orderDetails[index].productId),
                      background: Container(
                        color: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: AlignmentDirectional.centerEnd,
                        child: const Icon(
                          Icons.delete,
                          size: 40.0,
                          color: Colors.white,
                        ),
                      ),
                      dismissThresholds: const {
                        DismissDirection.endToStart:
                            0.2, // Necesita deslizar el 20% para activar el dismiss
                      },
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          // Show dialog to confirm the removal of the product
                          return await Get.dialog(
                            _RemoveDialog(
                              onConfirm: () {
                                controller.removeProduct(
                                    controller.orderDetails[index]);
                                Get.back(result: true);
                              },
                            ),
                          );
                        }
                        return false;
                      },
                      child: _ItemDetail(
                          orderDetail: controller.orderDetails[index]),
                    );
                  },
                ),
              );
            },
          ),
          const Divider(height: 0.0),
          // const ListTile(
          //   dense: true,
          //   visualDensity: VisualDensity.compact,
          //   title: Text('Subtotal'),
          //   trailing: Text('S/ 45.00'),
          // ),
          ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            title: const Text('Total',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
            trailing: Obx(
              () {
                print('Loading total: ${orderController.isLoadingTotal.value}');
                return orderController.isLoadingTotal.value
                    ? const CircularProgressIndicator()
                    : Text(
                        '\$ ${orderController.total.value.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      );
              },
            ),
          ),
          //const Divider(),
          // Button to accept and pay the order
          GetBuilder<OrderController>(
            builder: (controller) {
              return Visibility(
                visible: controller.orderDetails.isNotEmpty,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Seleccionar método de pago'),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ItemDetail extends StatelessWidget {
  final OrderDetails orderDetail;
  const _ItemDetail({super.key, required this.orderDetail});

  @override
  Widget build(BuildContext context) {
    // Create order detail item without ListTile
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  orderDetail.product?.name ?? 'Product name',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Image Icon of the product
                Container(
                  width: 100.0,
                  height: 100.0,
                  // Icon of the product
                  child: orderDetail.product?.imageUrl != null
                      ? CachedNetworkImage(
                          cacheKey: 'product-${orderDetail.product?.id}',
                          imageUrl: orderDetail.product!.imageUrl!,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.fastfood, size: 50),
                ),
                // Text(
                //   'Cantidad: ${orderDetail.quantity}',
                //   style: const TextStyle(
                //     fontSize: 14.0,
                //   ),
                // ),
              ],
            ),
          ),
          GetBuilder<OrderController>(builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('\$ ${orderDetail.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 15.0)),
                const SizedBox(
                    height: 8.0), // Add space between price and quantity
                _quantity(
                  value: orderDetail.quantity,
                  onAdd: () {
                    controller.addQuantity(orderDetail);
                  },
                  onRemove: () {
                    if (orderDetail.quantity > 1) {
                      controller.removeQuantity(orderDetail);
                    } else {
                      // Open a dialog to confirm the removal of the product
                      Get.dialog(
                        _RemoveDialog(
                          onConfirm: () {
                            controller.removeProduct(orderDetail);
                            Get.back();
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _quantity extends StatelessWidget {
  final int value;
  final Function()? onAdd;
  final Function()? onRemove;
  const _quantity({super.key, this.value = 0, this.onAdd, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        children: <Widget>[
          _removeIcon(onPressed: onRemove),
          Text('$value'),
          _addIcon(onPressed: onAdd),
        ],
      ),
    );
  }
}

class _removeIcon extends StatelessWidget {
  final Function()? onPressed;
  const _removeIcon({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      iconSize: 18.0,
      icon: const Icon(Icons.delete),
      style: ButtonStyle(
        shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
        visualDensity: VisualDensity.compact,
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
      ),
      onPressed: onPressed,
    );
  }
}

class _addIcon extends StatelessWidget {
  final Function()? onPressed;
  const _addIcon({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      iconSize: 18.0,
      icon: const Icon(Icons.add),
      style: ButtonStyle(
        shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
        visualDensity: VisualDensity.compact,
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
      ),
      onPressed: onPressed,
    );
  }
}

class _RemoveDialog extends StatelessWidget {
  final Function()? onConfirm;
  const _RemoveDialog({super.key, this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Eliminar producto'),
      content: const Text('¿Está seguro de eliminar este producto?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Get.back(result: false);
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: onConfirm,
          child: const Text('Eliminar'),
        ),
      ],
    );
  }
}
