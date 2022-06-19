import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/controller/guitar_controller.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference guitars = firestore.collection("guitars");

class GuitarServices {
  static addGuitar() {
    final AddGuitarController addGuitarController = Get.find();
    guitars.add({
      "guitarName": addGuitarController.guitarName.value,
      "guitarPrice": addGuitarController.guitarPrice.value,
      "guitarDescription": addGuitarController.guitarDescription.value,
      "guitarImage": addGuitarController.guitarImage.value,
      "guitarKategory": addGuitarController.categoryName.value,
      "guitarHighlight": addGuitarController.isPublish.value,
      "guitarSpecification": {
        "guitarWeight": addGuitarController.guitarWeight.value,
        "guitarLong": addGuitarController.guitarLong.value,
        "guitarMaterial": addGuitarController.guitarMaterial.value,
        "guitarColor": addGuitarController.guitarColor.value,
        "guitarStrings": addGuitarController.guitarStrings.value,
        "guitarType": addGuitarController.guitarType.value,
      }
    });
  }

  static updateGuitar(String id) {
    final AddGuitarController addGuitarController = Get.find();
    guitars.doc(id).update({
      "guitarName": addGuitarController.guitarName.value,
      "guitarPrice": addGuitarController.guitarPrice.value,
      "guitarDescription": addGuitarController.guitarDescription.value,
      "guitarImage": addGuitarController.guitarImage.value,
      "guitarKategory": addGuitarController.categoryName.value,
      "guitarHighlight": addGuitarController.isPublish.value,
      "guitarSpecification": {
        "guitarWeight": addGuitarController.guitarWeight.value,
        "guitarLong": addGuitarController.guitarLong.value,
        "guitarMaterial": addGuitarController.guitarMaterial.value,
        "guitarColor": addGuitarController.guitarColor.value,
        "guitarStrings": addGuitarController.guitarStrings.value,
        "guitarType": addGuitarController.guitarType.value,
      }
    });
  }
}
