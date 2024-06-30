import 'package:get/get.dart';
import 'package:tesisApp/data/dto/models/order_details.dart';

class OrderDetailController extends GetxController {
  Rx<OrderDetails> orderDetails =
      OrderDetails(productId: 0, quantity: 0, price: 0).obs;

  void addOrderDetail(OrderDetails orderDetail) {
    orderDetails.value = orderDetail;
  }

  void addQuantity() {
    final product = orderDetails.value.product;
    orderDetails.update((val) {
      val!.quantity = val.quantity + 1;
      val.price = double.parse(product!.price) * val.quantity;
    });
    print('Quantity: ${orderDetails.value.quantity}');
  }

  void removeQuantity() {
    final product = orderDetails.value.product;
    if (orderDetails.value.quantity > 0) {
      orderDetails.update((val) {
        val!.quantity = val.quantity - 1;
        val.price = double.parse(product!.price) * val.quantity;
      });
    }
    print('Quantity: ${orderDetails.value.quantity}');
  }
}
