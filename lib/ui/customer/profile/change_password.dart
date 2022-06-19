import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/controller/user_controller.dart';
import 'package:guitar_corner_app/services/auth_service.dart';
import 'package:guitar_corner_app/ui/login.dart';

class ChangePassword extends StatelessWidget {
  final UpdatePasswordController updatePasswordController =
      Get.put(UpdatePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color.fromARGB(255, 1, 74, 170),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16, left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Update Password",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: "Jakarta",
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 1.1,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        "Old Password",
                        style: TextStyle(fontFamily: "Jakarta"),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(50, 54, 60, 79),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: TextField(
                            controller: updatePasswordController.passController,
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Password Lama",
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: "Jakarta",
                                  fontWeight: FontWeight.w300),
                              border: InputBorder.none,
                              suffixIcon: const SizedBox(),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        "New Password",
                        style: TextStyle(fontFamily: "Jakarta"),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(50, 54, 60, 79),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: TextField(
                            controller:
                                updatePasswordController.newPassController,
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Password Baru",
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: "Jakarta",
                                  fontWeight: FontWeight.w300),
                              border: InputBorder.none,
                              suffixIcon: const SizedBox(),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Container(
                        width: 150,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () async {
                            var check = await AuthServices.changePassword(
                                    updatePasswordController
                                        .passController.text,
                                    updatePasswordController
                                        .newPassController.text)
                                .then((value) => value);

                            if (check) Get.off(() => Login());
                          },
                          child: Text(
                            'Simpan',
                            style: TextStyle(
                                fontFamily: "Jakarta",
                                fontWeight: FontWeight.w600),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            primary: Color.fromARGB(255, 1, 74, 170),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
