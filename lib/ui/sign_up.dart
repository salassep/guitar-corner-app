import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/controller/user_controller.dart';
import 'package:guitar_corner_app/services/auth_service.dart';
import 'package:guitar_corner_app/services/user_services.dart';
import 'package:guitar_corner_app/ui/login.dart';

class SignUp extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromARGB(150, 0, 0, 0)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sign Up",
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
                      controller: _authController.nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(fontFamily: "Jakarta"),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 1, 74, 170))),
                          focusColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.account_circle_outlined,
                            color: Colors.grey,
                          ),
                          hintText: "Name",
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
                      controller: _authController.phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(fontFamily: "Jakarta"),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 1, 74, 170))),
                          focusColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.grey,
                          ),
                          hintText: "Phone",
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
                      height: 15,
                    ),
                    TextFormField(
                      controller: _authController.rePassController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter some text";
                        }
                        return value != _authController.passController.text
                            ? "Password doesn't match"
                            : null;
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
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          hintText: "Re-Password",
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
                                _authController.onRegis();
                                var isSuccess = await AuthServices.createUser(
                                        _authController.emailController.text,
                                        _authController.passController.text)
                                    .then((value) => value);
                                if (isSuccess) UserServices.addUser();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 1, 74, 170)),
                            child: Text(
                              "Sign Up",
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
                      text: "Already have an account ? ",
                      style: TextStyle(
                        fontFamily: "Jakarta",
                      )),
                  TextSpan(
                      text: "Login",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.off(() => Login());
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
