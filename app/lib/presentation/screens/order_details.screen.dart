import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del pedido'),
      ),
      body: Column(
        children: <Widget>[
          const ListTile(
            title: Text('Producto 1'),
            subtitle: Text('Cantidad: 1'),
            trailing: Text('S/ 10.00'),
          ),
          const ListTile(
            title: Text('Producto 2'),
            subtitle: Text('Cantidad: 2'),
            trailing: Text('S/ 20.00'),
          ),
          const ListTile(
            title: Text('Producto 3'),
            subtitle: Text('Cantidad: 1'),
            trailing: Text('S/ 15.00'),
          ),
          const Spacer(),
          const Divider(),
          const ListTile(
            title: Text('Subtotal'),
            trailing: Text('S/ 45.00'),
          ),
          const ListTile(
            title: Text('Envío'),
            trailing: Text('S/ 5.00'),
          ),
          const ListTile(
            title: Text('Total'),
            trailing: Text('S/ 50.00'),
          ),
          const Divider(),
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
