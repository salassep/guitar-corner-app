import 'dart:async';
import 'package:get/get.dart';
import 'package:guitar_corner_app/ui/landing_page.dart';
import 'package:guitar_corner_app/ui/login.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(Duration(seconds: 5), () {
      Get.off(() => LandingPage());
    });
  }
}
