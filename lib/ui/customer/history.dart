import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/controller/guitar_controller.dart';
import 'package:guitar_corner_app/controller/user_controller.dart';
import 'package:guitar_corner_app/services/booking_services.dart';
import 'package:guitar_corner_app/services/guitar_service.dart';
import 'package:guitar_corner_app/services/history_services.dart';
import 'package:guitar_corner_app/services/like_services.dart';
import 'package:guitar_corner_app/ui/customer/detail.dart';
import 'package:guitar_corner_app/ui/customer/detail_ongoing.dart';

class History extends StatelessWidget {
  History({Key? key}) : super(key: key);
  final UserController userController = Get.find();
  final GuitarLikesController guitarLikesController =
      Get.put(GuitarLikesController());

  @override
  Widget build(BuildContext context) {
    guitarLikesController.getArrayDataLikes();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 18),
          children: [
            DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(50, 1, 74, 170)))),
                      child: TabBar(
                          indicator: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Color.fromARGB(255, 1, 74, 170)))),
                          tabs: [
                            Tab(
                              child: Text(
                                "Favorite",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Jakarta",
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "On Going",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Jakarta",
                                    fontSize: 13),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "History",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Jakarta",
                                ),
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: TabBarView(children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Obx(
                            () => Column(
                              children: guitarLikesController.likesData.value
                                  .map((e) => FutureBuilder<DocumentSnapshot>(
                                      future: guitars.doc(e.toString()).get(),
                                      builder: (_, snaphsot) {
                                        if (snaphsot.hasData) {
                                          return GestureDetector(
                                            onTap: () => Get.to(() => Detail(
                                                snaphsot.data!.id,
                                                snaphsot.data!
                                                    .get("guitarPrice"))),
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 10),
                                              child: ListTile(
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: Color.fromARGB(
                                                            50, 0, 0, 0)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                title: Text(
                                                  snaphsot.data!
                                                      .get("guitarName"),
                                                  style: TextStyle(
                                                    fontFamily: "Jakarta",
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  "Rp${snaphsot.data!.get("guitarPrice")}",
                                                  style: TextStyle(
                                                      fontFamily: "Jakarta",
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Text("Mengambil data...");
                                        }
                                      }))
                                  .toList(),
                            ),
                          ),
                        ),
                        Container(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: bookings
                                .where("idUser",
                                    isEqualTo: userController.id.value)
                                .snapshots(),
                            builder: (_, snapshot) {
                              return (snapshot.hasData)
                                  ? ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot doc =
                                            snapshot.data!.docs[index];
                                        return Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: GestureDetector(
                                              onTap: () => Get.to(
                                                  () => DetailOnGoing(doc)),
                                              child: ListTile(
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: Color.fromARGB(
                                                          150, 0, 0, 0),
                                                      width: 0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                title: Text(
                                                  doc.get("dataCart")[0]
                                                      ["guitarName"],
                                                  style: TextStyle(
                                                      fontFamily: "Jakarta"),
                                                ),
                                                subtitle: Text(
                                                    doc.get("status"),
                                                    style: TextStyle(
                                                        fontFamily: "Jakarta")),
                                                trailing: Text(
                                                    "ID ${doc.get("orderId")}",
                                                    style: TextStyle(
                                                        fontFamily: "Jakarta")),
                                              ),
                                            ));
                                      },
                                    )
                                  : Text("Retrieving data...");
                            },
                          ),
                        ),
                        Container(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: histories
                                .where("idUser",
                                    isEqualTo: userController.id.value)
                                .snapshots(),
                            builder: (_, snapshot) {
                              return (snapshot.hasData)
                                  ? ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot doc =
                                            snapshot.data!.docs[index];
                                        return Container(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: ListTile(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: Color.fromARGB(
                                                      150, 0, 0, 0),
                                                  width: 0.5),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            contentPadding: EdgeInsets.all(5),
                                            title: Text(
                                              doc.get("dataCart")[0]
                                                  ["guitarName"],
                                              style: TextStyle(
                                                  fontFamily: "Jakarta"),
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "Rp${doc.get("totalPrice").toString()}",
                                                    style: TextStyle(
                                                        fontFamily: "Jakarta",
                                                        fontWeight:
                                                            FontWeight.w700)),
                                                Text(doc.get("status"),
                                                    style: TextStyle(
                                                        fontFamily: "Jakarta")),
                                              ],
                                            ),
                                            trailing: Text(
                                                "ID ${doc.get("orderId")}",
                                                style: TextStyle(
                                                    fontFamily: "Jakarta")),
                                          ),
                                        );
                                      },
                                    )
                                  : Text("Retrieving data...");
                            },
                          ),
                        ),
                      ]),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
