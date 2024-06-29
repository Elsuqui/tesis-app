import 'package:get/get.dart';
import 'package:tesisApp/data/dto/models/order_details.dart';

class OrderController extends GetxController {
  final RxBool isLoadingTotal = false.obs;
  final RxDouble total = 0.0.obs;
  final RxList<OrderDetails> orderDetails = RxList.empty();

  void updateOrderDetail(OrderDetails orderDetail) {
    final index = orderDetails
        .indexWhere((element) => element.productId == orderDetail.productId);
    if (index != -1 && orderDetail.quantity > 0) {
      orderDetails[index] = orderDetail;
    } else if (index != -1 && orderDetail.quantity == 0) {
      orderDetails
          .removeWhere((element) => element.productId == orderDetail.productId);
    } else {
      orderDetails.add(orderDetail);
    }
  }

  void calculateTotal() {
    isLoadingTotal.value = true;
    Future.value(orderDetails.fold<double>(
            0.0, (previousValue, element) => previousValue + element.price))
        .then((value) => total.value = value)
        .whenComplete(() {
      isLoadingTotal.value = false;
    });
  }

  OrderDetails getDetailByProductId(int id) {
    return orderDetails.firstWhere(
      (element) => element.productId == id,
      orElse: () => OrderDetails(productId: id, quantity: 0, price: 0),
    );
  }

  void modifyOrderDetailQuantity(OrderDetails orderDetail, int quantity) {
    final filteredOrderDetail = orderDetails.firstWhere(
      (element) => element.productId == orderDetail.productId,
    );
    filteredOrderDetail.quantity = quantity;
    filteredOrderDetail.price =
        double.parse(filteredOrderDetail.product!.price) * quantity;
    updateOrderDetail(orderDetail);
    calculateTotal();
  }

  void addQuantity(OrderDetails orderDetail) {
    modifyOrderDetailQuantity(orderDetail, orderDetail.quantity + 1);
    update();
  }

  void removeQuantity(OrderDetails orderDetail) {
    modifyOrderDetailQuantity(orderDetail, orderDetail.quantity - 1);
    update();
  }
}
