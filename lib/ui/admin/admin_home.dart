import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/services/auth_service.dart';
import 'package:guitar_corner_app/ui/admin/add_guitar.dart';
import 'package:guitar_corner_app/ui/admin/list_guitar.dart';
import 'package:guitar_corner_app/ui/admin/list_orders.dart';
import 'package:guitar_corner_app/ui/admin/reports.dart';
import 'package:guitar_corner_app/ui/admin/search_bill.dart';
import 'package:guitar_corner_app/ui/login.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              "assets/images/small-logo.png",
              fit: BoxFit.contain,
            ),
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Text.rich(TextSpan(children: [
                TextSpan(
                    text: "Guitar",
                    style: TextStyle(
                        color: Color.fromARGB(255, 1, 74, 170),
                        fontFamily: "Jakarta",
                        fontWeight: FontWeight.w700)),
                TextSpan(
                    text: "corner (Admin)",
                    style: TextStyle(
                      color: Color.fromARGB(255, 1, 74, 170),
                      fontFamily: "Jakarta",
                    )),
              ])),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SafeArea(
          child: Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            margin: EdgeInsets.only(bottom: 10),
                            child: ElevatedButton(
                              onPressed: () => Get.to(() => SearchBill()),
                              child: Icon(Icons.search),
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 1, 74, 170)),
                            ),
                          ),
                          Text(
                            "Search Bill",
                            style: TextStyle(
                                fontFamily: "Jakarta",
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            margin: EdgeInsets.only(bottom: 10),
                            child: ElevatedButton(
                              onPressed: () => Get.to(() => AddGuitar()),
                              child: Icon(Icons.add),
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 1, 74, 170)),
                            ),
                          ),
                          Text(
                            "Add Guitar",
                            style: TextStyle(
                                fontFamily: "Jakarta",
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              margin: EdgeInsets.only(bottom: 10),
                              child: ElevatedButton(
                                onPressed: () => Get.to(() => ListGuitar()),
                                child: Icon(Icons.settings),
                                style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 1, 74, 170)),
                              ),
                            ),
                            Text(
                              "Manage\nGuitars",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Jakarta",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              margin: EdgeInsets.only(bottom: 10),
                              child: ElevatedButton(
                                onPressed: () => Get.to(() => ManageOrders()),
                                child: Icon(Icons.list),
                                style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 1, 74, 170)),
                              ),
                            ),
                            Text(
                              "Manage\nOrders",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Jakarta",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ]),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              margin: EdgeInsets.only(bottom: 10),
                              child: ElevatedButton(
                                onPressed: () => Get.to(() => Report()),
                                child: Icon(Icons.bookmark),
                                style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 1, 74, 170)),
                              ),
                            ),
                            Text(
                              "Transaction\nLogs",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Jakarta",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              margin: EdgeInsets.only(bottom: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  AuthServices.signOut();
                                  Get.off(() => Login());
                                },
                                child: Icon(Icons.logout),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red),
                              ),
                            ),
                            Text(
                              "Log\nOut",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Jakarta",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ]),
                ],
              ))),
    );
  }
}
