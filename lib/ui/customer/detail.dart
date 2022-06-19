import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/controller/cart_controller.dart';
import 'package:guitar_corner_app/controller/guitar_controller.dart';
import 'package:guitar_corner_app/services/cart_service.dart';
import 'package:guitar_corner_app/services/guitar_service.dart';
import 'package:guitar_corner_app/services/like_services.dart';

class Detail extends StatelessWidget {
  String id, price;

  Detail(this.id, this.price);

  final CartController cartController = Get.put(CartController());
  final GuitarLikesController guitarLikesController =
      Get.put(GuitarLikesController());

  @override
  Widget build(BuildContext context) {
    LikeService.getLikesData(id);
    cartController.guitar_price.value = int.parse(price);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Color.fromARGB(150, 0, 0, 0)),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 20),
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                guitarLikesController.likes.value
                    ? LikeService.removeLikes(id)
                    : LikeService.giveLikes(id);
              },
              child: Obx(
                () => guitarLikesController.likes.value
                    ? Icon(
                        Icons.favorite,
                        color: Color.fromARGB(255, 1, 74, 170),
                        size: 25,
                      )
                    : Icon(
                        Icons.favorite_outline,
                        color: Color.fromARGB(200, 0, 0, 0),
                        size: 25,
                      ),
              ),
            ),
          )
        ],
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
                                height: MediaQuery.of(context).size.width - 30,
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(15)),
                              )
                            : FadeInImage.assetNetwork(
                                placeholder: "assets/images/logo.png",
                                image: snapshot.data!.get('guitarImage'),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width - 30,
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
                                      text: snapshot.data!.get(
                                          "guitarSpecification")["guitarColor"],
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
                                      text: snapshot.data!.get(
                                          "guitarSpecification")["guitarLong"],
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
                                      text: snapshot.data!.get(
                                          "guitarSpecification")["guitarType"],
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
                                          "guitarString"],
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
            }),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 30),
        padding: EdgeInsets.only(top: 15),
        color: Colors.white,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: FittedBox(
                        child: FloatingActionButton(
                          heroTag: "subtract",
                          backgroundColor: Colors.white,
                          onPressed: () {
                            cartController.decremenet();
                          },
                          child: Icon(
                            Icons.remove,
                            size: 25,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(
                      () => Text(
                        cartController.counter.value.toString(),
                        style: TextStyle(
                            fontFamily: "Jakarta", fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: FittedBox(
                        child: FloatingActionButton(
                          heroTag: "add",
                          backgroundColor: Colors.black,
                          onPressed: () {
                            cartController.increment();
                          },
                          child: Icon(
                            Icons.add,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                cartController.multiple();
                return Text(
                  "Rp${cartController.total.value}",
                  style: TextStyle(
                      fontFamily: "Jakarta", fontWeight: FontWeight.w700),
                );
              }),
            ]),
            Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  CartServices.addGuitarToCart(id);
                },
                child: Text(
                  "Add to Cart",
                  style: TextStyle(fontFamily: "Jakarta", fontSize: 12),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 1, 74, 170),
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
