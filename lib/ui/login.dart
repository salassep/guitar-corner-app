import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/components/bottom_navbar.dart';
import 'package:guitar_corner_app/controller/user_controller.dart';
import 'package:guitar_corner_app/services/auth_service.dart';
import 'package:guitar_corner_app/services/user_services.dart';
import 'package:guitar_corner_app/ui/admin/admin_home.dart';
import 'package:guitar_corner_app/ui/sign_up.dart';

class Login extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image.asset(
                "assets/images/logo.png",
                height: 180,
                width: 180,
              )),
              SizedBox(
                height: 10,
              ),
              Text(
                "Sign In",
                style: TextStyle(
                    fontFamily: "Jakarta",
                    fontWeight: FontWeight.w700,
                    fontSize: 25),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                  key: _formKey,
                  child: Column(children: [
                    TextFormField(
                      controller: _authController.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(fontFamily: "Jakarta"),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 1, 74, 170))),
                          focusColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.alternate_email,
                            color: Colors.grey,
                          ),
                          hintText: "Email",
                          hintStyle: TextStyle(
                            fontFamily: "Jakarta",
                            fontSize: 15,
                          )),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter some text";
                        }
                        return null;
                      },
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _authController.passController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter some text";
                        }
                        return null;
                      },
                      obscureText: true,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                          errorStyle: TextStyle(fontFamily: "Jakarta"),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 1, 74, 170))),
                          focusColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.grey,
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(
                            fontFamily: "Jakarta",
                            fontSize: 15,
                          )),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                var isSuccess = await AuthServices.logIn(
                                        _authController.emailController.text,
                                        _authController.passController.text)
                                    .then((value) => value);
                                if (isSuccess) {
                                  var currentEmail =
                                      AuthServices.getCurrentEmail();
                                  currentEmail == "admin@guitarcorner.com"
                                      ? Get.off(() => AdminHome())
                                      : UserServices.getUserIdDoc()
                                          .then((value) {
                                          Get.off(
                                              () => BottomNavbar(id: value));
                                        });
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 1, 74, 170)),
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                  fontFamily: "Jakarta",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ))),
                  ])),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "New here ? ",
                      style: TextStyle(
                        fontFamily: "Jakarta",
                      )),
                  TextSpan(
                      text: "Sign Up",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.delete<AuthController>();
                          Get.to(() => SignUp());
                        },
                      style: TextStyle(
                          fontFamily: "Jakarta",
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 1, 74, 170)))
                ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
