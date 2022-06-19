import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/services/booking_services.dart';
import 'package:guitar_corner_app/ui/admin/bill.dart';

import '../../controller/guitar_controller.dart';

class SearchBill extends StatelessWidget {
  SearchBill({Key? key}) : super(key: key);

  final SearchGuitarController searchGuitarController =
      Get.put(SearchGuitarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Search Bill",
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
          child: Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Text(
              "Type order id below.",
              style: TextStyle(
                fontFamily: "Jakarta",
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              onChanged: (value) => searchGuitarController.searchGuitar(value),
              style: TextStyle(
                fontFamily: "Jakarta",
                color: Colors.black,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                prefixIcon: Container(
                    padding: EdgeInsets.only(
                      left: 5,
                    ),
                    child: Icon(Icons.search)),
                prefixIconConstraints: BoxConstraints(
                  minHeight: 30,
                  minWidth: 35,
                ),
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 1, 74, 170),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                hintText: "e.g. 1a2b3c",
                hintStyle: TextStyle(
                  fontFamily: "Jakarta",
                  color: Colors.grey,
                ),
              ),
            ),
            Obx(() => StreamBuilder<QuerySnapshot>(
                  stream: bookings
                      .where('orderId',
                          isNotEqualTo:
                              searchGuitarController.guitarName.value + " ")
                      .orderBy("orderId")
                      .startAt([
                    searchGuitarController.guitarName.value,
                  ]).endAt([
                    searchGuitarController.guitarName.value + '\uf8ff',
                  ]).snapshots(),
                  builder: (_, snapshot) {
                    return (snapshot.hasData)
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length < 1 ? 0 : 1,
                            itemBuilder: (context, index) {
                              DocumentSnapshot doc = snapshot.data!.docs[index];
                              return GestureDetector(
                                onTap: () => Get.to(Bill(doc)),
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(bottom: 8, top: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 0.5,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0))),
                                    child: Text("ID ${doc['orderId']}",
                                        style: TextStyle(
                                            fontFamily: "Jakarta",
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600))),
                              );
                            },
                          )
                        : Text("Mengambil data ....");
                  },
                )),
          ],
        ),
      )),
    );
  }
}
