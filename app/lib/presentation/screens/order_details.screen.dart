import 'dart:convert';

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
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: orderController.orderDetails.length,
              itemBuilder: (context, index) {
                return _ItemDetail(
                  orderDetail: orderController.orderDetails[index],
                );
              },
            ),
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
          Container(
            padding: const EdgeInsets.all(8.0),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Seleccionar método de pago'),
            ),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    // image: DecorationImage(
                    //   image: NetworkImage(orderDetail.product?.image ?? ''),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  // Icon of the product
                  child: const Icon(Icons.image, size: 100.0),
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
