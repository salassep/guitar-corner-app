import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/services/guitar_service.dart';
import 'package:guitar_corner_app/ui/customer/detail.dart';

class SeeAll extends StatelessWidget {
  String category;

  SeeAll(this.category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            category,
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
            child: StreamBuilder<QuerySnapshot>(
          stream: category == "Special"
              ? guitars.where("guitarHighlight", isEqualTo: true).snapshots()
              : guitars
                  .where("guitarKategory", isEqualTo: category)
                  .snapshots(),
          builder: (_, snapshot) {
            return (snapshot.hasData)
                ? GridView.count(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                    crossAxisCount: 2,
                    mainAxisSpacing: 1,
                    childAspectRatio: (120 / 150),
                    children: List.generate(
                      snapshot.data!.docs.length,
                      (index) => GestureDetector(
                        onTap: () => Get.to(() => Detail(
                            snapshot.data!.docs[index].id,
                            snapshot.data!.docs[index].get("guitarPrice"))),
                        child: Container(
                          padding: EdgeInsets.only(right: 5, left: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              snapshot.data!.docs[index].get("guitarImage") ==
                                      ""
                                  ? Container(
                                      width: 120,
                                      height: 120,
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: FadeInImage.assetNetwork(
                                          placeholder: "assets/images/logo.png",
                                          image: snapshot.data!.docs[index]
                                              .get("guitarImage"),
                                          width: 120,
                                          height: 120),
                                    ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data!.docs[index]
                                        .get("guitarName"),
                                    style: TextStyle(
                                        fontFamily: "Jakarta",
                                        fontWeight: FontWeight.w600),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Rp${snapshot.data!.docs[index].get("guitarPrice")}",
                                    style: TextStyle(
                                        fontFamily: "Jakarta",
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Text("Retrieving Data");
          },
        )));
  }
}
