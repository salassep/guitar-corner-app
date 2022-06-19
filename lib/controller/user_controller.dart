import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/services/user_services.dart';

class AuthController extends GetxController {
  var email = "".obs;
  var pass = "".obs;
  var phone = "".obs;
  var name = "".obs;

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final rePassController = TextEditingController();

  void onRegis() {
    email.value = emailController.text;
    pass.value = passController.text;
    phone.value = phoneController.text;
    name.value = nameController.text;
  }
}

class UserController extends GetxController {
  var id = "".obs;

  void getId(data) {
    id.value = data;
  }
}

class UpdateUserController extends GetxController {
  var newEmail = "".obs;
  var pass = "".obs;
  var newPhone = "".obs;
  var newName = "".obs;
  var newImageUrl = "".obs;

  final newEmailController = TextEditingController();
  final newPhoneController = TextEditingController();
  final newNameController = TextEditingController();
  final passController = TextEditingController();

  void fillInitialController() {
    UserServices.getUserData().then((value) {
      newEmailController.text = value['email'];
      newPhoneController.text = value['phone'];
      newNameController.text = value['name'];
    });
  }

  void onUpdate() {
    newEmail.value = newEmailController.text;
    newPhone.value = newPhoneController.text;
    newName.value = newNameController.text;
    pass.value = passController.text;
    newEmailController.text = "";
    newPhoneController.text = "";
    newNameController.text = "";
  }
}

class UpdatePasswordController extends GetxController {
  final passController = TextEditingController();
  final newPassController = TextEditingController();
}
