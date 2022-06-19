import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/controller/guitar_controller.dart';
import 'package:guitar_corner_app/controller/user_controller.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference likes = firestore.collection("likes");

class LikeService {
  static giveLikes(String id) {
    final UserController userController = Get.find();
    final GuitarLikesController guitarLikesController = Get.find();
    likes.add({"idUser": userController.id.value, "idGuitar": id}).then(
        (value) => guitarLikesController.setLikes(1));
  }

  static removeLikes(String id) {
    final UserController userController = Get.find();
    final GuitarLikesController guitarLikesController = Get.find();
    likes
        .where('idUser', isEqualTo: userController.id.value)
        .where('idGuitar', isEqualTo: id)
        .get()
        .then((value) {
      likes.doc(value.docs[0].id).delete();
      guitarLikesController.setLikes(0);
    });
  }

  static Future getUserFavoriteGuitar() async {
    final UserController userController = Get.find();
    final GuitarLikesController guitarLikesController = Get.find();

    var dataFavoriteGuitars = [];

    await likes
        .where('idUser', isEqualTo: userController.id.value)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        dataFavoriteGuitars.add(element.get('idGuitar'));
      });
    });

    return dataFavoriteGuitars;
  }

  static getLikesData(String id) {
    final UserController userController = Get.find();
    final GuitarLikesController guitarLikesController = Get.find();

    likes
        .where("idUser", isEqualTo: userController.id.value)
        .where("idGuitar", isEqualTo: id)
        .snapshots()
        .forEach((element) {
      guitarLikesController.setLikes(element.docs.length);
    });
  }
}
