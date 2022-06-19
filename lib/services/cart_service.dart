import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/controller/cart_controller.dart';
import 'package:guitar_corner_app/controller/user_controller.dart';
import 'package:guitar_corner_app/services/guitar_service.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference carts = firestore.collection("carts");

class CartServices {
  static addGuitarToCart(String idGuitar) {
    final CartController cartController = Get.find();
    final UserController userController = Get.find();

    carts.add({
      "idUser": userController.id.value,
      "idGuitar": idGuitar,
      "totalPrice": cartController.total.value,
      "quantity": cartController.counter.value,
    }).then((value) => Get.back());
  }

  static Future getCartData() async {
    final UserController userController = Get.find();
    final CartDataController cartDataController = Get.put(CartDataController());

    await carts
        .where('idUser', isEqualTo: userController.id.value)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        guitars.doc(element.get("idGuitar")).get().then((value) {
          cartDataController.cartData.add({
            "idCart": element.id,
            "idGuitar": value.id,
            "guitarName": value.get("guitarName"),
            "price": element.get("totalPrice"),
            "guitarImage": value.get("guitarImage"),
            "quantity": element.get("quantity")
          });
        });
      });
    });
  }
}
