import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/controller/bottom_navbar_controller.dart';
import 'package:guitar_corner_app/controller/user_controller.dart';
import 'package:guitar_corner_app/ui/customer/cart.dart';
import 'package:guitar_corner_app/ui/customer/history.dart';
import 'package:guitar_corner_app/ui/customer/home.dart';
import 'package:guitar_corner_app/ui/customer/profile/profile.dart';
import 'package:guitar_corner_app/ui/customer/search.dart';

class BottomNavbar extends StatelessWidget {
  String id;
  BottomNavbar({required this.id});
  final UserController userController =
      Get.put(UserController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    final BottomNavbarController bottomNavbarController =
        Get.put(BottomNavbarController());
    userController.getId(id);
    return Scaffold(
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
                    text: "corner",
                    style: TextStyle(
                      color: Color.fromARGB(255, 1, 74, 170),
                      fontFamily: "Jakarta",
                    )),
              ])),
            ),
          ],
        ),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 20),
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () => Get.to(() => Cart()),
              child: Icon(
                Icons.shopping_bag_outlined,
                color: Color.fromARGB(255, 1, 74, 170),
                size: 25,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Color.fromARGB(255, 1, 74, 170),
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            currentIndex: bottomNavbarController.pageIndex.value,
            onTap: bottomNavbarController.changePageIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Explore",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_activity),
                label: "Activities",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.face),
                label: "Account",
              ),
            ],
          )),
      body: Obx(() => IndexedStack(
            index: bottomNavbarController.pageIndex.value,
            children: [Home(), Search(), History(), Profile()],
          )),
    );
  }
}
