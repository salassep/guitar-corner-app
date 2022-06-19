import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/controller/guitar_controller.dart';
import 'package:guitar_corner_app/services/guitar_service.dart';
import 'package:guitar_corner_app/ui/admin/admin_home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;

class AddGuitar extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AddGuitarController _addGuitarController =
      Get.put(AddGuitarController());

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
    final destination = 'guitars/';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('$fileName');
      await ref.putFile(filePhoto!);

      String url = (await ref.getDownloadURL()).toString();

      _addGuitarController.guitarImage.value = url;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Add Guitar",
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
        body: SafeArea(
            child: ListView(
          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 1, 74, 170),
                        borderRadius: BorderRadius.circular(50)),
                    child: IconButton(
                        onPressed: () => showPicker(context),
                        icon: Icon(
                          Icons.image,
                          color: Colors.white,
                        ))),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Add Guitar Picture",
                  style: TextStyle(fontFamily: "Jakarta"),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Guitar Details",
              style: TextStyle(
                  fontFamily: "Jakarta",
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Guitar Name :",
                        style: TextStyle(fontFamily: "Jakarta"),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _addGuitarController.guitarNameController,
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
                            hintText: "e.g. Yamaha 2012",
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
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Guitar Price :",
                        style: TextStyle(fontFamily: "Jakarta"),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _addGuitarController.guitarPriceController,
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
                            hintText: "e.g. 2000000",
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
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Guitar Description :",
                        style: TextStyle(fontFamily: "Jakarta"),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller:
                            _addGuitarController.guitarDescriptionController,
                        maxLines: 5,
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
                            hintText:
                                "e.g. This is the best guitar in this universe",
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
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Guitar Specifications",
                        style: TextStyle(
                            fontFamily: "Jakarta",
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Weight :",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontFamily: "Jakarta"),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    controller: _addGuitarController
                                        .guitarWeightController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        errorStyle:
                                            TextStyle(fontFamily: "Jakarta"),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                width: 0.5,
                                                color: Color.fromARGB(
                                                    150, 0, 0, 0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 1, 74, 170))),
                                        focusColor: Colors.white,
                                        hintText: "e.g. 2 Kg",
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
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.63,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Color :",
                                    style: TextStyle(fontFamily: "Jakarta"),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    controller: _addGuitarController
                                        .guitarColorController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        errorStyle:
                                            TextStyle(fontFamily: "Jakarta"),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                width: 0.5,
                                                color: Color.fromARGB(
                                                    150, 0, 0, 0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 1, 74, 170))),
                                        focusColor: Colors.white,
                                        hintText: "e.g. Blue",
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
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Long :",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontFamily: "Jakarta"),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    controller: _addGuitarController
                                        .guitarLongController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        errorStyle:
                                            TextStyle(fontFamily: "Jakarta"),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                width: 0.5,
                                                color: Color.fromARGB(
                                                    150, 0, 0, 0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 1, 74, 170))),
                                        focusColor: Colors.white,
                                        hintText: "e.g. 1.5 M",
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
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.63,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Material :",
                                    style: TextStyle(fontFamily: "Jakarta"),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    controller: _addGuitarController
                                        .guitarMaterialController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        errorStyle:
                                            TextStyle(fontFamily: "Jakarta"),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                width: 0.5,
                                                color: Color.fromARGB(
                                                    150, 0, 0, 0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 1, 74, 170))),
                                        focusColor: Colors.white,
                                        hintText: "e.g. Plastic",
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
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Strings :",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontFamily: "Jakarta"),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    controller: _addGuitarController
                                        .guitarStringsController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        errorStyle:
                                            TextStyle(fontFamily: "Jakarta"),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                width: 0.5,
                                                color: Color.fromARGB(
                                                    150, 0, 0, 0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 1, 74, 170))),
                                        focusColor: Colors.white,
                                        hintText: "e.g. 6",
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
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.63,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Type :",
                                    style: TextStyle(fontFamily: "Jakarta"),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextFormField(
                                    controller: _addGuitarController
                                        .guitarTypeController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        errorStyle:
                                            TextStyle(fontFamily: "Jakarta"),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                width: 0.5,
                                                color: Color.fromARGB(
                                                    150, 0, 0, 0))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 1, 74, 170))),
                                        focusColor: Colors.white,
                                        hintText: "e.g. Solid",
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
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Choose Category",
                        style: TextStyle(
                            fontFamily: "Jakarta",
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      ListTile(
                        textColor: Colors.black,
                        title: Text(
                          "Accoustic",
                          style: TextStyle(
                            fontFamily: "Jakarta",
                          ),
                        ),
                        leading: Obx(() => Radio<CategoryInput>(
                            fillColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 46, 93, 248)),
                            value: CategoryInput.accoustic,
                            groupValue:
                                _addGuitarController.categoryInput.value,
                            onChanged: (value) {
                              _addGuitarController.categoryInput(value);
                            })),
                      ),
                      ListTile(
                        textColor: Colors.black,
                        title: Text(
                          "Bass",
                          style: TextStyle(
                            fontFamily: "Jakarta",
                          ),
                        ),
                        leading: Obx(() => Radio<CategoryInput>(
                            fillColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 46, 93, 248)),
                            value: CategoryInput.bass,
                            groupValue:
                                _addGuitarController.categoryInput.value,
                            onChanged: (value) {
                              _addGuitarController.categoryInput(value);
                            })),
                      ),
                      ListTile(
                        textColor: Colors.black,
                        title: Text(
                          "Electric",
                          style: TextStyle(
                            fontFamily: "Jakarta",
                          ),
                        ),
                        leading: Obx(() => Radio<CategoryInput>(
                            fillColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 46, 93, 248)),
                            value: CategoryInput.electric,
                            groupValue:
                                _addGuitarController.categoryInput.value,
                            onChanged: (value) {
                              _addGuitarController.categoryInput(value);
                            })),
                      ),
                      ListTile(
                        textColor: Colors.black,
                        title: Text(
                          "Accessories",
                          style: TextStyle(
                            fontFamily: "Jakarta",
                          ),
                        ),
                        leading: Obx(() => Radio<CategoryInput>(
                            fillColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 46, 93, 248)),
                            value: CategoryInput.accessories,
                            groupValue:
                                _addGuitarController.categoryInput.value,
                            onChanged: (value) {
                              _addGuitarController.categoryInput(value);
                            })),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Do you want to highlight this guitar?",
                        style: TextStyle(
                            fontFamily: "Jakarta",
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      ListTile(
                        title: Align(
                          alignment: Alignment(-1.25, 0),
                          child: Text(
                            "Yes",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Jakarta",
                            ),
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        leading: Obx(() => Checkbox(
                              value: _addGuitarController.isPublish.value,
                              onChanged: (newValue) =>
                                  _addGuitarController.setValue(newValue),
                            )),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                              onPressed: () {
                                _addGuitarController.GetCategory();
                                _addGuitarController.onPressed();
                                GuitarServices.addGuitar();
                                Get.off(() => AdminHome());
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 1, 74, 170)),
                              child: Text(
                                "Add Guitar",
                                style: TextStyle(
                                    fontFamily: "Jakarta",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ))),
                    ])),
          ],
        )));
  }
}
