import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/controller/cart_controller.dart';

class DetailOrder extends StatelessWidget {
  DetailOrder({Key? key}) : super(key: key);

  final CartDataController cardDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Detail Order",
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
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        children: [
          Divider(
            thickness: 0.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Status",
                style: TextStyle(fontFamily: "Jakarta"),
              ),
              Text(
                "Waiting for response",
                style: TextStyle(
                    fontFamily: "Jakarta", fontWeight: FontWeight.w600),
              )
            ],
          ),
          Divider(
            thickness: 0.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order ID",
                style: TextStyle(fontFamily: "Jakarta"),
              ),
              Text(
                cardDataController.orderId.value,
                style: TextStyle(
                    fontFamily: "Jakarta", fontWeight: FontWeight.w600),
              )
            ],
          ),
          Divider(
            thickness: 0.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date Order",
                style: TextStyle(fontFamily: "Jakarta"),
              ),
              Text(
                cardDataController.orderDate.value,
                style: TextStyle(
                    fontFamily: "Jakarta", fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Divider(
            thickness: 0.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pick Up Date",
                style: TextStyle(fontFamily: "Jakarta"),
              ),
              Text(
                "Waiting for response",
                style: TextStyle(
                    fontFamily: "Jakarta", fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Divider(
            thickness: 0.5,
          ),
          Text(
            "Order Details",
            style: TextStyle(fontFamily: "Jakarta"),
          ),
          Container(
            height: 100,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cardDataController.cartData.value.length,
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cardDataController.cartData.value[index]["guitarImage"] ==
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
                                  image: cardDataController
                                      .cartData.value[index]["guitarImage"],
                                  width: 70,
                                  height: 70),
                            ),
                          ),
                    Container(
                      height: 70,
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cardDataController.cartData.value[index]
                                    ["guitarName"],
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    fontFamily: "Jakarta",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                cardDataController
                                    .cartData.value[index]["quantity"]
                                    .toString(),
                                style: TextStyle(
                                    fontFamily: "Jakarta",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          Text(
                            "Rp${cardDataController.cartData.value[index]["price"].toString()}",
                            style: TextStyle(
                                fontFamily: "Jakarta",
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Divider(
            thickness: 0.5,
          ),
          Text(
            "Payment Details",
            style: TextStyle(fontFamily: "Jakarta"),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(fontFamily: "Jakarta"),
              ),
              Text(
                "Rp${cardDataController.finalTotal.value.toString()}",
                style: TextStyle(
                    fontFamily: "Jakarta", fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      )),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 30),
        padding: EdgeInsets.only(top: 15),
        color: Colors.white,
        height: 50,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () => Get.back(),
            child: Text(
              "Okay",
              style: TextStyle(fontFamily: "Jakarta", fontSize: 12),
            ),
            style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 1, 74, 170),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                )),
          ),
        ),
      ),
    );
  }
}
