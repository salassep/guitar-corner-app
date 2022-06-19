import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/controller/cart_controller.dart';
import 'dart:math';
import 'package:guitar_corner_app/controller/user_controller.dart';
import 'package:guitar_corner_app/services/cart_service.dart';
import 'package:intl/intl.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference bookings = firestore.collection("bookings");

class BookingServices {
  static doBooking() async {
    final UserController userController = Get.find();
    final CartDataController cardDataController = Get.find();

    String random = Random().nextInt(10000).toString();
    String orderDate = DateFormat("dd-MM-yyyy, HH:mm")
        .format(DateTime.now().add(Duration(hours: 8)))
        .toString();

    cardDataController.getSomeDetailData(random, orderDate);

    await bookings.add({
      "idUser": userController.id.value,
      "status": "waiting for response",
      "orderId": random,
      "orderDate": orderDate,
      "pickUpDate": "Waiting for response",
      "totalPrice": cardDataController.finalTotal.value,
      "dataCart": cardDataController.cartData.value,
    });

    cardDataController.cartData.forEach((element) {
      carts.doc(element["idCart"]).delete();
    });

    Get.snackbar("Booking Sended!", "Check your activity to see more");
  }

  static updateBooking(String id, String newStatus, String newPickUpDate) {
    bookings.doc(id).update({"status": newStatus, "pickUpDate": newPickUpDate});
  }
}
