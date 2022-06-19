import 'package:get/get.dart';

class CartController extends GetxController {
  var counter = 0.obs;
  var guitar_price = 0.obs;
  var total = 0.obs;

  void increment() {
    counter++;
  }

  void decremenet() {
    if (counter > 0) counter--;
  }

  void multiple() {
    total.value = counter.value * guitar_price.value;
  }
}

class CartDataController extends GetxController {
  var cartData = [].obs;
  var oldCardData = [].obs;
  var finalTotal = 0.obs;
  var orderId = "".obs;
  var orderDate = "".obs;

  void getSomeDetailData(String random, String dateOrder) {
    orderId.value = random;
    orderDate.value = dateOrder;
  }
}
