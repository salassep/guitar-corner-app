import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/controller/user_controller.dart';
import 'package:guitar_corner_app/services/auth_service.dart';
import 'package:guitar_corner_app/services/user_services.dart';
import 'package:guitar_corner_app/ui/customer/profile/change_password.dart';
import 'package:guitar_corner_app/ui/customer/profile/update_profile.dart';
import 'package:guitar_corner_app/ui/login.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  final UserController userController = Get.find();
  final UpdateUserController _updateUserController =
      Get.put(UpdateUserController());

  @override
  Widget build(BuildContext context) {
    _updateUserController.fillInitialController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        children: [
          Text(
            "Your Profile",
            style: TextStyle(
                fontFamily: "Jakarta",
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 250,
            decoration: BoxDecoration(
                color: Color.fromARGB(20, 1, 74, 170),
                borderRadius: BorderRadius.circular(20)),
            child: StreamBuilder<DocumentSnapshot>(
              stream: users.doc(userController.id.value).snapshots(),
              builder: (_, snapshot) {
                return (snapshot.hasData)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            child: ClipOval(
                              child: snapshot.data!.get("image_url") == ""
                                  ? Image.asset(
                                      "assets/images/user.png",
                                    )
                                  : FadeInImage.assetNetwork(
                                      placeholder: "assets/images/user.png",
                                      image: snapshot.data!.get("image_url")),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.data!.get("name"),
                            style: TextStyle(
                              fontFamily: "Jakarta",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            snapshot.data!.get("email"),
                            style: TextStyle(
                              fontFamily: "Jakarta",
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            snapshot.data!.get("phone"),
                            style: TextStyle(
                              fontFamily: "Jakarta",
                            ),
                          ),
                        ],
                      )
                    : CircularProgressIndicator();
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(() => UpdateProfile());
            },
            child: Text(
              "Update Profile",
              style: TextStyle(
                fontFamily: "Jakarta",
                fontSize: 14,
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 1, 74, 170),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                )),
          ),
          ElevatedButton(
            onPressed: () => Get.to(() => ChangePassword()),
            child: Text(
              "Change Password",
              style: TextStyle(
                fontFamily: "Jakarta",
                fontSize: 14,
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 1, 74, 170),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                )),
          ),
          ElevatedButton(
            onPressed: () {
              AuthServices.signOut();
              Get.off(() => Login());
            },
            child: Text(
              "Log Out",
              style: TextStyle(
                fontFamily: "Jakarta",
                fontSize: 14,
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                )),
          ),
        ],
      )),
    );
  }
}
