import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/services/like_services.dart';

enum CategoryInput { accoustic, bass, electric, accessories }

class AddGuitarController extends GetxController {
  var categoryInput = CategoryInput.accoustic.obs;
  var categoryName = "".obs;
  var isPublish = false.obs;
  var guitarName = "".obs;
  var guitarPrice = "".obs;
  var guitarDescription = "".obs;
  var guitarWeight = "".obs;
  var guitarColor = "".obs;
  var guitarLong = "".obs;
  var guitarMaterial = "".obs;
  var guitarStrings = "".obs;
  var guitarType = "".obs;
  var guitarImage = "".obs;

  final guitarNameController = TextEditingController();
  final guitarPriceController = TextEditingController();
  final guitarDescriptionController = TextEditingController();
  final guitarWeightController = TextEditingController();
  final guitarColorController = TextEditingController();
  final guitarLongController = TextEditingController();
  final guitarMaterialController = TextEditingController();
  final guitarStringsController = TextEditingController();
  final guitarTypeController = TextEditingController();

  void onPressed() {
    guitarName.value = guitarNameController.text;
    guitarPrice.value = guitarPriceController.text;
    guitarDescription.value = guitarDescriptionController.text;
    guitarWeight.value = guitarWeightController.text;
    guitarColor.value = guitarColorController.text;
    guitarLong.value = guitarLongController.text;
    guitarMaterial.value = guitarMaterialController.text;
    guitarStrings.value = guitarStringsController.text;
    guitarType.value = guitarTypeController.text;
  }

  void GetCategory() {
    if (categoryInput == CategoryInput.accoustic) {
      categoryName = "Accoustic".obs;
    } else if (categoryInput == CategoryInput.bass) {
      categoryName = "Bass".obs;
    } else if (categoryInput == CategoryInput.electric) {
      categoryName = "Electric".obs;
    } else {
      categoryName = "Accessories".obs;
    }
  }

  setValue(newValue) => isPublish(newValue!);

  onChanged(value) {
    categoryInput(value);
  }
}

class SearchGuitarController {
  var guitarName = "".obs;
  void searchGuitar(guitarNames) {
    guitarName.value = guitarNames;
  }
}

class GuitarLikesController {
  var likesData = [].obs;
  var likes = true.obs;

  setLikes(isLike) => isLike >= 1 ? likes.value = true : likes.value = false;

  void getArrayDataLikes() {
    LikeService.getUserFavoriteGuitar().then((data) {
      likesData.value = data;
    });
  }
}
