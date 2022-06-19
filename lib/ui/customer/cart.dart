import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/controller/cart_controller.dart';
import 'package:guitar_corner_app/services/booking_services.dart';
import 'package:guitar_corner_app/services/cart_service.dart';
import 'package:guitar_corner_app/ui/customer/detail_order.dart';

class Cart extends StatelessWidget {
  Cart({Key? key}) : super(key: key);
  final CartDataController cartDataController = Get.put(CartDataController());

  @override
  Widget build(BuildContext context) {
    CartServices.getCartData();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Your Cart",
          style: TextStyle(
              fontFamily: "Jakarta",
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 16),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Color.fromARGB(150, 0, 0, 0)),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(15, 25, 15, 0),
        children: [
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cartDataController.cartData.value.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      cartDataController.cartData.value[index]["guitarImage"] ==
                              ""
                          ? Container(
                              margin: EdgeInsets.only(right: 10),
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10)),
                            )
                          : Container(
                              margin: EdgeInsets.only(right: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: FadeInImage.assetNetwork(
                                    placeholder: "assets/images/logo.png",
                                    image: cartDataController
                                        .cartData.value[index]["guitarImage"],
                                    width: 70,
                                    height: 70),
                              ),
                            ),
                      Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width * 0.61,
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartDataController.cartData.value[index]
                                      ["guitarName"],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: "Jakarta",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Qty ${cartDataController.cartData.value[index]["quantity"].toString()}",
                                  style: TextStyle(
                                      fontFamily: "Jakarta",
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                            Text(
                              "Rp${cartDataController.cartData.value[index]["price"]}",
                              style: TextStyle(
                                  fontFamily: "Jakarta",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          carts
                              .doc(cartDataController.cartData.value[index]
                                  ["idCart"])
                              .delete();
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Icon(
                            Icons.close,
                            size: 20,
                          ),
                        ),
                      ))
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 30),
        padding: EdgeInsets.only(top: 15),
        color: Colors.white,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Divider(),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(
                      fontFamily: "Jakarta",
                      fontWeight: FontWeight.w300,
                      fontSize: 12),
                ),
                Obx(() {
                  num a = 0;
                  cartDataController.cartData.forEach((e) {
                    a += e["price"];
                  });
                  cartDataController.finalTotal.value = a.toInt();
                  return Text(
                    "Rp${cartDataController.finalTotal.value.toString()}",
                    style: TextStyle(
                        fontFamily: "Jakarta", fontWeight: FontWeight.w600),
                  );
                }),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  if (cartDataController.finalTotal.value != 0) {
                    BookingServices.doBooking();
                    Get.to(() => DetailOrder());
                  } else {
                    Get.snackbar("Info", "No item",
                        backgroundColor: Colors.red);
                  }
                },
                child: Text(
                  "Booking Now",
                  style: TextStyle(fontFamily: "Jakarta", fontSize: 12),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 1, 74, 170),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
