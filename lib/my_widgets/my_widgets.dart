import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDialog {
  static alertDialog(text) {
    return Get.defaultDialog(
        backgroundColor: Colors.white,
        middleText: text.toString(),
        middleTextStyle: TextStyle(
          fontFamily: "Jakarta",
        ),
        radius: 30);
  }
}
