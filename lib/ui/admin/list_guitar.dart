import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/controller/guitar_controller.dart';
import 'package:guitar_corner_app/services/guitar_service.dart';
import 'package:guitar_corner_app/ui/admin/detail_guitar_admin.dart';

class ListGuitar extends StatelessWidget {
  final SearchGuitarController searchGuitarController =
      Get.put(SearchGuitarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Manage Guitar",
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
                hintText: "Find your guitar name ...",
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
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot doc = snapshot.data!.docs[index];
                            return GestureDetector(
                              onTap: () =>
                                  Get.to(() => DetailGuitarAdmin(doc.id)),
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
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600))),
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
