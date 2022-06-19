import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/services/guitar_service.dart';
import 'package:guitar_corner_app/ui/admin/update_guitar.dart';

class DetailGuitarAdmin extends StatelessWidget {
  String id;

  DetailGuitarAdmin(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Color.fromARGB(150, 0, 0, 0)),
      ),
      body: SafeArea(
          child: FutureBuilder<DocumentSnapshot>(
              future: guitars.doc(id).get(),
              builder: (_, snapshot) {
                return (snapshot.hasData)
                    ? ListView(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 125),
                        children: [
                          snapshot.data!.get("guitarImage") == ""
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.width - 30,
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(15)),
                                )
                              : FadeInImage.assetNetwork(
                                  placeholder: "assets/images/logo.png",
                                  image: snapshot.data!.get('guitarImage'),
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.width - 30,
                                ),
                          Text(
                            snapshot.data!.get("guitarName"),
                            style: TextStyle(
                              fontFamily: "Jakarta",
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Rp${snapshot.data!.get("guitarPrice")}",
                            style: TextStyle(
                                fontFamily: "Jakarta",
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Product Description",
                            style: TextStyle(
                                fontFamily: "Jakarta",
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.data!.get("guitarDescription"),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            style: TextStyle(
                                fontFamily: "Jakarta",
                                fontSize: 12,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Produk Spesification",
                            style: TextStyle(
                                fontFamily: "Jakarta",
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: "\u2022 Body Weight : ",
                                        style: TextStyle(
                                            fontFamily: "Jakarta",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500)),
                                    TextSpan(
                                        text:
                                            "${snapshot.data!.get("guitarSpecification")["guitarWeight"]}kg",
                                        style: TextStyle(
                                            fontFamily: "Jakarta",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300))
                                  ])),
                                  SizedBox(height: 5),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: "\u2022 Color : ",
                                        style: TextStyle(
                                            fontFamily: "Jakarta",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500)),
                                    TextSpan(
                                        text: snapshot.data!
                                                .get("guitarSpecification")[
                                            "guitarColor"],
                                        style: TextStyle(
                                            fontFamily: "Jakarta",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300))
                                  ])),
                                  SizedBox(height: 5),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: "\u2022 Body Material : ",
                                        style: TextStyle(
                                            fontFamily: "Jakarta",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500)),
                                    TextSpan(
                                        text: snapshot.data!
                                                .get("guitarSpecification")[
                                            "guitarMaterial"],
                                        style: TextStyle(
                                            fontFamily: "Jakarta",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300))
                                  ])),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: "\u2022 Body Long : ",
                                        style: TextStyle(
                                            fontFamily: "Jakarta",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500)),
                                    TextSpan(
                                        text: snapshot.data!
                                                .get("guitarSpecification")[
                                            "guitarLong"],
                                        style: TextStyle(
                                            fontFamily: "Jakarta",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300))
                                  ])),
                                  SizedBox(height: 5),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: "\u2022 Body Type : ",
                                        style: TextStyle(
                                            fontFamily: "Jakarta",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500)),
                                    TextSpan(
                                        text: snapshot.data!
                                                .get("guitarSpecification")[
                                            "guitarType"],
                                        style: TextStyle(
                                            fontFamily: "Jakarta",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300))
                                  ])),
                                  SizedBox(height: 5),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: "\u2022 Number of Strings : ",
                                        style: TextStyle(
                                            fontFamily: "Jakarta",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500)),
                                    TextSpan(
                                        text: snapshot.data!
                                                .get("guitarSpecification")[
                                            "guitarStrings"],
                                        style: TextStyle(
                                            fontFamily: "Jakarta",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300))
                                  ])),
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    : Text("loading ...");
              })),
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
                onPressed: () {
                  Get.to(() => UpdateGuitar(id));
                },
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
                  guitars.doc(id).delete();
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
