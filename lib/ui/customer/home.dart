import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/controller/user_controller.dart';
import 'package:guitar_corner_app/services/guitar_service.dart';
import 'package:guitar_corner_app/ui/customer/detail.dart';
import 'package:guitar_corner_app/ui/customer/see_all.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/banner.jpeg",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 1, 74, 170),
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Special for you",
                  style: TextStyle(
                      fontFamily: "Jakarta",
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
                InkWell(
                  onTap: () => Get.to(() => SeeAll("Special")),
                  child: Text(
                    "See all",
                    style: TextStyle(
                      fontFamily: "Jakarta",
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 200,
                child: StreamBuilder<QuerySnapshot>(
                  stream: guitars
                      .where('guitarHighlight', isEqualTo: true)
                      .snapshots(),
                  builder: (_, snapshot) {
                    return (snapshot.hasData)
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length <= 5
                                ? snapshot.data!.docs.length
                                : 5,
                            itemBuilder: (context, index) {
                              DocumentSnapshot doc = snapshot.data!.docs[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                      () => Detail(doc.id, doc["guitarPrice"]));
                                },
                                child: Container(
                                  width: 150,
                                  margin: EdgeInsets.only(right: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      doc["guitarImage"] == ""
                                          ? Container(
                                              width: 150,
                                              height: 150,
                                              margin:
                                                  EdgeInsets.only(bottom: 10),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: FadeInImage.assetNetwork(
                                                  placeholder:
                                                      "assets/images/logo.png",
                                                  image: doc['guitarImage'],
                                                  width: 150,
                                                  height: 150),
                                            ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            doc["guitarName"],
                                            style: TextStyle(
                                                fontFamily: "Jakarta",
                                                fontWeight: FontWeight.w600),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Rp${doc["guitarPrice"]}",
                                            style: TextStyle(
                                                fontFamily: "Jakarta",
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              );
                            })
                        : Text("loading");
                  },
                )),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Accoustic",
                  style: TextStyle(
                      fontFamily: "Jakarta",
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
                GestureDetector(
                  onTap: () => Get.to(() => SeeAll("Accoustic")),
                  child: Text(
                    "See all",
                    style: TextStyle(
                      fontFamily: "Jakarta",
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: guitars
                    .where('guitarKategory', isEqualTo: "Accoustic")
                    .snapshots(),
                builder: (_, snapshot) {
                  return (snapshot.hasData)
                      ? Container(
                          height: 175,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length <= 5
                                  ? snapshot.data!.docs.length
                                  : 5,
                              itemBuilder: (context, index) {
                                DocumentSnapshot doc =
                                    snapshot.data!.docs[index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() =>
                                        Detail(doc.id, doc["guitarPrice"]));
                                  },
                                  child: Container(
                                    width: 120,
                                    margin: EdgeInsets.only(right: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        doc["guitarImage"] == ""
                                            ? Container(
                                                width: 120,
                                                height: 120,
                                                margin:
                                                    EdgeInsets.only(bottom: 10),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: FadeInImage.assetNetwork(
                                                    placeholder:
                                                        "assets/images/logo.png",
                                                    image: doc['guitarImage'],
                                                    width: 120,
                                                    height: 120),
                                              ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              doc["guitarName"],
                                              style: TextStyle(
                                                  fontFamily: "Jakarta",
                                                  fontWeight: FontWeight.w600),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Rp${doc["guitarPrice"]}",
                                              style: TextStyle(
                                                  fontFamily: "Jakarta",
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 12),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ))
                                      ],
                                    ),
                                  ),
                                );
                              }))
                      : Text("loading");
                }),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Electric",
                  style: TextStyle(
                      fontFamily: "Jakarta",
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
                GestureDetector(
                  onTap: () => Get.to(() => SeeAll("Electric")),
                  child: Text(
                    "See all",
                    style: TextStyle(
                      fontFamily: "Jakarta",
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: guitars
                    .where('guitarKategory', isEqualTo: "Electric")
                    .snapshots(),
                builder: (_, snapshot) {
                  return (snapshot.hasData)
                      ? Container(
                          height: 175,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length <= 5
                                  ? snapshot.data!.docs.length
                                  : 5,
                              itemBuilder: (context, index) {
                                DocumentSnapshot doc =
                                    snapshot.data!.docs[index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() =>
                                        Detail(doc.id, doc["guitarPrice"]));
                                  },
                                  child: Container(
                                    width: 120,
                                    margin: EdgeInsets.only(right: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        doc["guitarImage"] == ""
                                            ? Container(
                                                width: 120,
                                                height: 120,
                                                margin:
                                                    EdgeInsets.only(bottom: 10),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: FadeInImage.assetNetwork(
                                                    placeholder:
                                                        "assets/images/logo.png",
                                                    image: doc['guitarImage'],
                                                    width: 120,
                                                    height: 120),
                                              ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              doc["guitarName"],
                                              style: TextStyle(
                                                  fontFamily: "Jakarta",
                                                  fontWeight: FontWeight.w600),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Rp${doc["guitarPrice"]}",
                                              style: TextStyle(
                                                  fontFamily: "Jakarta",
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 12),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ))
                                      ],
                                    ),
                                  ),
                                );
                              }))
                      : Text("loading");
                }),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Bass",
                  style: TextStyle(
                      fontFamily: "Jakarta",
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
                GestureDetector(
                  onTap: () => Get.to(() => SeeAll("Bass")),
                  child: Text(
                    "See all",
                    style: TextStyle(
                      fontFamily: "Jakarta",
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: guitars
                    .where('guitarKategory', isEqualTo: "Bass")
                    .snapshots(),
                builder: (_, snapshot) {
                  return (snapshot.hasData)
                      ? Container(
                          height: 175,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length <= 5
                                  ? snapshot.data!.docs.length
                                  : 5,
                              itemBuilder: (context, index) {
                                DocumentSnapshot doc =
                                    snapshot.data!.docs[index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() =>
                                        Detail(doc.id, doc["guitarPrice"]));
                                  },
                                  child: Container(
                                    width: 120,
                                    margin: EdgeInsets.only(right: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        doc["guitarImage"] == ""
                                            ? Container(
                                                width: 120,
                                                height: 120,
                                                margin:
                                                    EdgeInsets.only(bottom: 10),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: FadeInImage.assetNetwork(
                                                    placeholder:
                                                        "assets/images/logo.png",
                                                    image: doc['guitarImage'],
                                                    width: 120,
                                                    height: 120),
                                              ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              doc["guitarName"],
                                              style: TextStyle(
                                                  fontFamily: "Jakarta",
                                                  fontWeight: FontWeight.w600),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Rp${doc["guitarPrice"]}",
                                              style: TextStyle(
                                                  fontFamily: "Jakarta",
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 12),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ))
                                      ],
                                    ),
                                  ),
                                );
                              }))
                      : Text("loading");
                }),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Accessories",
                  style: TextStyle(
                      fontFamily: "Jakarta",
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
                GestureDetector(
                  onTap: () => Get.to(() => SeeAll("Accessories")),
                  child: Text(
                    "See all",
                    style: TextStyle(
                      fontFamily: "Jakarta",
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: guitars
                    .where('guitarKategory', isEqualTo: "Accessories")
                    .snapshots(),
                builder: (_, snapshot) {
                  return (snapshot.hasData)
                      ? Container(
                          height: 175,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length <= 5
                                  ? snapshot.data!.docs.length
                                  : 5,
                              itemBuilder: (context, index) {
                                DocumentSnapshot doc =
                                    snapshot.data!.docs[index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() =>
                                        Detail(doc.id, doc["guitarPrice"]));
                                  },
                                  child: Container(
                                    width: 120,
                                    margin: EdgeInsets.only(right: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        doc["guitarImage"] == ""
                                            ? Container(
                                                width: 120,
                                                height: 120,
                                                margin:
                                                    EdgeInsets.only(bottom: 10),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: FadeInImage.assetNetwork(
                                                    placeholder:
                                                        "assets/images/logo.png",
                                                    image: doc['guitarImage'],
                                                    width: 120,
                                                    height: 120),
                                              ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              doc["guitarName"],
                                              style: TextStyle(
                                                  fontFamily: "Jakarta",
                                                  fontWeight: FontWeight.w600),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Rp${doc["guitarPrice"]}",
                                              style: TextStyle(
                                                  fontFamily: "Jakarta",
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 12),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ))
                                      ],
                                    ),
                                  ),
                                );
                              }))
                      : Text("loading");
                }),
          ],
        ),
      ),
    );
  }
}
