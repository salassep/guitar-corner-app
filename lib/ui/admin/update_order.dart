import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/services/booking_services.dart';
import 'package:guitar_corner_app/services/history_services.dart';
import 'package:guitar_corner_app/services/user_services.dart';
import 'package:guitar_corner_app/ui/admin/update_form_order.dart';
import 'package:guitar_corner_app/ui/customer/home.dart';

class UpdateOrder extends StatelessWidget {
  DocumentSnapshot doc;

  UpdateOrder(this.doc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Update Order",
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
          FutureBuilder<DocumentSnapshot>(
              future: users.doc(doc.get("idUser")).get(),
              builder: (_, snapshot) {
                return (snapshot.hasData)
                    ? Column(
                        children: [
                          Divider(
                            thickness: 0.5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order By",
                                style: TextStyle(fontFamily: "Jakarta"),
                              ),
                              Text(
                                snapshot.data!.get("name"),
                                style: TextStyle(
                                    fontFamily: "Jakarta",
                                    fontWeight: FontWeight.w600),
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
                                "Phone",
                                style: TextStyle(fontFamily: "Jakarta"),
                              ),
                              Text(
                                snapshot.data!.get("phone"),
                                style: TextStyle(
                                    fontFamily: "Jakarta",
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ],
                      )
                    : Text("Retrieving data");
              }),
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
                doc.get("status"),
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
                doc.get("orderId"),
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
                doc.get("orderDate"),
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
                doc.get("pickUpDate"),
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
              itemCount: doc.get("dataCart").length,
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    doc.get("dataCart")[index]["guitarImage"] == ""
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
                                  image: doc.get("dataCart")[index]
                                      ["guitarImage"],
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
                                doc.get("dataCart")[index]["guitarName"],
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
                                doc
                                    .get("dataCart")[index]["quantity"]
                                    .toString(),
                                style: TextStyle(
                                    fontFamily: "Jakarta",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                          Text(
                            "Rp${doc.get("dataCart")[index]["price"].toString()}",
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
                "Rp${doc.get("totalPrice").toString()}",
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.44,
              child: ElevatedButton(
                onPressed: () => Get.to(() => UpdateOrderForm(doc)),
                child: Text(
                  "Update",
                  style: TextStyle(fontFamily: "Jakarta", fontSize: 12),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 1, 74, 170),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  bookings.doc(doc.id).delete();
                  Get.back();
                },
                child: Text(
                  "Delete",
                  style: TextStyle(fontFamily: "Jakarta", fontSize: 12),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
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
