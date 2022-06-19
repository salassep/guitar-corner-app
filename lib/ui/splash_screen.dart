import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {

  SplashScreen({ Key? key }) : super(key: key);
  
  final SplashScreenController splashScreenController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}