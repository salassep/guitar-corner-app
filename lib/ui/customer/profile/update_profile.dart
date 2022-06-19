import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/controller/user_controller.dart';
import 'package:guitar_corner_app/services/user_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;

class UpdateProfile extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UpdateUserController updateUserController = Get.find();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    await _picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        _photo = File(value.path);
        uploadFile(_photo);
      } else {
        Get.defaultDialog(middleText: "You didnt choose a picture-");
      }
    });
  }

  Future imgFromCamera() async {
    await _picker.pickImage(source: ImageSource.camera).then((value) {
      if (value != null) {
        _photo = File(value.path);
        uploadFile(_photo);
      } else {
        Get.defaultDialog(middleText: "No picture");
      }
    });
  }

  Future uploadFile(filePhoto) async {
    if (filePhoto == null) return;
    final fileName = Path.basename(filePhoto!.path);
    final destination = 'profiles/';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('$fileName');
      await ref.putFile(filePhoto!);

      String url = (await ref.getDownloadURL()).toString();

      UserServices.updatePictureProfile(url);
    } catch (e) {
      Get.defaultDialog(middleText: "Something happens");
    }
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  var isEmailChange = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Update Profile",
            style: TextStyle(
                fontFamily: "Jakarta",
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 16),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Color.fromARGB(150, 0, 0, 0)),
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/images/user.png",
                    width: 80,
                    height: 80,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () => showPicker(context),
                  child: Text(
                    "Change picture",
                    style: TextStyle(
                        fontFamily: "Jakarta",
                        color: Color.fromARGB(255, 1, 74, 170)),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name :",
                        style: TextStyle(fontFamily: "Jakarta"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: updateUserController.newNameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          isDense: true,
                          errorStyle: TextStyle(fontFamily: "Jakarta"),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 0.5,
                                  color: Color.fromARGB(150, 0, 0, 0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 1, 74, 170))),
                          focusColor: Colors.white,
                        ),
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
                      Text(
                        "Email :",
                        style: TextStyle(fontFamily: "Jakarta"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: updateUserController.newEmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          isDense: true,
                          errorStyle: TextStyle(fontFamily: "Jakarta"),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 0.5,
                                  color: Color.fromARGB(150, 0, 0, 0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 1, 74, 170))),
                          focusColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter some text";
                          }
                          return null;
                        },
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        onChanged: (value) {
                          isEmailChange = !isEmailChange;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Phone :",
                        style: TextStyle(fontFamily: "Jakarta"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: updateUserController.newPhoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          errorStyle: TextStyle(fontFamily: "Jakarta"),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 0.5,
                                  color: Color.fromARGB(150, 0, 0, 0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 1, 74, 170))),
                          focusColor: Colors.white,
                        ),
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
                      if (isEmailChange)
                        SizedBox(
                          height: 15,
                        ),
                      if (isEmailChange)
                        Text(
                          "*Because you change your email, \n so you have to input your password :",
                          style: TextStyle(fontFamily: "Jakarta"),
                        ),
                      if (isEmailChange)
                        SizedBox(
                          height: 10,
                        ),
                      if (isEmailChange)
                        TextFormField(
                          controller: updateUserController.passController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            isDense: true,
                            errorStyle: TextStyle(fontFamily: "Jakarta"),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 0.5,
                                    color: Color.fromARGB(150, 0, 0, 0))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 1, 74, 170))),
                            focusColor: Colors.white,
                          ),
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
                        height: 30,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  updateUserController.onUpdate();
                                  UserServices.updateUser(
                                      updateUserController.newName.value,
                                      updateUserController.newPhone.value,
                                      updateUserController.newEmail.value,
                                      updateUserController.passController.text);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 1, 74, 170)),
                              child: Text(
                                "Update Profile",
                                style: TextStyle(
                                    fontFamily: "Jakarta",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ))),
                    ])),
          ],
        ));
  }
}
