import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/controller/user_controller.dart';
import 'package:guitar_corner_app/my_widgets/my_widgets.dart';
import 'package:guitar_corner_app/services/auth_service.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference users = firestore.collection("users");

class UserServices {
  static addUser() {
    final AuthController _authController = Get.find();
    try {
      users.add({
        'name': _authController.name.value,
        'email': _authController.email.value,
        'phone': _authController.phone.value,
        'image_url': ""
      });

      Get.delete<AuthController>().then((value) => Get.back());
    } catch (e) {
      MyDialog.alertDialog(e);
    }
  }

  static Future<String> getUserIdDoc() async {
    final email = await AuthServices.getCurrentEmail();

    var userIdDoc =
        await users.where("email", isEqualTo: email).get().then((value) {
      return value.docs[0].id;
    });

    return userIdDoc;
  }

  static Future getUserData() async {
    final userId = await getUserIdDoc();

    var userData = users.doc(userId).get().then((value) {
      return {
        "name": value.get("name"),
        "email": value.get("email"),
        "phone": value.get("phone"),
        "image_url": value.get("image_url")
      };
    });

    return userData;
  }

  static Future updateUser(
      String newName, String newNotelp, String newEmail, String pass) async {
    final email = AuthServices.getCurrentEmail();
    final userId = await getUserIdDoc();
    var check = true;

    if (email != newEmail) {
      check = await AuthServices.updateUserEmail(newEmail, pass)
          .then((value) => value);
    }

    if (check) {
      users.doc(userId).update({
        "name": newName,
        "phone": newNotelp,
        "email": newEmail,
      });
    }
  }

  static Future updatePictureProfile(String url_image) async {
    final userId = await getUserIdDoc();

    users.doc(userId).update({"image_url": url_image});
  }
}
