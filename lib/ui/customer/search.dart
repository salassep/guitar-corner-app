import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/controller/guitar_controller.dart';
import 'package:guitar_corner_app/ui/customer/detail.dart';

import '../../services/guitar_service.dart';

class Search extends StatelessWidget {
  final SearchGuitarController searchGuitarController =
      Get.put(SearchGuitarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
        children: [
          Text(
            "Find Your Guitar",
            style: TextStyle(
                fontFamily: "Jakarta",
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Type your guitar name below.",
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
              hintText: "e.g. yamaha",
              hintStyle: TextStyle(
                fontFamily: "Jakarta",
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Obx(() => StreamBuilder<QuerySnapshot>(
                stream: searchGuitarController.guitarName.value == ""
                    ? guitars.snapshots()
                    : guitars
                        .where('guitarName',
                            isNotEqualTo:
                                searchGuitarController.guitarName.value + " ")
                        .orderBy("guitarName")
                        .startAt([
                        searchGuitarController.guitarName.value,
                      ]).endAt([
                        searchGuitarController.guitarName.value + '\uf8ff',
                      ]).snapshots(),
                builder: (_, snapshot) {
                  return (snapshot.hasData)
                      ? ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot doc = snapshot.data!.docs[index];
                            return GestureDetector(
                              onTap: () => Get.to(
                                  () => Detail(doc.id, doc["guitarPrice"])),
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 0.5,
                                          color: Color.fromARGB(255, 0, 0, 0))),
                                  child: Text(doc['guitarName'],
                                      style: TextStyle(
                                          fontFamily: "Jakarta",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500))),
                            );
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
