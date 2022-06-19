import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/controller/guitar_controller.dart';
import 'package:guitar_corner_app/services/guitar_service.dart';
import 'package:guitar_corner_app/services/history_services.dart';
import 'package:guitar_corner_app/ui/admin/detail_guitar_admin.dart';

class Report extends StatelessWidget {
  final SearchGuitarController searchGuitarController =
      Get.put(SearchGuitarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Transaction Logs",
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
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        children: [
          Container(
            height: 40,
            child: TextField(
              onChanged: (value) => searchGuitarController.searchGuitar(value),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(Icons.search_outlined),
                hintText: "Find order id ...",
                hintStyle: TextStyle(fontFamily: "Jakarta", fontSize: 15),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Obx(() => StreamBuilder<QuerySnapshot>(
                stream: searchGuitarController.guitarName.value == ""
                    ? histories.snapshots()
                    : histories
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
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot doc = snapshot.data!.docs[index];
                            return Container(
                                child: ListTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Color.fromARGB(150, 0, 0, 0),
                                    width: 0.5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              contentPadding: EdgeInsets.all(5),
                              title: Text(
                                "Rp${doc.get("totalPrice").toString()}",
                                style: TextStyle(fontFamily: "Jakarta"),
                              ),
                              subtitle: Text(doc.get("pickUpDate"),
                                  style: TextStyle(fontFamily: "Jakarta")),
                              trailing: Text("ID ${doc.get("orderId")}",
                                  style: TextStyle(fontFamily: "Jakarta")),
                            ));
                          },
                        )
                      : Text("Mengambil data ....");
                },
              )),
        ],
      )),
    );
  }
}
