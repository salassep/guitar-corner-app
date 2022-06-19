import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/ui/login.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: EdgeInsets.only(top: 15),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 350,
                  height: 220,
                  margin: EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/landing.png"),
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "GUITARS CORNER",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: "Jakarta",
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Pilihan Gitar terbaikmu ada disini. Order Now!",
                style: TextStyle(
                  fontFamily: "Jakarta",
                  wordSpacing: 3,
                  fontSize: 15,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Tersedia aneka gitar accoustic, electric, bass, accessoris.",
                style: TextStyle(
                  fontFamily: "Jakarta",
                  wordSpacing: 2,
                  height: 1,
                  fontSize: 13,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () => Get.off(() => Login()),
                    child: Text(
                      "BUKA APLIKASI",
                      style: TextStyle(fontFamily: "Jakarta"),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 1, 74, 170)),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 220,
                  height: 90,
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(left: 35, right: 35, top: 35),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 1, 74, 170),
                      border: Border.all(
                          color: Color.fromARGB(255, 157, 199, 233), width: 3),
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Text(
                            "Powered By Kelompok 2",
                            style: TextStyle(
                              fontFamily: "Jakarta",
                              wordSpacing: 1,
                              height: 2,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
