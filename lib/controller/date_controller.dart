import 'package:get/get.dart';

class DateController extends GetxController {
  var selectedTime = "".obs;
  var selectedDate = "".obs;

  void setStateDate(timeDate) {
    selectedDate.value = timeDate;
  }

  void setStateTime(timeValue) {
    selectedTime.value = timeValue;
  }
}
